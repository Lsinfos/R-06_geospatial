# 2. WORKING WITH TABLES

# 2.1 Using data frames to represent tabular data ####
# The data.frame class is the basic class to represent tabular data in R. A data frame is essentially a collection of vectors, all with the same length. The vectors don't have to be the same type, therefore, data frame is particularly suitable to represent data with different variables in columns and different cases in rows.
# Creating a data frame by combining available vectors:
num <- 1:4
lower <- c("a", "b", "c", "d")
upper <- c("A", "B", "C", "D")
df <- data.frame(num, lower, upper)
df # the columns' names are the names of the original vectors.
# The data frame could be created in a single step.
df <- data.frame(num = 1:4, 
                 lower = c("a", "b", "c", "d"),
                 upper = c("A", "B", "C", "D"))
# Adding rows to an existing data frames using rbind():
row5 <- c(5, "e", "E")
rbind(df, row5)
# Alternatively, add a fourth column using cbind():
word <- c("One", "Two", "Three", "Four") 
cbind(df, word)

# 2.2 Creating a table from a csv file ####
# Another common method to create data.frame object is importing tabular data from a CSV file using read.csv().
dat <- read.csv("Spain.csv") # contains monthly records of precipitation and temperature in Spain for a periods of 30 years. 
# Print only a few first rows of the data frame to examine, as this table is very large:
head(dat)
# Similarly, tail() prints last few rows.
tail(dat)
# The columns' contents:
# STATION: the meteorological station identification code
# STATION_NAME: the meteorological station's name
# ELEVATION: the elevation above sea level of the station (in meters)
# LATTITUDE: the latitude of the station (decimal degrees)
# LONGITUDE: the longitude of the station (decimal degrees)
# DATE: the date of the measurement
# TPCP: total monthly precipitation (0.1mm unit)
# MMXT: the mean monthly maximum temperature (0.1 degree Celcius units)
# MMNT: the mean monthly minimum temperature (0.1 degree Celcius units)

# 2.3 Examine the structure of a data frame ####
# Get the number of rows and columns using nrow() and ncol() functions, respectively: 
nrow(dat)
ncol(dat)
# Or get the lengths of both row and column using dim():
dim(dat)
# Get the names of the columns as a character vector: 
colnames(dat)
# Alternatively, rownames() could be used to get the name of the rows, but colnames() is more common.
# Assignment into column names can be made an existing name with a new one.
colnames(dat)[3] <- "Elev"
# Similarly, convert all column names from uppercase to lowercase using tolower():
colnames(dat) <- tolower(colnames(dat))
# Check again:
colnames(dat)
# It is frequently useful to examine the structure of a given object using the str(). This function prints the structure of its argument showing the data types of its components and the relations between them. 
str(dat)

# Subsetting a data frame by accessing separate columns with $ operator:
df$num
df$lower
df$upper
# Replace the missing values of measurements which are marked as -9999, a common encountered convention, with NA:
dat$tpcp[dat$tpcp == -9999] <- NA
dat$mmxt[dat$mmxt == -9999] <- NA
dat$mmnt[dat$mmnt == -9999] <- NA # $ operator refers to columns of the data.frame object (dat) rather than independent vectors.
# Convert tpcp to mm units and mmxt and mmnt values to degree Celsius:
dat$tpcp <- dat$tpcp / 10
dat$mmxt <- dat$mmxt / 10
dat$mmnt <- dat$mmnt / 10

# Using [] operator for indexing a data.frame object requires two dimensions:
df[2,3] # first index refers to rows, second index refers to columns.
# Leaving an empty space instead of the row's or column's index indicates selecting all elements of the respective dimension.
df[2,] # returns a data frame since 3 columns are involved.
df[,3] # returns a vector.
is.data.frame(df[,3])
# The parameter "drop" can be used to suppress the data frame simplification to remain a data frame no matter what.
df[ ,3, drop = FALSE]

# Using a character vector that indicates the names of the rows/columns:
df[df$lower %in% c("a", "d"), c("lower", "upper")] # request to get a subset of df with the rows being where the values of the lower column are either "a" or "d", and the columns are both lower and upper.

# Logical vectors could also be used to indicate whether to retain each row/column of the data frame and create a subset out of it.
# complete.cases(): returns a logical vector, indicating whether each row (case) is complete (has no NA value in it). The resulting logical vector can be used to remove the incomplete rows from a table:
dat[complete.cases(dat),]
# or to locate the cases with NA value:
dat[!complete.cases(dat),]

# New values can be assigned to a column with $ operator. If the assigned column does not exist in the table, a new column will be created to accommodate the data.
df$word[df$num == 2] <- "Two"
df
# Create two new columns in the climatic data holding the year and the month of each measurement. First, convert the date column into Date object:
dat$date <- as.Date(as.character(dat$date), format = "%Y%m%d")
# Extract the years and months:
dat$month <- as.numeric(format(dat$date, "%m"))
dat$year <- as.numeric(format(dat$date, "%Y"))
head(dat)
# Writing this new data frame to a csv file:
write.csv(dat, "dat.csv")

# 2.4 Flow control ####
# One of the most important themes in programming is the flow control - operations that are used to control the sequences of our code execution. 
# Conditional statements: the purpose of conditional statements is to condition the execution of a given code section. 
x <- 3
if (x > 2) {print("x is large!")}
# The condition should be an expression that returns a single logical value.
x <- 0
if (x > 2) {print("x is large!")} # the condition is FALSE, so the code is not executed.
# Optionally, the else operator can be used to add another code section. This will be executed when the condition in if is FALSE.
x <- 3
if (x > 2) {
  print("x is large!")
} else {print("x is small!")}
x <- 1 # run the code again and the else statement is executed.
# ifelse is another conditional operator, specialized in working on vectors element by element. Ifelse requires 3 arguments: a logical vector, a value for TRUE, and a value for FALSE. The result is a new vector with the same length where TRUE and FALSE are replaced with the alternative values.
x <- c(-1, -8, 2, 5, -3, 5, -9)
ifelse(x < 0, -x, x) # results a vector of absolute values.
# E.g, the first mode of operation is useful when we want to classify the values of a given vector into two categories, according to a condition.
dat$mmxt[1:7]
ifelse(dat$mmxt[1:7] < 10, "cold", "warm")

# Loops are used when a code selection needs to be executed repeatedly. The way the number of times a code selection is determined distinguishes the different types of loops.
# For loop is esp useful in many data analysis tasks. The code selection is executed for a predetermined number of times. This is equal to the number of elements in the vector initiating the loop.
for(i in 1:5) {print(i)} # the code is executed 5 times as the number of elements in the vector 1:5.

# Apply family  functions: The apply functions are a defining feature of R, they replace the necessity to write explicit loops in many common situations in data analysis, which make the code shorter and more elegant.
# The tapply() is used to apply a function over different selections of a vector, which requires 3 arguments:
# x: the vector that the function will operate upon.
# index: the vector that defines the subset of x
# A function that will be applied to the subsets of x.
# Using tapply to find out how many stations and which ones with at least one missing value within its respective time series of precipitation amount. For an individual station (such as the one named "IZANA SP"), we could check whether its tpcp column contains at least one NA:
any(is.na(dat[dat$station_name == "IZANA SP", "tpcp"])) # for one station.
result <- tapply(dat$tpcp, dat$station_name, 
                 function(x) any(is.na(x))) # for all stations.
# Check out the first 10 results:
result[1:10]
# Check how many stations have at least one missing value:
sum(result)
# Too see which stations these are, subset the result array with the array itself, since the TRUE values in that array exactly define the subset.
result[result]
# Extract the names of those stations:
names(result[result])
