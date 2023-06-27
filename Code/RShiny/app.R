# Install required packages if not already installed
if (!require("shiny")) install.packages("shiny")
if (!require("OpenSpecy")) install.packages("OpenSpecy")
if (!require("dplyr")) install.packages("dplyr")
if (!require("DT")) install.packages("DT")

library(shiny)
library(OpenSpecy)
library(dplyr)
library(DT)

# Fetch FTIR library
get_lib()

# Load FTIR library into global environment
spec_lib <- load_lib()

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
      actionButton("analyze", "Analyze")
    ),
    mainPanel(
      DT::dataTableOutput("table"),
      br(),
      h4("Result:"),
      verbatimTextOutput("result")
    )
  )
)

# Define server logic
server <- function(input, output) {
  data <- reactive({
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
  })
  
  observeEvent(input$analyze, {
    req(input$file)
    spec_data <- data()
    
    # Adjust spectral intensity
    adj_data <- spec_data %>% adj_intens()
    
    # Smooth and background-correct spectrum
    proc_data <- adj_data %>% smooth_intens() %>% subtr_bg()
    
    # Match spectrum with library and retrieve meta data
    match_result_raman <- match_spec(proc_data, library = spec_lib, which = "raman")
    match_result_ftir <- match_spec(proc_data, library = spec_lib, which = "ftir")
    
    # Determine the type of spectra based on the highest "r" value
    if (!is.null(match_result_raman) && !is.null(match_result_ftir)) {
      max_r_raman <- max(match_result_raman$r)
      max_r_ftir <- max(match_result_ftir$r)
      
      if (max_r_raman > max_r_ftir) {
        match_result <- match_result_raman
        spectrum_type <- "Raman"
      } else {
        match_result <- match_result_ftir
        spectrum_type <- "FTIR"
      }
    } else if (!is.null(match_result_raman)) {
      match_result <- match_result_raman
      spectrum_type <- "Raman"
    } else if (!is.null(match_result_ftir)) {
      match_result <- match_result_ftir
      spectrum_type <- "FTIR"
    } else {
      match_result <- NULL
      spectrum_type <- "Unknown"
    }
    
    # Check if data was processed or unprocessed
    if (is.null(match_result)) {
      data_status <- "Unprocessed"
    } else {
      data_status <- "Processed"
    }
    
    # Check if the region selected was full spectrum or peaks
    region_status <- ifelse(length(unique(match_result$Region)) > 1, "Peaks", "Full Spectrum")
    
    # Print the matched spectrum
    print("Matched Spectrum:")
    print(match_result)
    
    # Update the data table
    output$table <- DT::renderDataTable({
      match_result
    })
    
    # Update the result text output
    output$result <- renderText({
      paste("Spectrum Type:", spectrum_type, "\n",
            "Data Status:", data_status, "\n",
            "Region Status:", region_status)
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)
