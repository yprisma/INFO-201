### Exercise 3 ###

# libraries
library(dplyr)

## We'll be using the mtcars dataset -- adding rowname as a column
vehicle <- tibble::rownames_to_column(mtcars, var='car')
                           # Note: 'tibble::' takes the function 'rownames_to_column()'
                           # from the tibble package withouth the need to load it
                           # explicitly with 'library(tibble)'

######## buggy ######### ----------------------------------------------

# Function to debug:
# Given a number of forward gears and a number of cylinders, what is the 
# Name of the car with the best mpg?
BestGearsCyl <- function(cylinders, gears) {
  ret <- vehicle %>%  
         filter(gear == gears & cyl == cylinders) %>% 
         filter(mpg == max(mpg)) %>% 
         select(car)
}

# Get the best mpg car for 6 cylinder cars with 4 gears
answer <- BestGearsCyl(6, 4)
