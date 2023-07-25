# Install required packages if not already installed
if (!require("shiny")) install.packages("shiny")
if (!require("OpenSpecy")) install.packages("OpenSpecy")
if (!require("dplyr")) install.packages("dplyr")
if (!require("DT")) install.packages("DT")
if (!require("progress")) install.packages("progress")

library(shiny)
library(OpenSpecy)
library(dplyr)
library(DT)
library(progress)

# Fetch FTIR library
get_lib()

# Load FTIR library into global environment
spec_lib <- load_lib()

# ... (Previous code remains unchanged)

# Define UI
ui <- fluidPage(
  titlePanel("OpenSpecy Spectral Analysis"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload a file:",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv",
                  ".asp",
                  ".jdx",
                  ".spc",
                  ".spa",
                  ".0"
                )
      ),
      tags$small("Accepted file types: CSV, ASP, JDX, SPC, SPA, 0"),
      downloadButton("download_example", "Download Example Dataset")  # Add the Download button
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Results Table", DT::dataTableOutput("table")),
        tabPanel("Help", 
                 p("Welcome to the OpenSpecy Spectral Analysis App!"),
                 p("Common Issues:"),
                 ol(
                   li("Ensure you upload a file with one of the supported extensions: CSV, ASP, JDX, SPC, SPA, 0."),
                   li("For intensity smoothing and background correction, input valid values within the specified ranges (1 to 7 for smoothing, 1 to 20 for background)."),
                   li("If the results table is empty, the uploaded spectrum may not match any spectra in the FTIR library."),
                   li("Check your internet connection and ensure all required packages are installed and loaded correctly."),
                   li("Large datasets or a high number of combinations can increase processing time."),
                   li("Refer to the app's documentation and error messages for additional troubleshooting."),
                   li("In case of R session crashes, consider using smaller datasets or optimizing system resources.")
                 )
        )
      )
    )
  )
)


# Define server logic
server <- function(input, output) {
  data <- reactiveVal(NULL)
  
  observeEvent(input$file, {
    progress <- Progress$new(session = shiny::getDefaultReactiveDomain(), min = 0, max = 100)
    progress$set(message = 'Processing data...')
    
    spec_data <- reactive({
      req(input$file)
      file_extension <- tools::file_ext(input$file$name)
      if (file_extension %in% c("csv", "CSV")) {
        read.csv(input$file$datapath, header = TRUE, stringsAsFactors = FALSE)
      } else if (file_extension %in% c("asp", "ASP")) {
        OpenSpecy::read_asp(input$file$datapath)
      } else if (file_extension %in% c("jdx", "JDX")) {
        OpenSpecy::read_jdx(input$file$datapath)
      } else if (file_extension %in% c("spc", "SPC")) {
        OpenSpecy::read_spc(input$file$datapath)
      } else if (file_extension %in% c("spa", "SPA")) {
        OpenSpecy::read_spa(input$file$datapath)
      } else if (file_extension %in% c("0")) {
        OpenSpecy::read_0(input$file$datapath)
      } else {
        # File type not supported
        stop(paste0("Unsupported file type: ", file_extension))
      }
    })()
    
    # Adjust spectral intensity
    adj_data <- spec_data %>% adj_intens()
    progress$inc(10, detail = "Adjusted spectral intensity")
    
    # Test if Raman or FTIR 
    testraman <- match_spec(spec_data, library = spec_lib, which = "raman")
    testftir <- match_spec(spec_data, library = spec_lib, which = "ftir")
    
    testraman <- head(testraman, 1)
    testftir <- head(testftir, 1)
    
    if (!is.null(testraman) && !is.null(testftir)) {
      if (testraman$rsq > testftir$rsq) {
        spectrum_type <- "Raman"
      } else {
        spectrum_type <- "FTIR"
      }
    } else if (!is.null(testraman)) {
      spectrum_type <- "Raman"
    } else if (!is.null(testftir)) {
      spectrum_type <- "FTIR"
    } else {
      spectrum_type <- "Unknown"
    }
    progress$inc(10, detail = "Identified spectrum type")
    
    # Create a vector of smoothing factors
    smoothing_factors <- 1:7
    
    # Create a vector of subtr_bg values
    subtr_bg_values <- 1:20
    
    # Initialize an empty data frame to store the results
    results <- data.frame(
      smooth_intens = integer(),
      subtr_bg = integer(),
      top_result = character(),
      type = character(),
      stringsAsFactors = FALSE
    )
    
    for (factor in smoothing_factors) {
      for (subtr_bg_value in subtr_bg_values) {
        # Smooth and background-correct spectrum with current smoothing factor and subtr_bg value
        proc_data <- adj_data %>% smooth_intens(factor) %>% subtr_bg(subtr_bg_value)
        
        if (spectrum_type == "Raman") {
          # Match spectrum with library and retrieve meta data for Raman
          match_result_raman <- match_spec(proc_data, library = spec_lib, which = "raman")
          
          # Retrieve the top displayed result for Raman
          top_raman <- head(match_result_raman, 1)
          
          # Create data frames for each smoothing factor and subtr_bg value
          results_raman <- data.frame(
            smooth_intens = factor,
            subtr_bg = subtr_bg_value,
            top_result = top_raman,
            type = "Raman",
            stringsAsFactors = FALSE
          )
          
          # Append the data frames to the results data frame
          results <- rbind(results, results_raman)
        } else if (spectrum_type == "FTIR") {
          # Match spectrum with library and retrieve meta data for FTIR
          match_result_ftir <- match_spec(proc_data, library = spec_lib, which = "ftir")
          
          # Retrieve the top displayed result for FTIR
          top_ftir <- head(match_result_ftir, 1)
          
          # Create data frames for each smoothing factor and subtr_bg value
          results_ftir <- data.frame(
            smooth_intens = factor,
            subtr_bg = subtr_bg_value,
            top_result = top_ftir,
            type = "FTIR",
            stringsAsFactors = FALSE
          )
          
          # Append the data frames to the results data frame
          results <- rbind(results, results_ftir)
        }
      }
    }
    progress$inc(70, detail = "Processed all combinations")
    progress$close()
    
    # Update the results table
    output$table <- DT::renderDataTable({
      DT::datatable(results, 
                    colnames = c("Smoothing Intensity", "Baseline Correction", "Sample Name", 
                                 "Spectrum Identity", "R-Value", "Organization", "Spectrum Type"))
    })
  })
  
  # Function to serve the example dataset for download
  output$download_example <- downloadHandler(
    filename = function() {
      "testdata.csv"  # Set the name of the downloaded file
    },
    content = function(file) {
      write.csv(example_data, file, row.names = FALSE)  # Write the example dataset to the CSV file
    }
  )
}

# Run the application
shinyApp(ui = ui, server = server)
