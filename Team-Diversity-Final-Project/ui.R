library(shiny)
library(dplyr)
library(shinythemes)
library(rmarkdown)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("superhero"),
                  
  # Application title
  titlePanel("Stock Analysis"),
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    
  tabsetPanel( 
    tabPanel(
      "Background", 
      includeMarkdown("background[1904].md")
    ),
    
    tabPanel(
      "Individual Stock",
      sidebarLayout(
         sidebarPanel(
           
            textInput("Name", label = h3("Stock Ticker:"), value = "TSLA"),
            
            dateRangeInput("Date", label = h3("Date:"), start = "2017-11-29", end = Sys.Date()),
            
            hr(),
            
            textInput("text", label = h5("Enter Name of Company to Receive Ticker Information"),
                      value = "Enter Company Name")
            
         ),
         mainPanel(
           plotOutput("distPlot"),
           hr(),
           textOutput("min"),
           textOutput("max"),
           hr(),
           dataTableOutput("stock.df")
         )
      )
    ),
    
    tabPanel(
      "Overview",
       sidebarLayout(
          sidebarPanel(
            radioButtons("radio", label = h3("Select Timeline"),
                         choices = list("5 Day" = 1, "1 Month" = 2, "6 Month" = 3,
                                        "1 Year" = 4, "5 Year" = 5, "Max" = 6),
                         selected = 3)
          ),
          mainPanel(
            plotOutput("sp500"),
            plotOutput("dow_jones"),
            plotOutput("nasdaq")
          )
      )
    ),
    
    tabPanel(
       "Comparison",
       sidebarLayout(
          sidebarPanel(
            textInput("Name_1", label = h3("Stock Ticker 1 (Shown in Blue):"), value = "TSLA"),
            
            textInput("Name_2", label = h3("Stock Ticker 2 (Shown in Red):"), value = "AAPL"),
            
            dateRangeInput("Date.guy", label = h3("Date:"), start = "2017-11-29", end = Sys.Date())
            
          ),
          mainPanel(
            plotOutput("comparison.plot") 
          )
       )
#    ),
    
#    tabPanel(
#       "Sector Leaders",
#       sidebarLayout(
#          sidebarPanel(
#            checkboxGroupInput("check.sector", label = h3("Check Sector(s)"),
#                        choices = list("Basic Materials" = 1, "Consumer Goods" = 2, "Financial" = 3,
#                                       "Healthcare" = 4, "Industrial Goods" = 5, "Services" = 6,
#                                       "Technology" = 7, "Utilities" = 8)
#                        ),
#            selected = 1
#          ),
#          mainPanel(
#            plotOutput("sector.plot")
#          )
#        )
#      )
#    )
   )
))))
