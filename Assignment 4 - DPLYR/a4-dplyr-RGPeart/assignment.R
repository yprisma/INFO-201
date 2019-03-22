# a4-data-wrangling

################################### Set up ###################################

# Install (if not installed) + load dplyr package 

library(dplyr)

# Set your working directory to the appropriate project folder

setwd("~/../Desktop/School Stuff/Senior Year 2017-2018/Homework Fall Quarter 2017/INFO 201/Assignment 4 - DPLYR/a4-dplyr-RGPeart")

# Read in `any_drinking.csv` data using a relative path

any_drinking <- read.csv('data/any_drinking.csv', stringsAsFactors = FALSE)

# Read in `binge.drinking.csv` data using a relative path

binge_drinking <- read.csv('data/binge_drinking.csv', stringsAsFactors = FALSE)

# Create a directory (using R) called "output" in your project directory
# Make sure to suppress any warnings, in case the directory already exists

if(!dir.exists("output")) {
  output <- dir.create("output")
}else {
  options(warn = -1)
}

################################### Any drinking in 2012 ###################################

# For this first section, you will work only with the *any drinking* dataset.
# In particular, we'll focus on data from 2012, keeping track of the `state` and `location` variables

# Create a data.frame that has the `state` and `location` columns, and all columns with data from 2012

state_location <- select(any_drinking, 'state', 'location', 'both_sexes_2012', 'females_2012', 'males_2012')

# Using the 2012 data, create a column that has the difference in male and female drinking patterns

state_location <- mutate(state_location, male_vs_female_difference = males_2012 - females_2012)

# Write your 2012 data to a .csv file in your `output/` directory with an expressive filename
# Make sure to exclude rownames

write.csv(state_location, file = "output/2012_data.csv", row.names = FALSE)

# Are there any locations where females drink more than males?
## Your answer should be a *dataframe* of the locations, states, and differences for all locations (no extra
## columns)

women_drink_more <- filter(state_location, male_vs_female_difference < 0) %>%     # Less than zero means the women had a higher number than the men 
                    select('state', 'location', 'male_vs_female_difference')

## What is the location in which male and female drinking rates are most similar (*absolute* difference is
## smallest)?
## Your answer should be a *dataframe* of the location, state, and value of interest (no extra
## columns)

smallest_difference <- filter(state_location, male_vs_female_difference == abs(min(male_vs_female_difference))) %>%
                       select(location, state, male_vs_female_difference)

## As you've (hopefully) noticed, the `location` column includes national, state, and county level
## estimates.
## However, many audiences may only be interested in the *state* level data. Given that, you
## should do the following:
# Create a new variable that is only the state level observations in 2012
# For the sake of this analysis, you should treat Washington D.C. as a *state*

states_only <- filter(state_location, location == state) 

# Which state had the **highest** drinking rate for both sexes combined? 
# Your answer should be a *dataframe* of the state and value of interest (no extra columns)

highest_drinking_state <- filter(states_only, both_sexes_2012 == max(both_sexes_2012)) %>%
                          select(state, both_sexes_2012)

# Which state had the **lowest** drinking rate for both sexes combined?
# Your answer should be a *dataframe* of the state and value of interest (no extra columns)

lowest_drinking_state <- filter(states_only, both_sexes_2012 == min(both_sexes_2012)) %>%
                         select(state, both_sexes_2012)

## What was the difference in (any-drinking) prevalence between the state with the highest level of
## consumption,
# and the state with the lowest level of consumption?
# Your answer should be a single value (a dataframe storing one value is fine)

both_sexes_state_difference <- select(highest_drinking_state, both_sexes_2012) - select(lowest_drinking_state, both_sexes_2012)

# Write your 2012 state data to an appropriately named file in your `output/` directory
# Make sure to exclude rownames

write.csv(states_only, file = "output/2012_state_data.csv", row.names = FALSE)

## Write a function that allows you to specify a state, then saves a .csv file with only observations from
## that state
# This includes data about the state itself, as well as the counties within the state
# You should use the entire any.drinking dataset for this function
# The file you save in the `output` directory indicates the state name
# Make sure to exclude rownames

state_output <- function(state_name) {
  state_values <- any_drinking %>% filter(state == state_name)
  write.csv(state_values, file = paste0("output/", state_name, " Data.csv"), row.names = FALSE)
}

# Demonstrate your function works by passing 3 states of your choice to the function

state_output("Utah")
state_output("Florida")
state_output("New Hampshire")
state_output("Washington")

################################### Binge drinking Dataset ###################################
# In this section, we'll ask a variety of questions regarding our binge.drinking dataset
# Moreover, we'll be looking at a subset of the observations which is just the counties 
# (i.e., exclude state/national estimates)
# In order to ask these questions, you'll need to first prepare a subset of the data for this section:

# Create a dataframe with only the county level observations from the binge_driking dataset 
# You should (again) think of Washington D.C. as a state, and therefore *exclude it here*
# This does include "county-like" areas such as parishes and boroughs

counties_only <- filter(binge_drinking, location != state & location != "United States")

# What is the average level of binge drinking in 2012 for both sexes (across the counties)?

average_2012_binge_drinking <- select(counties_only, both_sexes_2012) %>% 
                               summarize((mean(both_sexes_2012)))

# What is the *minimum* level of binge drinking in each state in 2012 for both sexes (across the counties)? 
## Your answer should contain roughly 50 values (one for each state), unless there are two counties in a
## state with the same value
# Your answer should be a *dataframe* with the 2012 binge drinking rate, location, and state

minimum_2012_binge_drinking <- counties_only %>%
                               group_by(state) %>%
                               filter(both_sexes_2012 == min(both_sexes_2012)) %>%
                               select(state, location, both_sexes_2012)

# What is the *maximum* level of binge drinking in each state in 2012 for both sexes (across the counties)? 
# Your answer should be a *dataframe* with the value of interest, location, and state

maximum_2012_binge_drinking <- counties_only %>%
                               group_by(state) %>%
                               filter(both_sexes_2012 == max(both_sexes_2012)) %>%
                               select(state, location, both_sexes_2012)

# What is the county with the largest increase in male binge drinking between 2002 and 2012?
# Your answer should include the county, state, and value of interest

counties_only <- mutate(counties_only, difference_male_2002_2012 = males_2012 - males_2002)
largest_increase <- filter(counties_only, difference_male_2002_2012 == max(difference_male_2002_2012)) %>%
                    select(location, state, difference_male_2002_2012)

# How many counties experienced an increase in male binge drinking between 2002 and 2012?
# Your answer should be an integer (a dataframe with only one value is fine)

county_male_increase <- select(counties_only, state, location, males_2002, males_2012) %>%
                        mutate(difference_2002_2012 = males_2012 - males_2002) %>%
                        filter(difference_2002_2012 > 0) %>%
                        nrow()

# What percentage of counties experienced an increase in male binge drinking between 2002 and 2012?
# Your answer should be a fraction or percent (we're not picky)

county_male_increase_percentage <- round((county_male_increase / summarize(counties_only, n())) * 100, digits = 2)
                    
# How many counties observed an increase in female binge drinking in this time period?
# Your answer should be an integer (a dataframe with only one value is fine)

county_female_increase <- mutate(counties_only, difference_female_2002_2012 = females_2012 - females_2002) %>%
                          filter(difference_female_2002_2012 > 0) %>%
                          summarize(n())

# What percentage of counties experienced an increase in female binge drinking between 2002 and 2012?
# Your answer should be a fraction or percent (we're not picky)

county_female_increase_percentage <- round((county_female_increase / summarize(counties_only, n())) * 100, digits = 2)

# How many counties experienced a rise in female binge drinking *and* a decline in male binge drinking?
# Your answer should be an integer (a dataframe with only one value is fine)

female_increase_male_decrease <- select(counties_only, state, location, females_2002, females_2012, males_2002, males_2012) %>%
                                 mutate(f_diff = females_2012 - females_2002) %>%
                                 mutate(m_diff = males_2012 - males_2002) %>%
                                 tally(f_diff > 0 & m_diff < 0 )
                                  
################################### Joining Data ###################################
## You'll often have to join different datasets together in order to ask more involved questions of your
## dataset.
# In order to join our datasets together, you'll have to rename their columns to differentiate them

# First, rename all prevalence columns in the any.drinking dataset to the have prefix "any."
## Hint: you can get (and set!) column names using the colnames function. This may take multiple lines of
## code.

colnames(any_drinking) <- paste0("any.", colnames(any_drinking))
colnames(any_drinking)[1] <- "state"
colnames(any_drinking)[2] <- "location"

# Then, rename all prevalence columns in the binge.drinking dataset to the have prefix "binge."
## Hint: you can get (and set!) column names using the colnames function. This may take multiple lines of
## code.

colnames(binge_drinking) <- paste0("binge.", colnames(binge_drinking))
colnames(binge_drinking)[1] <- "state"
colnames(binge_drinking)[2] <- "location"

# Then, create a dataframe with all of the columns from both datasets. 
# Think carefully about the *type* of join you want to do, and what the *identifying columns* are

any_and_binge <- full_join(any_drinking, binge_drinking)

# Create a column of difference between `any` and `binge` drinking for both sexes in 2012

any_and_binge <- mutate(any_and_binge, any_vs_binge_2012_diff = any.both_sexes_2012 - binge.both_sexes_2012)

# Which location has the greatest *absolute* difference between `any` and `binge` drinking?
# Your answer should be a one row data frame with the state, location, and value of interest (difference)

greatest_any_binge_difference <- filter(any_and_binge, any_vs_binge_2012_diff == max(abs(any_vs_binge_2012_diff))) %>%
                                 select(state, location, any_vs_binge_2012_diff)

# Which location has the smallest *absolute* difference between `any` and `binge` drinking?
# Your answer should be a one row data frame with the state, location, and value of interest (difference)

smallest_any_binge_difference <- filter(any_and_binge, any_vs_binge_2012_diff == min(abs(any_vs_binge_2012_diff))) %>%
                                 select(state, location, any_vs_binge_2012_diff)

################################### Write a function to ask your own question(s) ###################################
## Even in an entry level data analyst role, people are expected to come up with their own questions of
## interest
# (not just answer the questions that other people have). For this section, you should *write a function*
# that allows you to ask the same question on different subsets of data. 
# For example, you may want to ask about the highest/lowest drinking level given a state or year. 
# The purpose of your function should be evident given the input parameters and function name. 
## After writing your function, *demonstrate* that the function works by passing in different parameters to
## your function.

# Use the dataframe comprised of "any_drinking" and "binge_drinking". Given the name of a state, write a 
# function that shows the county with the highest average *binge and any* drinking rates for both sexes 
# between the years of 2010 to 2012. Please be sure to include the state, county, and data value regarding 
# this question.

highest_average_2010_2012 <- function(state_name) {
  subset <- filter(any_and_binge, state == state_name)
  subset <- mutate(subset, average_any_2010_2012 = (any.both_sexes_2010 + any.both_sexes_2011 + any.both_sexes_2012) / 3)
  subset <- mutate(subset, average_binge_2010_2012 = (binge.both_sexes_2010 + binge.both_sexes_2011 + binge.both_sexes_2012) / 3)
  any_highest_average <- filter(subset, average_any_2010_2012 == max(average_any_2010_2012)) %>%
                         select(state, location, average_any_2010_2012)
  binge_highest_average <- filter(subset, average_binge_2010_2012 == max(average_binge_2010_2012)) %>%
                           select(state, location, average_binge_2010_2012)
  paste0("The county in ", state_name, " with the highest *any* drinking average between 2010 & 2012 was ", select(any_highest_average, location), " with an average of ", round(select(any_highest_average, average_any_2010_2012), digits = 2),
         ". AND...",
         " The county with the highest *binge* drinking average between 2010 & 2012 was ", select(binge_highest_average, location), " with an average of ", round(select(binge_highest_average, average_binge_2010_2012), digits = 2))
}

# Provide some states to ensure that the function is working properly

highest_average_2010_2012("South Carolina")
highest_average_2010_2012("Kansas")
highest_average_2010_2012("Michigan")


################################### Challenge ###################################

# Using your function from part 1 (that wrote a .csv file given a state name), write a separate file 
# for each of the 51 states (including Washington D.C.)
# The challenge is to do this in a *single line of (concise) code*

lapply(states_only$state, state_output)

## Using a dataframe of your choice from above, write a function that allows you to specify a *year* and
## *state* of interest,
# that saves a .csv file with observations from that state's counties (and the state itself) 
# It should only write the columns `state`, `location`, and data from the specified year. 
# Before writing the .csv file, you should *sort* the data.frame in descending order
# by the both_sexes drinking rate in the specified year. 
# Again, make sure the file you save in the output directory indicates the year and state. 
# Note, this will force you to confront how dplyr uses *non-standard evaluation*
# Hint: https://cran.r-project.org/web/packages/dplyr/vignettes/nse.html
# Make sure to exclude rownames

year_state <- function(year_num, state_name) {
  year_num <- "2007"
  varname <- paste0("desc(any.both_sexes_", year_num, ")")
  year_state_data <- filter(any_drinking, state == state_name) %>%
                     select(state, location, contains(year_num)) %>%
                     arrange_(varname)
  write.csv(year_state_data, file = paste0("output/", year_num, " ", state_name, " Data.csv"), row.names = FALSE)
}

# Demonstrate that your function works by passing a year and state of your interest to the function

year_state("2012", "Mississippi")
year_state("2003", "New Mexico")
year_state("2007", "Montana")
