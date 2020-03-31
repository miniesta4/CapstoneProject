
# v202003311652
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Text Prediction"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Prediction is made just on words.", 
               "Profanity words are ignored."),
      textInput("entrada", h3("Enter text:"), value = "")
    ),
    
    mainPanel(
      p("First line shows the text used for prediction.", 
        "Second line is the prediction result."),
      div(textOutput("entered"), style = "color:blue"),
      div(textOutput("predicted"), style = "color:blue")
    )
  )
))
