# a3-using-data

################################### Set up (2 Points) ###################################

# Before you get started, make sure to set your working directory using the tilde (~)

setwd("~/../Desktop/School Stuff/Senior Year 2017-2018/Homework Fall Quarter 2017/INFO 201/Assignment 3 - Using Data/a3-data-RGPeart")

################################### DataFrame Manipulation (20 Points) ###################################

# Create a vector `first_names` with 5 names in it

first_names <- c("Ryan", "Lucas", "Anthony", "Bart", "Charles")

# Create a vector `math_grades` with 5 hypothetical grades (0 - 100) in a math course (that correspond to the 5 names above)

math_grades <- c(89, 91, 81, 90, 96)

# Create a vector `spanish_grades` with 5 hypothetical grades (0 - 100) in a Spanish course (that correspond to the 5 names above)

spanish_grades <- c(70, 69, 73, 85, 97)

# Create a data.frame variable `students` by combining your vectors `first_names`, `math_grades`, and `spanish_grades`

students <- data.frame(first_names, math_grades, spanish_grades)

# Create a variable `num_students` that contains the number of rows in your data.frame `students`

num_students <- nrow(students)

# Create a variable `num_courses` that contains the number of columns in your data.frame `students` minus one (b/c of their names)

num_courses <- ncol(students)

# Add a new column `grade_diff` to your dataframe, which is equal to `students$math_grades` minus `students$spanish_grades`

students$grade_diff <- students$math_grades - students$spanish_grades

# Add another column `better_at_math` as a boolean (TRUE/FALSE) variable that indicates that a student got a better grade in math

students$better_at_math <- students$math_grades > students$spanish_grades

# Create a variable `num_better_at_math` that is the number (i.e., one numeric value) of students better at math

num_better_at_math <- sum(students$better_at_math == TRUE)

# Write your `students` data.frame to a new .csv file inside your data/ directory with the filename `grades.csv`. Make sure not to write row names.

write.csv(students, file = "data/grades.csv", row.names = FALSE)

################################### Loading R Data (28 points) ###################################

## In this section, you'll work with some data that comes built into the R environment.
## Load the `Titanic` data set. You may also want to use RStudio to `View()` it to inspect its rows and columns,
## or just print (selected lines of) it.

View(Titanic)

# This data set actually loads in a format called a *table*
# This is not a data frame. Use the `is.data.frame()` function to confirm this.

is.data.frame(Titanic)

# You should convert the `Titanic` variable into a data frame; you can use the `data.frame()` function or `as.data.frame()`
# Be sure to **not** treat strings as factors!

Titanic <- data.frame(Titanic, stringsAsFactors = FALSE)

# Create a variable `children` that are the rows of the data frame with information about children on the Titanic.

children <- Titanic[Titanic$Age == 'Child',]

# Create a variable `num_children` that is the total number of children on the Titanic.
# Hint: remember the `sum()` function!

num_children <- sum(children$Freq)

# Create a variable `most_lost` which has row with the largest absolute number of losses (people who did not survive).
# Tip: you can use multiple statements (lines of code), such as to make "intermediate" sub-frames
#  (similar to what you did with the `children` variables)

most_lost <- Titanic[Titanic$Survived == "No" & Titanic$Freq == max(Titanic$Freq), ]

# Define a function called `SurvivalRate` that takes in a ticket class (e.g., "1st", "2nd") as an argument.
# This function should return a sentence describing the total survival rate of men vs. "women and children" in that ticketing class.
# For example: `"Of Crew class, 87% of women and children survived and 22% of men survived."`
# The approach you take to generating the sentence to return is up to you. A good solution will likely utilize 
# intermediate variables (subsets of data frames) and filtering to produce the required data.
# Avoid using a "loop" in R!

SurvivalRate <- function(ticket_class) {
  subset <- Titanic[Titanic$Class == ticket_class, ]
  children_total <- subset[subset$Age == "Child", ]
  women_total <- subset[subset$Age == "Adult" & subset$Sex == "Female", ]
  children_survived <- sum(children_total[children_total$Survived == "Yes", ]$Freq)
  children_not_survived <- sum(children_total[children_total$Survived == "No", ]$Freq)
  women_survived <- sum(women_total[women_total$Survived == "Yes", ]$Freq)
  women_not_survived <- sum(women_total[women_total$Survived == "No", ]$Freq)
  women_and_children_alive <- women_survived + children_survived
  women_and_children_dead <- women_not_survived + children_not_survived + women_survived + children_survived
  women_and_children_percentage <- round((women_and_children_alive / women_and_children_dead) * 100, digits = 0)
  
  men_total <- subset[subset$Age == "Adult" & subset$Sex == "Male", ]
  men_survived <- sum(men_total[men_total$Survived == "Yes", ]$Freq)
  men_not_survived <- sum(men_total[men_total$Survived == "No", ]$Freq)
  men_percentage <- round((men_survived / (men_not_survived + men_survived)) * 100, digits = 0)
  
  string <- paste0("Of ", ticket_class, " class, ", women_and_children_percentage, "% of women and children survived and ", men_percentage, "% of men survived.")
  return(string)
}

# Call your `SurvivalRate()` function on each of the ticketing classes (`Crew`, `1st`, `2nd`, and `3rd`)

SurvivalRate('Crew')
SurvivalRate('1st')
SurvivalRate('2nd')
SurvivalRate('3rd')

################################### Reading in Data (40 points) ###################################
# In this section, we'll read in a .csv file, which is essentially a tabular row/column layout 
# This is like Microsoft Excel or Google Docs, but without the formatting. 
# The .csv file we'll be working with has the life expectancy for each country in 1960 and 2013. 
# We'll ask real-world questions about the data by writing the code that answers our question. Here are the steps you should walk through:

# Using the `read.csv` function, read the life_expectancy.csv file into a variable called `life_expectancy`
# Makes sure not to read strings as factors

life_expectancy <- read.csv("data/life_expectancy.csv", stringsAsFactors = FALSE)

## Determine if life_expectancy is a data.frame by using the is.data.frame function.
## You may also want to inspect it's content it by View() or by just printing.

is.data.frame(life_expectancy)
View(life_expectancy)

# Create a column `life_expectancy$change` that is the change in life expectancy from 1960 to 2013

life_expectancy$change <- life_expectancy$le_2013 - life_expectancy$le_1960

# Create a variable `most_improved` that is the name of the country with the largest gain in life expectancy

most_improved <- life_expectancy$country[life_expectancy$change == max(life_expectancy$change)]

# Create a variable `num_small_gain` that has the number of countries whose life expectance has improved fewer than 5 years between 1960 and 2013

num_small_gain <- sum(life_expectancy$change < 5)

# Write a function `CountryChange` that takes in a country's name as a parameter, and returns it's change in life expectancy from 1960 to 2013

CountryChange <- function(name) {
  return(life_expectancy[life_expectancy$country == name, ]$change)
}

# Using your `CountryChange` function, create a variable `sweden_change` that is the change in life expectancy from 1960 to 2013 in Sweden

sweden_change <- CountryChange("Sweden")

# Define a function `LowestLifeExpInRegion` that takes in a **region** as an argument, and returns 
# the **name of the country** with the lowest life expectancy in 2013 (in that region)

LowestLifeExpInRegion <- function(region_name) {
  subset <- life_expectancy[life_expectancy$region == region_name, ]
  lowestCountry <- subset[subset$le_2013 == min(subset$le_2013), ]$country
  return(lowestCountry)
}

# Using the function you just wrote, create a variable `lowest_in_south_asia` that is the country with the lowest life expectancy in 2013 in South Asia

lowest_in_south_asia <- LowestLifeExpInRegion("South Asia")
print(lowest_in_south_asia)

# Write a function `BiggerChange` that takes in two country names as parameters, and returns a sentence that 
# describes which country experienced a larger gain in life expectancy (and by how many years). 
# For example, if you passed the values "China", and "Bolivia" into your function, it would return this:
# "The country with the bigger change in life expectancy was China (gain=31.9), whose life expectancy grew by 7.4 years more than Bolivia's (gain=24.5)."
# Make sure to round your numbers.

BiggerChange <- function(country1, country2) {
  country_1_gain <- life_expectancy[life_expectancy$country == country1, ]$change
  country_2_gain <- life_expectancy[life_expectancy$country == country2, ]$change
  diff <- country_1_gain - country_2_gain
  sentence <- ""
  if(diff > 0) {
    sentence <- paste0("The country with the bigger change in life expectancy was ", country1, " (gain = ", round(country_1_gain, digit = 1), "), whose life expectancy grew by ", round(diff, digit = 1), " years more than ", country2, "'s (gain = ", round(country_2_gain, digit = 1), ").")
  }else {
    sentence <- paste0("The country with the bigger change in life expectancy was ", country2, " (gain = ", round(country_2_gain, digit = 1), "), whose life expectancy grew by ", round(-diff, digit = 1), " years more than ", country1, "'s (gain = ", round(country_1_gain, digit = 1), ").")
  }
  return(sentence)
}

## Using your `BiggerChange` function, create a variable `usa_or_france` that describes who had a larger gain in life expectancy
##  (the United States or France)

usa_or_france <- BiggerChange("United States", "France")
print(usa_or_france)

china_or_bolivia <- BiggerChange("China", "Bolivia")
print(china_or_bolivia)

## Write your `life_expectancy` data.frame to a new .csv file to your data/ directory with the filename `life_expectancy_with_change.csv`.
## Make sure not to write row names.

write.csv(life_expectancy, file = "data/life_expectancy_with_change.csv", row.names = FALSE)

################################### Challenge (10 points) ###################################

## Create a variable that has the name of the region with the 
## highest average change in life expectancy between the two time points.
## Your are welcome to weight the change by population, but just unweighted average over countries is good as well.
## To do this, you'll need to compute the average change across the countries in each region, and then 
## compare the averages across regions. Feel free to use any library of your choice, or base R functions.

library(dplyr)
highest_average <- group_by(life_expectancy, region) %>%
                   summarize(average = mean(change)) %>%
                   filter(average == max(average)) %>%
                   select(region)

# Create a *well labeled* plot (readable title, x-axis, y-axis) showing
# Life expectancy in 1960 v.s. Change in life expectancy
# Programmatically save (i.e., with code, not using the Export button) your graph as a .png file in your repo 
# Then, in a comment below, provide an *interpretation* of the relationship you observe
# Feel free to use any library of your choice, or base R functions.

plot(life_expectancy$change ~ life_expectancy$le_1960, 
     main = "1960's Life Expectancy vs. Change in Life Expectancy", 
     ylab = "Change in Life Expectancy", xlab = "Life Expectancy in 1960")
dev.off()

# What is your interpretation of the observed relationship?

## The relationship between 1960's life expectancy and the change in life expectancy is negative.
## The regions that had a higher life expectancy in 1960 had a smaller change in life expectancy.
## Whereas, the regions with a lower life expectancy in 1960 had a larger increaes in life expectancy over time
