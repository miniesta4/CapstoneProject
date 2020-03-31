
# v202003311644
library(shiny)

shinyServer(function(input, output) {
  
  source("./Utils.R")

  output$entered <- renderText({
    paste("Entered:", input$entrada)
  })
  
  output$predicted <- renderText({
    req(input$entrada)
    predice_texto(input$entrada)
  })
  
})
