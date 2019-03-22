library(shiny)
### Use input to create a string    
my.server <- shinyServer(function(input, output) {
  
  # You can access the value of the widget with input$select, e.g.
  output$userText <- renderText({
    return(paste0('The user typed: ', input$text))
  })
  
})

shinyServer(my.server)