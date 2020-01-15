print("Hello World!")
print("Stuff")
 # these are notes. Hash means it's not executed. 
# BODMAS Tests
(4+5)/9
9^-1
9^1
9^0.1
0.1*9
(30-2)^2
30-2^2

# Ctrl Shift C allows for  adding  many lines of highlighted comments
# stuff
# stuff stuff

#######Variables
# How to assign a variable: 
x <- 2 #x is 2
x <- 2 + 4 #x is 2+4
a <- 2
b <- 4
c <- a + b
e <- 200
d<-100
# rm(e) means remove variable e 

##### Functions 
sqrt(25) #using the function sqrt. 25 is called an argument.

result <- sqrt(25) #saving the result of the function sqrt(25) as the variable result

round(2.479083254, digits=2) # here it takes 2 arguments separated by comma, second shows how many digits after decimal 

round(3.14) # default digits is 0 meaning whole number

round(3.14234, 2) # you don't need to name your arguments

round(x=3.12345, digits=2) # you can name all of the arguments and also you can switch them around to give the same result. 
# Best to keep it as descripbed in the documentation to avoid confusion.
# x above is not a defined variable, it's an argument

x<- 3.14567
round(x,2)
# it will round to 3.15 as x is now a variable 
#and we are calling the variable as an argument

# Testing the function rnorm which generates random observations 
# with a normal distribution with a set mean and SD
rnorm(50, mean=5, sd=1)
rnorm(10, mean=500)
rnorm(4)
rnorm(15, 4, 2)


##### Data Types

#example of character data type 
gene_id <- "BRCA2" #Has to have quotes! Otherwise it will give error

#example of integer data type
blah <- 4.5

#example of double data type 
pi  <- 3.142

#example of boolean
is_valid <- FALSE # For it to be boolean it needs to be all caps and no quotes FALSE



###### Data Structures
################
##Vector
# Vector is a list of data of same type
c(4,12,7,9) # Define the vector which is a list of 4,12,7,9

weight_g <- c(50,60,65,82) #this way my numeric vector is defined in a variable
animals <- c("mouse","rat","dog") # my character vector is defined as animals


length(weight_g) # gives you the length of your vector - probably most useful
length(animals)

class(weight_g) # gives you the class of your vector
class(animals)

str(weight_g) # gives you details of the structure of your vector
str(animals)

#give me length of weight_g and multiply by 100
updated_length <- length(weight_g)*100
updated_length

#adding elements to a vector
weight_g <- c(weight_g, 98) # add element to the end
weight_g <- c(30, weight_g) # add element to the beginning

#appending elements to middle of vector
append(weight_g, 99, 2) #we can add element to variable after the position specified
weight_g <- append(weight_g, 99, 2) # that way we save the addition in the variable

# vectors with mixed types of data:
# Basically, if anything is in "" everything will be classed as char 
num_char <- c(1, 2, 3, "a")
class(num_char) # class will be char

num_logical <- c(1, 2, 3, TRUE)
class(num_logical) # class will be num

char_logical <- c("a", "b", "c", TRUE)
class(char_logical) # class will be char

tricky <- c(1, 2, 3, "4")
class(tricky) # class will be char

# vectors always have to be the same type of data so data becomes coerced into the same type
# char>num>boolean
num_logical <- c(1, 2, 3, TRUE) # this is num
char_logical <- c("a", "b", "c", TRUE) # this is char
combined_logical <- c(num_logical, char_logical)
class(combined_logical) # this is char


##########
## Vector indeces - subsetting vectors
animals <- c("mouse", "rat", "dog", "cat")
animals[2] # for subsetting we use [] for functions we use ()

#we can subset multiple values from a vector, we do that by defining a vector of the indeces we want.
animals[c(2,3)]
animals[c(3,2)] # order of indeces doesn't matter
animals[c(3,2,2)] # you can repeat indeces it just returns it again

#subset everythign but mouse 
animals[c(2,3,4)]
animals[-1] #both are valid

#remove mouse from variable animals
no_mouse <- animals[-1]
no_mouse


##########
## Conditional Subsetting (without indeces)

#remove first 2 items using logical operators
animals[c(FALSE, FALSE, TRUE, TRUE)] # don't forget square brackets

weight_g <- c(21,55,39,54,34)
#Show me items >50
weight_g > 50
#subset to items >50
weight_g[weight_g>50]
#subset items >30
weight_g[weight_g>30]
#subset items >30 and <50
weight_g[weight_g>30 & weight_g<50] # & means and
#subset items >30 or <50
weight_g[weight_g>30 | weight_g<50] # | means or

#subsetting char vectors
animals
#check if animals has either fish or dog in it
animals[animals=="fish" | animals=="dog"] # == means equal
animals[animals=="pony"]

# introducing %in% - 
# check if elements from animals are present in new_animals
new_animals <- c("rat", "cat", "dog", "duck")
animals %in% new_animals

# subset the values that are present in animals and new animals
animals[animals %in% new_animals]

## Exercise - make a vector weight_kg from weight_g
weight_kg <- weight_g/1000
weight_kg # in the new vector each value is divided by 1000




#############
## Missing Data 

#NA means missing data
heights <- c(2,4,4,NA,6)
mean(heights) # returns NA because there is missing data
mean(heights, na.rm=TRUE) # this way NA is ignored in the mean computation

#remove NA's
clean_heights<-na.omit(heights)
clean_heights
mean(clean_heights) # another way to get a clean mean

is.na(heights) # shows which is NA
!is.na(heights) # shows which is not NA

#subset to what is not NA
heights[!is.na(heights)]

#save subset to new variable
nona_heights<-heights[!is.na(heights)]

#Exercise
heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)
heights_no_na<-heights[!is.na(heights)]
median(heights_no_na)
above_67<-heights_no_na[heights_no_na>67]
length(above_67) # removed NAs, calculated median and subsetted to above 67, then displayed length of subset variable


#Factor
# Factor used for categorical data (like small, medium, large)
# Data Frame contains tabular data - used the most so really have to understand this one.
