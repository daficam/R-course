#Makign a Geometric 2D Density Plot 

setwd("/home/participant/Course_Materials/my-first-project")

install.packages("tidyverse") # install a package of choice
library(tidyverse)  #load package


surveys <- read_csv("data/portal_data_joined.csv") #read in the file
head(surveys) # check what's there

class(surveys) # check it's a tibble

library(ggplot2) # load ggplot2

#Make the density plot of weight by hindfoot length
plot_density <- ggplot(data=surveys, mapping=aes(x=weight, y=hindfoot_length)) + 
  geom_density2d()
plot_density # make a variable that ocntains a density plot

#alternatively make a variable for any plot with this data and then make any type of plot you wish
plot4 <- ggplot(data=surveys, mapping=aes(x=weight, y=hindfoot_length))

plot4 + geom_density2d()



#Save plot to a file (make sure the folder exists and you have speficied which plot you want to save)
ggsave(filename="fig_output/plot_weight_hindfoot_density2d.png", plot=plot_density)
ggsave(filename="fig_output/plot_weight_hindfoot_density2d.pdf", plot=plot_density)

#OR you can generate and save the plot at the same time from my generic variable for plotting the data
ggsave(filename="fig_output/plot_weight_hindfoot_density2d.png", plot=plot4 + geom_density2d())
ggsave(filename="fig_output/plot_weight_hindfoot_point2.png", plot=plot4 + geom_point(alpha=0.1, size=0.1), width = 2, height = 2.5)


#alternatively if you don't specify which plot it will save the last one you plotted
ggsave(filename="fig_output/plot_weight_hindfoot_density2d.png")


