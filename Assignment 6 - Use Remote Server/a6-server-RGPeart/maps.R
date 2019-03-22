### This is the stump script to read the data and plot the maps

# setwd("C:/Users/rgpea_000/Desktop/School Stuff/Senior Year 2017-2018/Homework Fall Quarter 2017/INFO 201/Assignment 6 - Use Remote Server/a6-server-RGPeart")

## read the data

library('dplyr')
library("data.table")
library('ggplot2')
library('mapproj')

# subset_MiddleAmerica_df <- read.csv("temp_prec_subset.csv")

## filter out North American observations

NorthAmerica_df <- read.csv(bzfile("/opt/data/temp_prec_1960+.csv.bz2")) %>% filter(latitude < 90, longitude > 180) %>%
                   filter(longitude < 300, latitude > 20)


## delete the original (large data) from R workspace

rm('temp_prec_1960+.csv')
# rm('temp_prec_selected_years.csv')
# rm('temp_prec_subset.csv')

## -------------------- do the following for 1960, 1987, 2014 and temp/precipitation --------------------

# MA_1960_df <- subset_MiddleAmerica_df %>% filter(format(as.Date(time), "%Y-%m") == "1960-07")
NA_1960_df <- NorthAmerica_df %>% filter(format(as.Date(time), "%Y-%m") == "1960-07")

# MA_1987_df <- subset_MiddleAmerica_df %>% filter(format(as.Date(time), "%Y-%m") == "1987-07")
NA_1987_df <- NorthAmerica_df %>% filter(format(as.Date(time), "%Y-%m") == "1987-07")

# MA_2014_df <- subset_MiddleAmerica_df %>% filter(format(as.Date(time), "%Y-%m") == "2014-07")
NA_2014_df <- NorthAmerica_df %>% filter(format(as.Date(time), "%Y-%m") == "2014-07")

## select jpg graphics device

## select the correct year - plot longitude-latitude and color according to the temp/prec variable
## I recommend to use ggplot() but you can do something else
## Note: if using ggplot, you may want to add "+ coord_map()" at the end of the plot.  This
## makes the map scale to look better.  You can also pick a particular map projection, look
## the documentation.  (You need 'mapproj' library).

# Plotting the temperature and precipitation for 1960 in Middle America (Subset Data)

# MiddleAmerica_temp <- ggplot(subset_df, aes(longitude, latitude, col = airtemp)) + geom_point()
# MiddleAmerica_prec <- ggplot(subset_df, aes(longitude, latitude, col = precipitation)) + geom_point()

# Plotting the temperature and precipitation for 1960 North America data

NA_1960_temp <- ggplot(NA_1960_df, aes(longitude, latitude, col = airtemp)) + geom_point()
NA_1960_prec <- ggplot(NA_1960_df, aes(longitude, latitude, col = precipitation)) + geom_point()

# Plotting the temperature and precipitation for 1987 North America data

NA_1987_temp <- ggplot(NA_1987_df, aes(longitude, latitude, col = airtemp)) + geom_point()
NA_1987_prec <- ggplot(NA_1987_df, aes(longitude, latitude, col = precipitation)) + geom_point()

# Plotting the temperature and precipitation for 2014 North America data

NA_2014_temp <- ggplot(NA_2014_df, aes(longitude, latitude, col = airtemp)) + geom_point()
NA_2014_prec <- ggplot(NA_2014_df, aes(longitude, latitude, col = precipitation)) + geom_point()

jpeg(("map.1960airtemp.NorthAmerica.jpeg"))
plot(NA_1960_temp)
jpeg(("map.1960prec.NorthAmerica.jpeg"))
plot(NA_1960_prec)

jpeg(("map.1987airtemp.NorthAmerica.jpeg"))
plot(NA_1987_temp)
jpeg(("map.1987prec.NorthAmerica.jpeg"))
plot(NA_1987_prec)

jpeg(("map.2014airtemp.NorthAmerica.jpeg"))
plot(NA_2014_temp)
jpeg(("map.2014prec.NorthAmerica.jpeg"))
plot(NA_2014_prec)

## close the device

dev.off()
