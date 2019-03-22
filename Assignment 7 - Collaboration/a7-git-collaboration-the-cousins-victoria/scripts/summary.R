library(dplyr)
# Function that returns a list of general information about the data set
# also calculates 3 values and returns these as well.
info_function <- function(dataset) {
  ret <- list()
  ret$number.of.circles <- tally(dataset, Shape == "Circle")
  ret$avg.latitude <- summarize(dataset, mean(lat))
  ret$percent.usa <- tally(dataset, Country == "USA") / nrow(dataset) * 100 %>% round(1)
  ret$rows <- nrow(dataset)
  ret$columns <- ncol(dataset)
  ret$dimensions <- dim(dataset)
  ret$col.names <- colnames(dataset)
  ret$row.names <- rownames(dataset)
  return(ret)
}
