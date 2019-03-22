library(shiny)
library(ggplot2)
library(dplyr)
library(rsconnect)

# setwd("~/../Desktop/School Stuff/Senior Year 2017-2018/Homework Fall Quarter 2017/INFO 201/Assignment 8 - Building Apps/a8-shiny-RGPeart")

cereal.data <- read.delim("data/cereal.tsv")

options(shiny.sanitize.errors = FALSE)
  
# Define server logic required to draw a histogram
my.server <- shinyServer(function(input, output) {
  
  output$value <- renderPrint({
    input$selectAllNutrition
  })
  
  output$slide.value <- renderPrint({
    input$slider
  }) 
  
  output$distPlot <- renderPlot({
    # draw the histogram with the specified number of bins
    hist(cereal.data[ , input$selectAllNutrition], 
         breaks = input$slider,
         main = paste0(toupper(substr(input$selectAllNutrition, 1, 1)), substr(input$selectAllNutrition, 2, nchar(input$selectAllNutrition))),
         xlab = "Amount",
         col = "dark orange")
  })
  
############################ Second Set of Widgets ############################
    
  output$mfrSelect <- renderPrint({
    input$mfrSelect
  })
  
  output$mfrNutritionSelect <- renderPrint({
    input$selectManufactureNutrition
  })
  
  # Renders a scatterplot showing the cereal ratings given the cereal manufacturer
  output$bar <- renderPlot({
    mfr.name <- ""
    if(input$mfrSelect == "A") {
      mfr.name <- "American Home Food Products"
    }else if(input$mfrSelect == "G") {
      mfr.name <- "General Mills"
    } else if(input$mfrSelect == "K") {
      mfr.name <- "Kellogg's"
    }else if(input$mfrSelect == "N") {
      mfr.name <- "Nabisco"
    }else if(input$mfrSelect == "P") {
      mfr.name <- "Post"
    } else if(input$mfrSelect == "Q") {
      mfr.name <- "Quaker"
    }else {   # "Must be "R"
      mfr.name <- "Ralston"
    }

    mfr.data <- cereal.data %>% filter(mfr == input$mfrSelect)
    
    ggplot(mfr.data, aes(name, mfr.data[, input$selectManufactureNutrition], fill = name)) + 
           geom_col() +     
           ggtitle(paste0("Cereal Information for ", mfr.name)) +
           labs(x = "Cereal Name", y = input$selectManufactureNutrition) +
           theme(legend.position = "none", axis.text.x = element_text(angle = 60, hjust = 1, vjust = 0.90))
  })
  
})
