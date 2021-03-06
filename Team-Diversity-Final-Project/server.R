library("shiny")
library("dplyr")
library("data.table")
library("ggplot2")
library("TTR")
library("quantmod")
library("Quandl")

# library("httr")
# library("jsonlite")

options(shiny.sanitize.errors = FALSE)

# Get your API key from quandl.com
quandl_api = "LyjxCY3XxHfkd29FAFJy"
# nyt_api = "cb851da8bc284774b29271c7d7e1ff0f"

# Add the key to the Quandl keychain
Quandl.api_key(quandl_api)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Fetches the Individual Stock's Information Given the Ticker Symbol, the Starting Date, and the Ending Date
  google_stocks <- function(sym, start_date, end_date) {
    require(devtools)
    require(Quandl)
    
    # create a vector with all lines
    google_out = tryCatch(Quandl(c(
      paste0("WIKI/", sym, ".8"),  #  Adj. Open
      paste0("WIKI/", sym, ".9"),  # Adj. High
      paste0("WIKI/", sym, ".10"), # Adj. Low
      paste0("WIKI/", sym, ".11"), # Adj. Close
      paste0("WIKI/", sym, ".12")), # Adj. Volume
      start_date = start_date,
      type = "zoo"
    ))
    start_date <- as.Date(start_date)
    end_date <- as.Date(end_date)
    google_out <- as.data.frame(google_out) %>% 
                  tibble::rownames_to_column()
    names(google_out) <- c("Date", "Open", "High", "Low", "Close", "Volume")

    google_out <- filter(google_out, start_date <= as.Date(Date, format = "%Y-%m-%d") & end_date >= as.Date(Date, format = "%Y-%m-%d"))
    return(google_out)
  }
  
  # Grabs the start date and end date that the user wishes to use
  get.information <- function(Name, Date) {
    date_vector <- Date 
    start_date <- date_vector[1]
    end_date <- date_vector[2]
    chosen_stock_info <- google_stocks(Name, start_date, end_date)
    return(chosen_stock_info)
  }
  
#  news_date_vector <- input$Date
#  news_start_date <- news_date_vector[1]
#  news_end_date <- news_date_vector[2]
  
#  base.news.url <- "https://api.nytimes.com/svc/search/v2/articlesearch.json"
#  query.params <- list(q = "MSFT", start = "20170101", 'api-key' = nyt_api)
#  get.news <- GET(base.news.url, query = query.params)
#  news.body <- content(get.news, "text")
#  news.results <- fromJSON(news.body)
  
  

  # Outputs the minimum stock price and date of an individual stock
  output$min <- renderText({
     chosen_stock_info <- get.information(input$Name, input$Date)
     min <- filter(chosen_stock_info, Close == min(Close))
     min.close <- min$Close
     min.date <- min$Date
     paste0("The minimum was ", min.close, " on ", min.date)
  })
  
  # Outputs the maxium stock price and date of an individual stock
  output$max <- renderText({
     chosen_stock_info <- get.information(input$Name, input$Date)
     max <- filter(chosen_stock_info, Close == max(Close))
     max.close <- max$Close
     max.date <- max$Date
     paste0("The maximum was ", max.close, " on ", max.date) 
  })
  
  # Plots the Individual Stock Information
  output$distPlot <- renderPlot({
    chosen_stock_info <- get.information(input$Name, input$Date)
    chosen_stock_info$Date <- as.Date(chosen_stock_info$Date, format = "%Y-%m-%d")
    ggplot(chosen_stock_info, aes(x = Date, y = Close, group = 1)) +
      geom_point(aes(color = Volume)) +
      geom_line() +
      ggtitle(paste0(input$Name,  " Information"))
  })
  
#  # Fetches the Stock Information (Name, Ticker, Industry, etc.)
#  listings <- read.table("http://www.sharadar.com/meta/tickers.txt", sep = "\t", header = TRUE)
#  get.stock.ticker <- function(stock.name) {
#    stock.ticker <- listings %>% filter(grepl(stock.name, listings$Name)) %>% select(Ticker, Name)
#    return(stock.ticker)
#  }
  
  # Outputs the text of the stock ticker
  output$stock.df <- renderDataTable({
    stock.ticker <- get.stock.ticker(input$text)
  })
  
  ####### Overall Tab #######
  
  # Fetches the S&P 500 Data from a certain date to current date
  sp500 <- new.env()
  sp500.data <- function(start.date) {
    df <- getSymbols("^GSPC", src = "yahoo", from=start.date, to=Sys.Date())
    SPC <- data.frame(GSPC$GSPC.Close, GSPC$GSPC.Volume)
    SPC <- as.data.frame(SPC) %>% 
           tibble::rownames_to_column()
    colnames(SPC) <- c("Date", "Close", "Volume")
    SPC$Date <- as.Date(SPC$Date, format = "%Y-%m-%d")
    return(SPC)
  }
  
   # Fetches the Dow Jones Data from a certain date to current date
  dowjones<- new.env()
  dow.jones.data <- function(start.date) {
     df <- getSymbols("^DJI", env = dowjones, src = "yahoo", from=start.date, to=Sys.Date())
     djia <- dowjones$DJI
     DJIA <- data.frame(djia$DJI.Close, djia$DJI.Volume)
     DJIA <- as.data.frame(DJIA) %>%
             tibble::rownames_to_column()
     colnames(DJIA) <- c("Date", "Close", "Volume")
     DJIA$Date <- as.Date(DJIA$Date, format = "%Y-%m-%d")
     return(DJIA)
  }
  
  # Fetches the NASDAQ Data from a certain date to current date
  nasdaq <- new.env()
  nasdaq.data <- function(start.date) { 
     df <- getSymbols("^NDX", env = nasdaq, src = "yahoo", from=start.date, to=Sys.Date())
     ndx <- nasdaq$NDX
     NDX <- data.frame(ndx$NDX.Close, ndx$NDX.Volume)
     NDX <- as.data.frame(NDX) %>%
            tibble::rownames_to_column()
     colnames(NDX) <- c("Date", "Close", "Volume")
     NDX$Date <- as.Date(NDX$Date, format = "%Y-%m-%d")
     return(NDX)
  }
  
  find.date <- function() {
    date <- 0
    if(input$radio == 1) {
      date <- 7
    }else if(input$radio == 2) {
      date <- 30
    }else if(input$radio == 3) {
      date <- 188
    }else if(input$radio == 4) {
      date <- 365
    }else if(input$radio == 5) {
      date <- 365 * 5
    }else {
      date <- 365 * 100
    }
    return(date)
  }
  
  # Plots the S&P 500 Information
  output$sp500 <- renderPlot({
     date <- find.date()
     sp.data <- sp500.data(Sys.Date() - date)
     ggplot(sp.data, aes(x = Date, y = Close, group = 1)) +
           geom_point(aes(color = Volume)) +
           geom_line() +
           ggtitle("S&P 500 Data")
  })
  
  # Plots the Dow Jones Information 
  output$dow_jones <- renderPlot({
     date <- find.date()
     dj.data <- dow.jones.data(Sys.Date() - date)
     ggplot(dj.data, aes(x = Date, y = Close, group = 1)) +
           geom_point(aes(color = Volume)) +
           geom_line() +
           ggtitle("Dow Jones Industrial Average Data")
  })
  
  # Plots the NASDAQ Information
  output$nasdaq <- renderPlot({
     date <- find.date()
     nasdaq.data <- nasdaq.data(Sys.Date() - date)
     ggplot(nasdaq.data, aes(x = Date, y = Close, group = 1)) +
            geom_point(aes(color = Volume)) +
            geom_line() +
            ggtitle("NASDAQ-100 Market Index Data")
  })
  
  ####### Comparison Tab  #######
  
  output$comparison.plot <- renderPlot({
      
      stock_1 <- get.information(input$Name_1, input$Date.guy)
      stock_1$Date <- as.Date(stock_1$Date, format = "%Y-%m-%d")
      
      stock_2 <- get.information(input$Name_2, input$Date.guy)
      stock_2$Date <- as.Date(stock_2$Date, format = "%Y-%m-%d")
      
      combined_data <- data.frame(rbind(stock_1, stock_2))
      
      ggplot() +
         geom_point(data = stock_1, aes(x = Date, y = Close, col = "Red")) + 
         geom_line(data = stock_1, aes(x = Date, y = Close, col = "Red")) +
         geom_point(data = stock_2, aes(x = Date, y = Close, col = "Blue")) +
         geom_line(data = stock_2, aes(x = Date, y = Close, col = "Blue")) +
         scale_color_hue(labels = c(input$Name_2, input$Name_1))
     
  })
  
  ####### Sector Tab  #######
  
#  output$sector.plot <- renderPlot({
    
#     sector.data <- function(sector) {
#       df <- listings %>% filter(Sector == sector)
#       return(df)
#     }
     
#     basic.materials.df <- sector.data("Basic Materials")
#     consumer.goods.df <- sector.data("Consumer Goods")
#     financial.df <- sector.data("Financial")
#     healthcare.df <- sector.data("Healthcare")
#     industrial.goods.df <- sector.data("Industrial Goods")
#     services.df <- sector.data("Services")
#     technology.df <- sector.data("Technology")
#     utilities.df <- sector.data("Utilities")
     
#     top.five.sector <- function(df) {
#        options(warn = -1)
#        top_five <- data.frame(matrix(nrow = nrow(df), ncol = 7))
#        colnames(top_five) <- c("Date", "Open", "High", "Low", "Close", "Volume", "Symbol")
#        for(i in nrow(df)) {
#           stock.symbol <- df[i, 1]
#           if(nrow(google_stocks(stock.symbol, Sys.Date() - 2, Sys.Date())) != 0) {
#              stock.info <- google_stocks(stock.symbol, Sys.Date() - 2, Sys.Date())
#              top_five[i, 1:6] <- stock.info
#              top_five[i, 7] <- stock.symbol
#           }
#        }
#        return(top_five)
#     }
     
#    bm.top.five <- top.five.sector(basic.materials.df)
     
#  })
  
})
