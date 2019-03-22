# Exercise 1: Data Frame Practice

# Install devtools package: allows installations from GitHub
install.packages('devtools')

# Install "fueleconomy" package from GitHub
devtools::install_github("hadley/fueleconomy")

# Require/library the fueleconomy package

library(fueleconomy)

# You should have have access to the `vehicles` data.frame

cars <- data.frame(vehicles)

# Create a data.frame of vehicles from 1997

library(dplyr)
cars1997  <- cars[cars$year == "1997", ]

# Use the `unique` function to verify that there is only 1 value in the `year` column of your new data.frame

unique(cars1997$year)

# Create a data.frame of 2-Wheel Drive vehicles that get more than 20 miles/gallon in the city

twoWheelDrive <- cars[cars$drive == "2-Wheel Drive", ]
twoWheelAndtwentyMiles <- twoWheelDrive[twoWheelDrive$cty > 20, ]

OR

two.wheel.20.mpg <- cars[cars$drive == '2-Wheel Drive' & cars$city > 20]

# Of those vehicles, what is the vehicle ID of the vehicle with the worst hwy mpg?

worst_hwy_mpg_id <- twoWheelAndtwentyMiles[min(twoWheelAndtwentyMiles$hwy), "id"]

# Write a function that takes a `year` and a `make` as parameters, and returns 
# The vehicle that gets the most hwy miles/gallon of vehicles of that make in that year

most_hwy <- function(year, make) {
  return 
}

# What was the most efficient honda model of 1995?


