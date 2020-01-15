##Download the data using the function download.file which gets stored in the specified folder


download.file(url="https://ndownloader.figshare.com/files/2292169",
              destfile = "data/portal_data_joined.csv")


## Load data into R and store in the variable surveys
surveys <- read.csv(file="data/portal_data_joined.csv")


#look at the top of the data
head(surveys)

#look at class of surveys
class(surveys) # it's a data frame - the most important thing to work with

#look at the structure of your data frame
str(surveys)

#look at the summary statistics of the data frame
summary(surveys)

#open the table in a new tab
View(surveys)

class(surveys) # shows class of data
table(surveys$taxa) # gives you a nice summary of a specific column


##Indexing and subsetting data frames

surveys[2,8] # this way you get a single value with coordinates of rows, columns
surveys[,1] #this way you get a whole column
record_id <- surveys[,1] # record the frist column as record id

surveys[1,] # subset first row

surveys[c(1,2,3),c(1,2,3)] # subset first 3x3 square
surveys[1:3,1:3] # same thing


#remove a line
surveys[,-1] # take out the first column
surveys[,c(-1,-2,-3)] #take out first 3 columns
surveys[-c(7:34786), ] #take out all rows below 6


#Name Indexing

colnames(surveys) # find the column names
rownames(surveys) # find the row names


surveys_species <- surveys[,"species_id"] # subset the species id column to a variable surveys_species

surveys$species_id  # another way to subset

#Logical Indexing

#How to subset data to a category
surveys$species == "albigula" #which values in the species column are albigula
summary(surveys$species == "albigula") # gives me a number T/F

#to subset we want to select rows wit hthe vector we just created

albigula_data <-surveys[surveys$species == "albigula",] 

# this new subset table contains just the rows that are albigula 
# so you can use it to just analyse 1 species 

table(surveys$taxa, surveys$sex) # display number of observations from categories in a table



#Exercise for subsetting

surveys_200 <- surveys[200,] #made a data frame of row 200
n_rows<-nrow(surveys) #save number of rows so I know what number is the last row 
# also it's generally best to always save this stuff as variable e.g. if the number of rows changes this still works

surveys[n_rows,] #subset last row
tail(surveys) #check last rows in tail

surveys_last <-surveys[n_rows,] # save last row subset
surveys_middle<-surveys[n_rows/2,] # save middle row subset
surveys_head<-surveys[-(7:n_rows),] # save top 6 rows subset by excluding everything from row 7 to last row n_rows



####################
##Factors
#They are basically categories and the categories are called levels (stored as numbers in R)

sex <- factor(c("male", "female", "female", "male")) # Created a factor for sex with 2 levels and 4 observations
levels(sex) # what are the possible levels
nlevels(sex) # number of levels

as.numeric(sex) # can display the levels as numbers which is how they are used by R itself in analysis (not char)

#Reading in csv files everything which is char becomes a factor automatically! Avoid that because they often aren't actually factors
#How to read in a csv wihtout doing that:
surveys_char<-read.csv(file="data/portal_data_joined.csv", stringsAsFactors = FALSE)

str(surveys_char)
