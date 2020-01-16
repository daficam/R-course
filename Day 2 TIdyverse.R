setwd("/home/participant/Course_Materials/my-first-project")

install.packages("tidyverse") # install a package of choice
library(tidyverse)  #load package


surveys <- read_csv("data/portal_data_joined.csv") #read in the file
head(surveys) # check what's there

class(surveys) # can show that surveys was read in as data frame but we need it as a tibble

surveys<-as_tibble(surveys) # read it as a tibble so it's compatible with tidyverse
class(surveys) # check it's actually a tibble
dim(surveys) # shows the dimensions of an object

print(surveys, n=15) # print first 15 rows
surveys[1:15,]
str(surveys) # check structure


#To visualise data we will use ggplot2
library(ggplot2)

#To plot we use ggplot with 3 arguments 1. the data 2. which vector within the data and 3. which type of plot)
plot1 <- ggplot(data=surveys, mapping=aes(x=month, y=hindfoot_length)) + 
  geom_point() # here data is surveys, mapping is the columns of month on x axis and hindfoot on y axis, the plot is geom point
plot1 # gets it to produce the plot


plot2 <- ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) + geom_point()
plot2 # another plot of weight by hindfoot, I just changed x

# We can add stuff to the plots
#Alpha is transparency to make it clearer how many data points are on top of each other
plot2_trans<- ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1)
plot2_trans

#We can add colours too
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "blue")

#We can assign a variable to the data for the plot and change the presentation 
#Remember to use correct syntax - we need the + after the old layer before we add another layer
surveys_plot <- ggplot(data = surveys, 
                       mapping = aes(x = weight, y = hindfoot_length))
surveys_plot + 
  geom_point() #points plot like we drew before
surveys_plot +
  geom_smooth() # smooth plot

surveys_plot + geom_point() + geom_smooth() # can show both!
surveys_plot + 
  geom_point(alpha=0.1) + 
  geom_smooth(color="red") #can add the transparency and colors. Colour names always have to have "".
