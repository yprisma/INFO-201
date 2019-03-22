
#Creates a bar grap that counts the number of sightings by the shape of the UFO. Also includes
#the frequency of sightings by states
library(RColorBrewer)
ufo_data <- read.csv("data/UFOCoords.csv")
ufo_shapes <- function(dataset) {
              ggplot(data = dataset) + geom_bar(aes(x=Shape, color = State)) + labs(title = "UFO Sightings By Shape") + theme(axis.text.x = element_text(angle = 90, hjust = 0.5))
}



