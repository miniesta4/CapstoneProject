
# v202003311855
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Text Prediction"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("The prediction is made on the last three words at most.", 
               "Profanity words are ignored."),
      textInput("entrada", h3("Enter text:"), value = "")
    ),
    
    mainPanel(
      em("Coursera Capstone Project by M. Iniesta (2020-04-01)"), 
      br(),
      p("The first line shows the text entered for the prediction.", 
        "The second line is the prediction result."),
      div(textOutput("entered"), style = "color:blue"),
      div(textOutput("predicted"), style = "color:blue")
    )
  )
))
