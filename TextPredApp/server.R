
# v202003311644
library(shiny)

shinyServer(function(input, output) {
  
  source("./Utils.R")

  output$entered <- renderText({
      paste("Entered:", input$entrada)
  })
  
  output$predicted <- renderText({
    req(input$entrada)
    texto <- input$entrada
    validate(
      need(grep(" $", texto) == 1, 
           message = "Enter please a space character to get prediction.")
    )
    predice_texto(texto)  
  })
})
