
# v202004161020
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Word Prediction"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("The prediction is made on the last three words at most.", 
               "Profanity words are ignored.",
               "Type some text followed by a white space."
               ),
      textInput("entrada", h3("Enter text:"), value = "")
    ),
    
    mainPanel(
      em("Coursera Capstone Project by M. Iniesta (2020-04-16)"), 
      br(), br(),
      p("The first line shows the text entered for prediction."),
      p("The second line is the predicted word."),
      div(textOutput("entered"), style = "color:blue"),
      div(textOutput("predicted"), style = "color:blue")
    )
  )
))
