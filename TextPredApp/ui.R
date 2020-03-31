
# v202003311233

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Text Prediction"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Texto de ayuda."),
      textInput("entrada", h3("Enter text"), value = "")
    ),
    
    mainPanel(
       textOutput("entered"),
       textOutput("predicted")
    )
  )
))
