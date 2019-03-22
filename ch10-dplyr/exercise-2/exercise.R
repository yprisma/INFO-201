# Exercise 2: Data Frame Practice with `dplyr`.
# Use a different appraoch to accomplish the same tasks as exercise-1

# Install devtools package: allows installations from GitHub
install.packages('devtools')

# Install "fueleconomy" package from GitHub
devtools::install_github("hadley/fueleconomy")

# Require/library the fueleconomy package

library(fueleconomy)

# Install (if you haven't already) and load the `dplyr`package

library(dplyr)

# You should have have access to the `vehicles` data.frame

View(vehicles)

# Create a data.frame of vehicles from 1997

cars_1997 <- filter(vehicles, year == 1997)

# Use the `unique` function to verify that there is only 1 value in the `year` column of your new data.frame

unique(cars_1997$year)

# Create a data.frame of 2-Wheel Drive vehicles that get more than 20 miles/gallon in the city

two_wheel_twenty_miles <- filter(vehicles, 
                                 drive == '2-Wheel Drive', 
                                 cty > 20)

# Of those vehicles, what is the vehicle ID of the vehicle with the worst hwy mpg?

worst_hwy_mpg_id <- filter(two_wheel_twenty_miles, 
                        hwy == min(hwy) %>% 
                        select(id))
                  

# Write a function that takes a `year` and a `make` as parameters, and returns 
# The vehicle that gets the most hwy miles/gallon of vehicles of that make in that year

makeYearFilter <- function(my.make, my.year) {
  filtered <- filter(vehicles, make == my.make, year == my.year) %>%
              filter(hwy == max(hwy))
}

# What was the most efficient honda model of 1995?


