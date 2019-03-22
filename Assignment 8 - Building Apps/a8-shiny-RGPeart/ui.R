## RUN APP ON UI!

library(shiny)
library(dplyr)
library(rsconnect)

# Define UI for application that draws a histogram
my.ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Cereal Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    
    sidebarPanel(
      
      # Creates a dropdown box allowing the user to choose nutritional information
      selectInput("selectAllNutrition", label = h3("Select Nutritional Information of All Cereals:"), 
                  choices = colnames(cereal.data)[4:12]
                 ),
      
      # Creates a slider that allows the user to choose the number of bins the values fall into
      sliderInput("slider", label = h5("Select Range of Breakpoints:"),
                  min = 1,
                  max = 50,
                  value = 25
                 ),
      hr(),
      
      # Creates a dropdown box allowing the user to choose manufacturer
      selectInput("mfrSelect", label = h3("Select Manufacturer:"),
                  choice = cereal.data %>% group_by(mfr) %>% summarize()
                 ),
      
      # Creates a second dropdown box allowing the user to pick a certain value given the manufacturer
      selectInput("selectManufactureNutrition", label = h5("Select Informational Value by Manufacturer:"), 
                  choices = as.character(colnames(cereal.data)[4:ncol(cereal.data)])
                 )
    ),
  
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"),
       plotOutput("bar")
    )
  
  )
  
))
