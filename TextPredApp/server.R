
# v202003311230

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  source("./Utils.R")

  predice <- reactive({
    req(input$entrada)
    ent <- input$entrada
    predice_texto(ent)
    }) 
  
  output$entered <- renderText({
    paste("Entered: ", input$entrada)
  })
  
  output$predicted <- renderPrint({
     paste(predice())
  })
  
})
