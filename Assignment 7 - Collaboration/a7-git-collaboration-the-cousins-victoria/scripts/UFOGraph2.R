# Creates a bar graph that counts the number of UFO sightings in each state and also
# shows the frequency of sightings that were either in the AM or PM.
library(ggplot2)
ufo_data <- read.csv("data/UFOCoords.csv")
ufo_graph <- function(data1) {
        ggplot(data = data1) + geom_bar(aes(x=State, color = AM.PM)) + ggtitle("UFO Sightings Per State") + theme(axis.text.x = element_text(angle = 90, hjust = 0.5))
}



