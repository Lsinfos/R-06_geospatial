# 1. WORKING WITH VECTORS AND TIME SERIES

# 1.1 Different types of vectors ####
# A vector is an ordered collection of values of the same type. Three types of values that are useful for most purposes are numeric, character and logical.
# Single elements are also represented in R as vectors (of length 1).
10 # number 10 at the position 1.
# Vectors can be created from individual elements with c() function (stands for combine).
c(1, 5, 10, 4)
c("cat", "dog", "mouse", "apple")
# Sequential numeric vectors can be easily created with ":" operator. The ":" operator  creates an ordered vector starting at the value to the left and ending at the value to the right of the ":" symbol.
7:20
# Or when the first argument is larger than the second one:
33:24
# A logical vector can be also created with c().
c(TRUE, FALSE, TRUE, TRUE) # in practice, the creation of the logical vectors is usually employed with a conditional operator on a vector. 
# Convert between vector types:
as.character(33:24) # convert the numeric value to  character value.
as.numeric(as.character(33:24)) # convert back to numeric value.

# Factor: a special type of encoding for a vector, where the vector has a defined set of acceptable values or levels, most common in statistical use. 
factor(c("cat", "dog", "dog"))
factor(c("cat", "dog", "dog", "mouse")) # the acceptable levels of the resulting factor object are by default, defined as a set of unique values that the vector has.

# 1.2 Objects ####
# Saving immediate results is essential to automate processes. Without saved objects, we can't make sequential operations with each created object serving as an input for the next step(s).
# Assignment: saving objects to temporary memory using an assignment operator "<-".
v <- 1:10
# Access the newly created object by using its name:
v
# When assigning an object with a name that already exists in the memory, the older object is overwritten.
x <- 55
x
x <- "Hello"
x

# ls(): returns a character vector with the names of all the user-defined objects in a given environment.
ls()
# rm(): removes objects from memory.
rm(v)
# Remove all objects from memory:
rm(list = ls())
# Check again the list of objects: 
ls() # character(0) indicates an empty character vector.

# 1.3 Operations on vectors ####
# Many functions in R are intended to work with vectors, most common are used to find out vectors' properties.
v <- 1:10
# Find out the average value:
mean(v)
# Find out the minimal and maximal value:
min(v)
max(v)
# Get both minimal and maximal at once:
range(v)
# Find out the number of elements, or length, a given vector has:
length(v)
# which.min() and which.max() return the position of the minimal or maximal element in a numeric vector.
which.min(v)
which.max(v)

# With logical values, we sometimes want to know whether they contain at least one TRUE value or whether all of their values are TRUE.
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

# As opposed to functions that treat the vector as a single entity, some functions work on element of the vector as if it was a separate entity and return a vector of the result of the same length.
# Arithmetic functions:
1:10 * 2
sqrt(c(4, 16, 64))
# Logical operators:
x <- 1:5
x >= 3
# %in%: check whether a given value from one vector is present in another.
1 %in% 1:10
11 %in% 1:10
# Alternative expressions:
any(1:10 == 1)
any(1:10 == 11)

# When working with character values, the paste() function is useful to combine separate elements into a single string
paste("There are", "5", "books")
# paste() automatically converts numeric values into characters if characters are supplied.
paste("Image", 1:5)
x <- 80
paste("There are", x, "books")
# paste0() does the same as paste(), with the default value for the "sep" parameter being nothing.
paste(1, 2, 3, sep = "")
paste0(1, 2, 3)

# If we have two vectors of exactly the same length, the operation is performed on each consecutive pair of elements taken from the vectors.
c(1, 2, 3) * c(10, 20, 30)
# If the lengths of the two vectors are not equal, the shorter vector is recycled before the operation is performed.
1:4 * 3
1:4 * c(3, 3, 3, 3) # same performance as the first.
# Values at the beginning of the shorter vector are attached to itself, sequentially and as many times as necessary, until the lengths of both vectors are matched.
c(1, 2, 3, 4) * c(3, 5)
# When the length of the longer vector is not a multiple of the shorter vector, recycling is incomplete and R gives a warning message.
1:5 * c(1, 10, 100)

# 1.4 Subsetting vectors ####
# Creating subsets of data is one of the fundamental operations in data analysis.
# Subsetting with numeric vectors of indexes: providing an index within the [] operator
x <- c(5, 6, 1, 2, 3, 7)
x[3]
x[1]
# Find out the value of the last element in a given vector using length():
x[length(x)] # length() returns its length, which is the last element.
# We can also assign new values to a subset of a vector.
x <- 1:3
x[2] <- 300
x
# We can create a subset that is more than one element length.
x <- c(43, 85, 10)
x[1:2]
x[c(3, 1)] # index vectors do not need to be composed of consecutive values, nor do they have to have an increasing order.
x <- 33:24
x[length(x):1]
# The vector of indices can also include repetitive values.
x <- c(43, 85, 10)
x[rep(3, 4)] # rep(3, 4) creates a vector c(3, 3, 3, 3)
# The recycling rule also applies to assignment into subsets.
x <- 1:100
x[3:8] <- c(15, 16)
x # the value 15 and 16  are alternated until the six-element long subset vector is filled.

# Subsetting with logicals: supplying a logical vector within [] operator. The logical vector points out to the elements that need to be kept within the subset (whose indexes match TRUE value).
x <- seq(85, 100, 2)
x > 90
x[x>90]
# Apply more complex conditions to select some very specific values:
x[x>85 & x<90]
x[x>92 | x<86]
# If none of the elements satisfies the require condition (which results in the logical vector having all FALSE values), it results an empty vector.
x[x>90 & x<90]

# 1.4 Missing values ####
# Missing values can arise in many situations during data collection and analysis.
# In the spatial data analysis context, it can be that some districts in an area we surveyed were inaccessible for data collection by the researcher or some parts of an aerial image were clouded and we could not digitize features of interest there.
# The special value that marks missing value in R is NA. NA values are created when there are not enough information to provide a result.
x <- 1:10
x[100]
# Missing value and its effect on data:
x <- c(2, 5, 1, 0)
mean(x)
x[2] <- NA
mean(x) # also results in NA.
# Detecting missing value in vectors with is.na() function:
is.na(x)
# At times it's more convenient to check which values are not NA.
!is.na(x)
# E.g, create a subset of only the non-missing elements in x:
x[!is.na(x)]

# Performing calculations on vectors with missing values:
mean(x[!is.na(x)])
# Many functions that require all values to be non-missing have na.rm parameter which indicates whether to remove the NA or not before executing the calculation.
x <- c(3, 8, 2, NA, 1, 7, 5, NA, 9)
mean(x, na.rm = TRUE)
max(x, na.rm = TRUE)

# 1.5 Dates and time series ####
# A time series is a sequence of values, each associated with a time index. The simplest way to represent a time series is to have two separate vectors with the same length of data values, and time, each element corresponding to the respective vector.
# Load the real-world data from the National Oceanic and Atmospheric Administration (NOAA) National Climatic Data Center. This file contains daily rainfall and temperature data from a meteorological station at Albuquerque International Airport, New Mexico from March 1, 1931 to May 15, 2014.
dat <- read.csv("Albuquerque.csv") # a CSV file is used to store plain tabular data with no additional features that are common in spreadsheet files like XLS.
# Assign the values in DATE and TMAX columns to two separate vectors:
time <- dat$DATE # represents time
tmax <- dat$TMAX # stands for maximum temperature.

# Dates can be represented in R using a special format which allows certain special operations to be performed (not possible with characters). There are several classes for dates and time in R. The simplest class is called Date, which is used to represent calendar dates.
x <- Sys.Date() # return the current date.
class(x)
x # A Date object is printed the same way as a character vector. However, it has additional attributes not present in the vector class.
# We can conduct calculations involving time intervals with Date.
x + 7 # tells which date would be in 7 days.
x - 1000 # tells what the date was 1000 days ago.
# Switch between the character vector and Date classes
x <- as.character(x)
class(x)
# Convert the character vector back to Date:
x <- as.Date(x)
class(x)
# We can create a sequence of consecutive dates using seq().
seq(from = as.Date("2013-01-01"), 
    to = as.Date("2013-02-01"), by = 3) # gives consecutive dates separated by three days from each other, from January 1st to February 1st 2013.

# Common encoding types of year, month, and day elements and their respective symbols in R:
# %d: Day, e.g: 15
# %m: Months in number, e.g: 08
# %b: the first characters of a month, e.g, Aug
# $B: the full name of a month. e.g, August
# %y: the last 2 digits of a year, e.g, 16
# %Y: the full year, e.g: 2016    
# Using this symbology, along with the format parameter of as.Date(), we can convert character values of other formats to dates. 
as.Date("07/Aug/12") # error, not in standard format.
as.Date("07/Aug/12", format = "%d/%b/%y")
as.Date("2012-August-07", format = "%Y-%B-%d")
# Once we have a Date object, we can extract its elements (year, month, day) and encode them using format() function.
d <- as.Date("1955-11-30")
d
format(d, "%B")
format(d, "%Y")
format(d, "%m/%Y")

# Examine time and the tmax vectors. First, find out if both are numeric data:
class(time)
class(tmax)
# See what the values of these vectors look like by printing the first 10 values from each one of them:
time[1:10] # contains dates in %Y%m%d format.
tmax[1:10]
# Convert time into Date object. First convert numeric data to character
time <- as.Date(as.character(time), format = "%Y%m%d") 
time[1:10]
class(time)
# Now that is a vector of dates, we have more freedom to treat data as a time series.

# View the documentation on climatic data from NOAA:
View(dat)
# The missing value marked as -9999. Convert -9999 to NA:
tmax[tmax == -9999] <- NA
# The temperature is provided in tenths of Celsius degree. Convert to Celsius units:
tmax <- tmax / 10
tmax[1:10]
# Check the range of values each vector contains:
range(time) # from March 1st, 1931 to May 15th, 2014.
range(tmax, na.rm = TRUE)
# The values of time seems to be consecutive dates. Prove that again by comparing a consecutive sequence all_dates covering the time period from March 1st, 1931 to May 15th, 2014.
range_t <- range(time)
all_dates <- seq(range_t[1], range_t[length(range_t)], 1)
length(all_dates)
length(time) # missing at least one date.
# Check how many and which dates are missing. First, verify if all dates appear in the time vector
all(all_dates %in% time) # FALSE.
which(!all_dates %in% time) # the missing date is the 5499th element.
# Call the date by using index:
all_dates[which(!all_dates %in% time)]
# Another interesting question is what day had the highest temperature?
max(tmax, rm.na = TRUE)
time[which.max(tmax)] # on June 26th 1994 the highest temperature was 41.7.

# If we're interested in a particular subset of the time series, e.g, from December 31st 2005 to January 1st 2014, we could create a subset of the dates in that time period. First, create a logical vector pointing at all the dates we want to keep:
w <- time > as.Date("2005-12-31") & time < as.Date("2014-1-1")
# Find out the ratio between the subset and the number of days in the complete series:
sum(w)/length(w) # about 9.6% of the total amount of data.
# Use vector w to create subsets of both time and tmax vectors:
time <- time[w]
tmax <- tmax[w]
# Note that the selection is not inclusive of the end dates, since we use > and < operators, instead of >= and <=.
range(time)