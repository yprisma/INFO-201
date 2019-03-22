# Exercise 4: Gates Foundation Educational Grants

# Read data into a variable called `grants` using the `read.csv` function
# Make sure *not* to read the strings as factors

grants <- read.csv("gates_money.csv", stringsAsFactors = FALSE)

# Use the View function to look at your data

View(grants)

# Create a variable `spending` as the `total_amount` column of the dataset

spending <- grants$total_amount

# Confirm that your `spending` variable is a vector using the `is.vector` function

is.vector(spending)  # TRUE

# Create a variable `org` as the `organization` column of the dataset.

org <- grants$organization

### Now you can ask some more interesting questions about the dataset.  Store your answers in variables ###

# What was the mean grant value?

meanGrant <- mean(spending)

# What was the dollar amount of the largest grant?

library(dplyr)

largestGrantAmount <- max(spending)

# What was the dollar amount of the smallest grant?

smallestGrantAmount <- min(spending)

# Which organization received the largest grant?

row <- filter(grants, grants$total_amount == largestGrantAmount)
largestGrant <- row$organization

# Which organization received the smallest grant?

row <- filter(grants, grants$total_amount == smallestGrantAmount)
smallestGrant <- row$organization

# How many grants were awarded in 2010?

grantsTotal <- sum(grants$grant_title)
