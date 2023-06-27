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
      actionButton("analyze", "Analyze"),
      downloadButton("download", "Download Results")
    ),
    mainPanel(
      DT::dataTableOutput("table")
    )
  )
)

# Define server logic
server <- function(input, output) {
  data <- reactive({
    req(input$file)
    file_extension <- tools::file_ext(input$file$name)
    
    if (grepl(".csv", file_extension)) {
      read.csv(input$file$datapath, header = TRUE, stringsAsFactors = FALSE)
    } else if (grepl(".asp|.jdx|.spc|.spa|.0", file_extension)) {
      # Read other file types using appropriate functions
      # Add your code here to handle the specific file types
      # For example, you can use functions like read_asp(), read_jdx(), etc.
    } else {
      # File type not supported
      stop("Unsupported file type.")
    }
  })
  
  observeEvent(input$analyze, {
    req(input$file)
    spec_data <- data()
    
    # Adjust spectral intensity
    raman_adj <- spec_data %>% adj_intens()
    
    # Smooth and background-correct spectrum
    raman_proc <- raman_adj %>% smooth_intens() %>% subtr_bg()
    
    # Match spectrum with library and retrieve meta data
    match_result <- match_spec(raman_proc, library = spec_lib, which = "raman")
    
    # Print the matched spectrum
    print(match_result)
    
    # Update the data table
    output$table <- DT::renderDataTable({
      match_result
    })
  })
  
  output$download <- downloadHandler(
    filename = function() {
      paste("spectral_analysis_results", "csv", sep = ".")
    },
    content = function(file) {
      req(input$analyze)
      spec_data <- data()
      spectrum <- OpenSpecy::spectrum_analysis(spec_data)
      write.csv(spectrum, file, row.names = FALSE)
    }
  )
}

# Run the application
shinyApp(ui = ui, server = server)
