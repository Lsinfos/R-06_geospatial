# 1. VECTORS

# 1.1 Different types of vectors ####

# A vector is an ordered collection of values of the same type (or mode). Three types of values that are useful for most purposes are numeric, character and logical.

# Single elements are also represented in R as vectors (of length 1)
10 # number 10 at the position 1.
# Vectors can be created from individual elements with c() function (stands for combine)
c(1, 5, 10, 4)
c("cat", "dog", "mouse", "apple")
# Sequential numeric vectors can be easily created with : operator
7:20
# The : operator  creates an ordered vector starting at the value to the left and ending at the value to the right of the : symbol
33:24
# A logical vector can be also created with c()
c(TRUE, FALSE, TRUE, TRUE) # however, in practice, the creation of the logical vectors is usually employed with a conditional operator on a vector. 
# Convert between vector types
as.character(33:24) # convert the numeric value to  character value.
as.numeric(as.character(33:24)) # convert back to numeric value.

# Factor: a special type of encoding for a vector, where the vector has a defined set of acceptable values or levels, most common in statistical use. 
factor(c("cat", "dog", "dog"))
factor(c("cat", "dog", "dog", "mouse")) # the acceptable levels of the resulting factor object are by default, defined as a set of unique values that the vector has.

# 1.2 Objects ####

# Saving immediate results is essential to automate processes. Without saved objects, we can't make sequential operations with each created object serving as an input for the next step(s).
# Assginment: saving objects to temporary memory using an assignment expression <- or =
v <- 1:10
# Access the newly created object by using its name
v
# When assigning an object with a name that already exists in the memory, the oder object is overwritten
x <- 55
x
x <- "Hello"
x

# ls() function returns a character vector with the names of all the user-defined objects in a given environment
ls()

# rm() functions removes objects from memory
rm(v)
# Remove all objects from memory
rm(list = ls())
# Check again the list of objects 
ls() # the output character(0) indicates an empty character vector.

# 1.3 Summarizing properties ####

# Many functions in R are intended to work with vectors, most common are used to find out vectors' properties
v <- 1:10
# Find out the average value
mean(v)
# Find out the minimal and maximal value
min(v)
max(v)
# Get both minimal and maximal at once
range(v)
# Find out the number of elements, or length, a given vector has
length(v)
# which.min() and which.max() return the position of the minimal or maximal element in a numeric vector
which.min(v)
which.max(v)

# With logical values, we sometimes want to know whether they contain at least one TRUE value or whether all of their values are TRUE
l <- c(TRUE, FALSE, FALSE, TRUE)
any(l) # contains at least one TRUE value.
all(l) # all of the values are TRUE.
# When arithmetic functions are used for a logical vector, the default transformation will return a numeric vector, in which TRUE is converted to 1 and FALSE is 0.
sum(l)
# which() function returns all the positions of all the TRUE elements 
which(l)

# unique(): returns the unique elements of a vector, that is, it returns a set of elements the vector consists without repetition.
v <- c(5, 6, 6, 2, 2, 3, 0, -1, 2, 5, 6)
unique(v)

# 1.4 Elementwise operations ####

# As opposed to functions that treat the vector as a single entity, some functions work on element of the vector as if it was a separate entity and return a vector of the result of the same length.
# Arithmetic functions:
1:10 * 2
sqrt(c(4, 16, 64))
# Logical operators:
x <- 1:5
x >= 3

# %in%: check whether a given value from one vector is present in another
1 %in% 1:10
11 %in% 1:10
# Alternative expressions
any(1:10 == 1)
any(1:10 == 11)

# When working with character values, the paste() function is useful to combine separate elements into a single string
paste("There are", "5", "books")
# paste() automatically converts numeric values into characters if characters are supplied
paste("Image", 1:5)
x <- 80
paste("There are", x, "books")
# paste0() function does the same as paste(), with the default value for the "sep" parameter being nothing
paste(1, 2, 3, sep = "")
paste0(1, 2, 3)

# 1.5 Recycling principle ####

# If we have two vectors of exactly the same length, the operation is performed on each consecutive pair of elements taken from the vectors
c(1, 2, 3) * c(10, 20, 30)
# If the lengths of the two vectors are not equal, the shorter vector is recycled before the operation is performed.
1:4 * 3
1:4 * c(3, 3, 3, 3) # same performance as the first.
# Values at the beginning of the shorter vector are attached to itself, sequentially and as many times as necessary, until the lengths of both vectors are matched.
c(1, 2, 3, 4) * c(3, 5)
# When the length of the longer vector is not a multiple of the shorter vector, recycling is incomplete and R gives a warning message
1:5 * c(1, 10, 100)

# 1.6 Subsetting vectors ####

# Creating subsets of data is one of the fundamental operations in data analysis.
# Subsetting with numeric vectors of indices: providing an index within the [] operator
x <- c(5, 6, 1, 2, 3, 7)
x[3]
x[1]
# Find out the value of the last element in a given vector using length()
x[length(x)] # length() returns its length, which is the last element.
# We can also assign new values to a subset of a vector
x <- 1:3
x[2] <- 300
x
# We can create a subset that is more than one element length
x <- c(43, 85, 10)
x[1:2]
x[c(3, 1)] # index vectors do not need to be composed of consecutive values, nor do they have to have an increasing order.
x <- 33:24
x[length(x):1]
# The vector of indices can also include repetitive values
x <- c(43, 85, 10)
x[rep(3, 4)] # rep(3, 4) creates a vector c(3, 3, 3, 3)
# The reclycling rule also applies to assignment into subsets
x <- 1:100
x[3:8] <- c(15, 16)
x # the value 15 and 16  are alternated until the six-element long subset vector is filled.

# Subsetting with logicals: supplying a logical vector within [] operator. The logical vector points out to the elements that need to be kept within the subset (whose indices match TRUE value).
x <- seq(85, 100, 2)
x > 90
x[x>90]
# Apply more complex conditions to select some very specific values
x[x>85 & x<90]
x[x>92 | x<86]
# If none of the elements satisfies the require condition (which results in the logical vector having all FALSE values), it results an empty vector
x[x>90 & x<90]

# 1.7 Missing values ####

# Missing values can arise in many situations during data collection and analysis, either when the required information could not be acquired for some reason or when, due to certain circumstances, we would like to exclude some data from an analysis by marking them as missing.
# In the spatial data analysis context, it can be that some districts in an area we surveyed were inaccessible for data collection by the researcher or some parts of an aerial image were clouded and we could not digitize features of interest there.
# The special value that marks missing value in R is NA. NA values are created when there are not enough information to provide a result.
x <- 1:10
x[100]

# Missing value and its effect on data
x <- c(2, 5, 1, 0)
mean(x)
x[2] <- NA
mean(x) # also results in NA.

# Detecting missing value in vectors with is.na() function
is.na(x)
# At times it's more convenient to check which values are not NA
!is.na(x)
# E.g, create a subset of only the non-missing elements in x
x[!is.na(x)]

# Performing calculations on vectors with missing values
mean(x[!is.na(x)])
# Many functions that require all values to be non-missing have na.rm parameter which indicates whether to remove the NA or not before executing the calcucation.
x <- c(3, 8, 2, NA, 1, 7, 5, NA, 9)
mean(x, na.rm = TRUE)
max(x, na.rm = TRUE)