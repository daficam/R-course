

library(tidyverse)  #load package


surveys <- read_csv("data/portal_data_joined.csv") #read in the file
#read_csv reads in everything as character while read.csv can have factors
head(surveys) # check what's there

class(surveys) # can show that surveys was read in as data frame but we need it as a tibble

surveys<-as_tibble(surveys) # read it as a tibble so it's compatible with tidyverse
#if something was factor when read-in it stays as factor, if it was char it stays as char
class(surveys) # check it's actually a tibble

###Transforming Data
# we need to subset data
#in base R we would do:

surveys[surveys$species=="albigula" & surveys$year==1977,]

#in tidyverse we use the function filter

filter(surveys,species=="albigula", year==1977)
surveys_subset<-filter(surveys,species=="albigula", year==1977) # we can save the subset of data in a variable - 
#shows just the rows of albigula from 1977
str(surveys_subset)

# New functions to explore in dplyr - 
?dplyr

#Subsetting just columns usign the finction select
select(surveys, year, month) # just the year and month columns
select(surveys, -year, -month) # everything but year and month

#Subset to specific rows and specific columns (so use filter and select nested inside)
surveys2<- filter(
  select(surveys,-year,-weight),species=="albigula") # new object without year and month columns and just the albigula rows.


#however if we've selected the year column out already then we can't filter by year.
filter(
  select(surveys,-year,-weight),year==1995) # this returns an error




####Removing NAs

#You should ask if there are any NA's in any particular column of interest

table(is.na(surveys$weight))

is.na(surveys$weight) # table of all values which are NA
!is.na(surveys$weight)     # which aren't NA

filter(surveys,!is.na(weight),!is.na(hindfoot_length)) # this removes all the rows that have NA in weight and hindfoot

drop_na(surveys, weight, hindfoot_length) #this also removes the NAs in weithe and hindfoot

drop_na(surveys) #this removes all rows that have NAs in the dataset

surveys_complete <- drop_na(surveys) #save the cleaned data as variable



##### Pipes
#This makes it easier to filter the data without nesting endless functions.
#Pipes let you take the output of one function and send it directly to the next, 
#which is useful when you need to do many things to the same dataset. 
#Pipes in R look like %>% and are made available via the magrittr package, installed automatically with dplyr.

surveys %>% # you can keep adding commands from here with %>%
  select(species, weight, hindfoot_length, year, sex) %>%
  filter(year >= 1995, species=="albigula") %>%
  filter(!is.na(weight)) %>%
  ggplot(mapping = aes(x = weight, y = hindfoot_length)) +  geom_point(alpha = 0.1, color = "blue")

#Essentially in these rows I selected my columns of interest, 
#filtered to the rows that are recent, and albigula, removed the NA,and plotted it.

##### Exercise

surveys %>% # you can keep adding commands from here with %>%
  select(species, weight, hindfoot_length, year, sex) %>%
  filter(year >= 1995, sex=="M") %>%
  filter(!is.na(weight), !is.na(hindfoot_length)) %>%
  ggplot(mapping = aes(x = weight, y = hindfoot_length)) +  geom_point(alpha = 0.5, color = "gray")


######### Exercise 2 - cleate a surveys_recent by filtering to >1995
surveys_recent<-surveys_complete %>% # you can keep adding commands from here with %>%
  select(species, weight, hindfoot_length, year, sex) %>%
  filter(year >= 1995)

#Now use ggplot to make 2 layers with the two datasets, one full and one filtered. 
#You can give the source of data in the geometric plot layout line (instead of the ggplot line)
#This allows to plot two datasets on top of each other

ggplot(mapping = aes(x = weight, y = hindfoot_length)) + 
  ggtitle("Weight vs Hindfoot Length\n after 1995") +     # allows you to add a title
  geom_point(data=surveys_complete, alpha = 0.5, color = "gray") +
  geom_point(data=surveys_recent, alpha = 0.5, color = "red") 
 
ggsave(filename="fig_output/plot_weight_hindfoot_scatter_overlay1995.png")

#common issues - losing ttrack of what is assigned to what variable - make sure naming is clear and not lazy


### Creating new Columns - mutating the data. Mutate transforms or adds variables

surveys_complete_kg<- surveys_complete %>%
  mutate(weight_kg = weight / 1000) # made a new column of the weight of animals in kg adn saved the new dataset
head(surveys_complete_kg)

#You can add more than 1 column at a time if you want
surveys_complete %>%
  mutate(weight_kg = weight / 1000,
         weight_kg2 = weight_kg * 2)


#Challenge use surveys_complete make boxplot of taxa (x-axis) vs weight in kg (y-axis)

surveys_complete_kg<- surveys_complete %>%
  mutate(weight_kg = weight / 1000)

ggplot(data=surveys_complete_kg, mapping = aes(x = taxa, y = weight_kg)) +
  geom_boxplot()

# Shorter Version of same thing
surveys_complete %>%
  mutate(weight_kg = weight / 1000) %>%
  ggplot(mapping = aes(x = taxa, y = weight_kg)) +
  geom_boxplot()

#boxplots of each species
surveys_complete %>%
  mutate(weight_kg = weight / 1000) %>%
  ggplot(mapping = aes(x = species, y = weight_kg)) + 
  #  just changing x to species leads to very different plot, they don't need to be factors here
  geom_boxplot()

#Trying to make boxplots of each taxa - needed to use whole dataset and convert 

surveys_kg_taxafactor <- surveys %>%
  mutate(weight_kg = weight / 1000) %>%
  mutate_at(.vars="taxa", .funs=factor) # turns the taxa into factor and stores it.

ggplot(data=surveys_kg_taxafactor, mapping = aes(x = taxa, y = weight_kg)) +
  geom_boxplot()
str(surveys_kg_taxafactor)



#Using the mutate function to make better plots: 
#Want to make a boxplot of weight by year
#The years in the data are numbers but we want them to turn into categories ie factors
#Thus i need to use mutate to turn the years to factors - use mutate_at(.vars="year", .funs=factor) 

##### Arrange Data

surveys_complete%>%
  arrange(weight) #arrange by weight ascending

surveys_complete %>%
  arrange(desc(weight)) #arrange by weight descending

surveys_complete %>%
  arrange(desc(weight), desc(year)) #arrange by desc weight and then by desc year



###### Summarise data

surveys_complete %>%
  summarise(mean_weight = mean(weight)) #returns the mean weight - can be saved


#Frequency Count

surveys_complete%>%
  count(sex) #returns a table of sexes - can be saved

surveys_complete%>%
  count(sex,species) #returns table of counts of each species by sex

surveys_complete%>%
  count(plot_type) # tibble of how many animals are found in each plot type

surveys_complete%>%
  count(sex, species)%>%
  arrange(species, desc(n)) #arranges by species and then by descending number of animals seen (n is a column name!)
          
surveys_complete%>%
  count(sex, species)%>%
  arrange(desc(n), species) #arranges by most abundant species


########## Plotting time series data

yearly_counts<-surveys_complete%>% #first make a df of counts of each genus in each year
  count(year,genus)

ggplot(data=yearly_counts,mapping=aes(x=year,y=n, group=genus, color=genus))+
  geom_line() # make a line plot of frequency of genus by year. 
#Important to make 1 line for each genus so it can make sense by using group


##### Histograms - they aren't x/y plots, just specify x

ggplot(data=surveys_complete, aes(weight)) +
  geom_histogram(bins=100) # plot all counts by weight, bins gives number of bars for more resolution

#plot by colouring in different populations (M and F) by using fill=column
ggplot(data=surveys_complete, aes(weight, fill=sex)) +
  geom_histogram(bins=100)

######## Frequency Polygon - same as histogram

ggplot(data=surveys_complete, aes(weight, colour=sex)) +
  geom_freqpoly(binwidth=10) #plot frequency as a polygon line, binwidth controls the 

##############
#Grouping Data
#We want to calculate something for groups of data such as sex

surveys_complete%>%
  group_by(sex)%>% # a tibble allows to remember that there are groups in the data while a dataframe doesn't
  summarise(mean_weight=mean(weight)) #here we get mean weight separated by groups we specified earlier automatically

surveys_complete%>%
  summarise(mean_weight=mean(weight)) #here we get only one mean

surveys_complete%>%
  group_by(sex,species)%>% 
  summarise(mean_weight=mean(weight)) #now we have mean weights of each species by sex

####### Grouping data exercise
#Use group_by() and summarise() to find the mean, min, and max hindfoot length for each species (using species_id). 
#Also add the number of observations (hint: see ?n).

surveys_complete%>%
  group_by(species_id)%>% 
  summarise(mean=mean(hindfoot_length),
            min=min(hindfoot_length), 
            max=max(hindfoot_length),
            n=n())

##Exercise 2
#Show the heaviest animal for each year with columns for year,genus,species_id and weight
            
surveys_complete %>% # first find the heaviest animal for each year - group by and filter to maximum value for the year
  group_by(year) %>%
  filter(weight == max(weight)) %>% #if we stop here we get all columns
  select(year, genus, species_id, weight) %>% #select the columns we want to show
  arrange(year) #arrange by year



############# Facetting 
#Facetting the yearly counts 

ggplot(data=yearly_counts, mapping=aes(x=year, y=n))+
  geom_line()+
  facet_wrap(facets=vars(genus)) #we can split the yearly counts by genus into different plots 
#scales are restricted to be the same in all plots by default

ggplot(data=yearly_counts, mapping=aes(x=year, y=n))+
  geom_line()+
  facet_wrap(facets=vars(genus),
             scales="free") #gives same plots but with all different scales 

yearly_sex_counts<- surveys_complete%>%
  count(year,genus,sex) #this time we have made counts for 3 variables

ggplot(data=yearly_sex_counts, mapping=aes(x=year, y=n, colour=sex))+
  geom_line()+
  facet_wrap(facets=vars(genus)) #this allowed us to make facetted plots coloured by sex

ggplot(data=yearly_sex_counts, mapping=aes(x=year, y=n))+
  geom_line()+
  facet_grid(rows=vars(sex), cols=vars(genus)) #we can make a grid ofthe same plots and specify the grid rows and columns

##### Facetting Exercise
ggplot(data = yearly_sex_counts, 
       mapping = aes(x = year, y = n, color=sex)) +
  geom_line() +
  facet_grid(cols =  vars(genus)) #we can take out the rows and display the sex as colours instead
#has to be in the mapping line

######## Customisation
###Labels allow us to rename axes and add title

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_grid(cols = vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of animals")
#labs should be added with a +

#You can also control the size, font and direction of labels

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color=sex)) +
  geom_line() +
  facet_grid(cols = vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of animals")  +
  theme(axis.text.x = element_text(size=7, angle=90, vjust=0.5), 
        axis.text.y = element_text(size=7), 
        strip.text=element_text(size=7, angle=90))
#theme is also added with a + , theme has lots of things to changeth

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color=sex)) +
  geom_line() +
  facet_grid(cols = vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of animals")  +
  theme_light() #some default colour schemes exist - check help


#we can set the colour manually and we can tweak the legend at the same time with colour brewer
ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color=sex)) +
  geom_line() +
  facet_grid(cols = vars(genus)) +
  labs(title = "Observed genera through time",         #define labels
       x = "Year of observation",
       y = "Number of animals")  +
  theme(axis.text.x = element_text(size=7, angle=90, vjust=0.5),      #define text
        axis.text.y = element_text(size=7), 
        strip.text=element_text(size=7, angle=45)) +
  scale_color_brewer("Sex",                             #define colours and legend
                     palette="Set1", 
                     breaks=c("F", "M"), 
                     labels=c("Female", "Male"))
#You can save a theme as an object
theme_design<-theme(axis.text.x = element_text(size=7, angle=90, vjust=0.5),      #define text
                    axis.text.y = element_text(size=7), 
                    strip.text=element_text(size=10, angle=0)) 


#Preset themes
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point() +
  theme_design
#You can save a theme as an object

#Saving Data
write.csv(yearly_sex_counts, file="data_output/surveyscomplete.csv")

write_csv(yearly_sex_counts, path="data_output/surveys_complete.csv")

#Challenge
#Make a plot of how weight of each species changes over the years
surveys_complete %>%
  group_by(year,species) %>%
  summarize(mean_weight = mean(weight))%>%
  ggplot(mapping = aes(x = year, y = mean_weight)) +
  geom_line() +
  facet_grid(rows = vars(species)) +
  facet_wrap(~ species, ncol=7) +
  theme_design+
  labs(title = "Mean Weight/Time",         #define labels
       x = "Year of observation",
       y = "Mean Weight of Animals (g)")  
