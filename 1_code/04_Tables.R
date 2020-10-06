# 4. TABLES

# Working with tables is central to programming in R, both with regards to spatial analysis (e.g, working with attribute tables of geometries).

# 4.1 Data.frame class ####

# The data.frame class is the basic class to represent tabular data in R. A data.frame object is essentially a collection of vectors, all with the same length. The vectors don't have to be the same type, therefore, data.frame object is particularly suitable to represent data with different variables in columns and different cases in rows.
# Creating a data.frame object by combining available vectors
num <- 1:4
lower <- c("a", "b", "c", "d")
upper <- c("A", "B", "C", "D")
df <- data.frame(num, lower, upper)
df # the names of the columns are the names of the original vectors.
# The data.frame object could be created in a single step
df <- data.frame(num = 1:4, 
                 lower = c("a", "b", "c", "d"),
                 upper = c("A", "B", "C", "D"))
# Adding rows to an existing data.frame object using rbind() functions
row5 <- c(5, "e", "E")
rbind(df, row5)
# Alternatively, add a fourth column using cbind() function
word <- c("One", "Two", "Three", "Four") 
cbind(df, word)

# 4.2 Import CSV files ####

# Another common method to create data.frame object is importing tabular data from a CSV file using read.csv() function
dat <- read.csv("Spain.csv") # contains monthly records of precipitation and temperature in Spain for a periods of 30 years. 
# Print only a few first rows of the data frame, as this table is very large
head(dat)
# Similarly, tail() function prints last few rows
tail(dat)
# The columns' contents:
# STATION: the meteorological station identificaion code
# STATION_NAME: the meteorological station's name
# ELEVATION: the elevation above sea level of the station (in meters)
# LATTITUDE: the lattitude of the station (decimal degrees)
# LONGITUDE: the longitude of the station (decimal degrees)
# DATE: the date of the measurement
# TPCP: total monthly precipation (0.1mm unit)
# MMXT: the mean monthly maximum temperature (0.1 degree Celcius units)
# MMNT: the mean monthly minimum temperature (0.1 degree Celcius units)

# 4.3 Examine the structure of a data.frame object ####

# Get the number of rows and columns using nrow() and ncol() functions, respectively. 
nrow(dat)
ncol(dat)
# Or get the lengths of both row and column dimensions using dim() function
dim(dat)
# Get the names of the columns as a character vector 
colnames(dat)
# Alternatively, rownames() could be used to get the name of the rows, but colnames() is more common.
# Assignment into column names can be made an existing name with a new one
colnames(dat)[3] <- "Elev"
# Similarly, convert all column names from uppercase to lowercase using tolower() function
colnames(dat) <- tolower(colnames(dat))
# Check again
colnames(dat)

# It is frequently useful to examine the structure of a given object using the str(). This function prints the structure of its argument showing the data types of its components and the relations between them. 
str(dat)

# 4.4 Subsetting data.frame objects ####

# Subsetting a data frame by accessing separate columns with $ operator
df$num
df$lower
df$upper
# Replace the missing values of measurements which are marked as -9999, a commonl encountered convention, with NA
dat$tpcp[dat$tpcp == -9999] <- NA
dat$mmxt[dat$mmxt == -9999] <- NA
dat$mmnt[dat$mmnt == -9999] <- NA # $ operator refers to columns of the data.frame object (dat) rather than independent vectors.
# Convert tpcp to mm units and mmxt and mmnt values to degree Celsius
dat$tpcp <- dat$tpcp / 10
dat$mmxt <- dat$mmxt / 10
dat$mmnt <- dat$mmnt / 10

# Using [] operator for indexing a data.frame object requires 2 dimensions
df[2,3] # first index refers to rows, second index refers to columns.
# Leaving and empty space instead of the row's or column's index indicates selecting all elements of the respective dimension
df[2,] # returns a data frame since 3 columns are involved.
df[,3] # returns a vector.
is.data.frame(df[,3])
# The parameter "drop" can be used to suppress the data frame simplification to remain a data frame no matter what
df[ ,3, drop = FALSE]

# Using a character vector that indicates the names of the rows/columns
df[df$lower %in% c("a", "d"), c("lower", "upper")] # request to get a subset of df with the rows being where the values of the lower column are either "a" or "d", and the columns are both lower and upper.

# Logical vectors could also be used to indicate whether to retain each row/column of the data frame and create a subset out of it.
# complete.cases() returns a logical vector, indicating whether each row (case) is complete (has no NA value in it). The resulting logical vector can be used to remove the incommplete rows from a table:
dat[complete.cases(dat),]
# or to locate the cases with NA value
dat[!complete.cases(dat),]

# 4.5 Calculating new data fields ####

# New values can be assigned to a column with $ operator. If the assigned column does not exist in the table, a new column will be created to accomodate the data
df$word[df$num == 2] <- "Two"
df
# Create two new columns in the climatic data holding the year and the month of each measurement. First, convert the date column into Date object
dat$date <- as.Date(as.character(dat$date), format = "%Y%m%d")
# Extract the years and months
dat$month <- as.numeric(format(dat$date, "%m"))
dat$year <- as.numeric(format(dat$date, "%Y"))
head(dat)
# Writing this new data frame to a csv file ####
write.csv(dat, "dat.csv")