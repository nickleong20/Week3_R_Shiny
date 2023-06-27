library(shiny)

ui <- fluidPage(
  selectInput("language", label = "Language", choices = c("Python", "C++", "Java")),
  textOutput("message")
)

server <- function(input, output) {
  output$message <- renderText({ 
    paste("You have selected", input$language)
  })
}

shinyApp(ui, server)