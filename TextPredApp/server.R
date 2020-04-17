
# v202004171555
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
           message = "Enter please a white space character to get a prediction.")
    )
    predice_texto(texto)  
  })
})
