# 3. DATES AND TIME SERIES

# A time serie is a sequence of values, each associated with a time index. The simplest way to represent a time series is to have two separate vectors with the same length of data values, and time, each element corresponding to the respective vector.

# Reading climatic data ####

# Load the real-world data from the National Oceanic and Atmospheric Administration (NOAA) National Climatic Data Center. This file contains daily rainfall and temperature data from a meteorological station at Albuquerque International Airport, New Mexico from March 1, 1931 to May 15, 2014.
dat <- read.csv("NOAA.csv", stringsAsFactors = FALSE) # a CSV file is used to store plain tabular data with no additional features that are common in spreadsheet files like XLS.
# Assign the values in DATE and TMAX columns to two separate vectors
time <- dat$DATE # represents time
tmax <- dat$TMAX # stands for maximum temperature.

# Converting character values to dates ####

# Dates can be represented in R using a special format which allows certain special operations to be performed (not possible with characters). There are several classes for dates and time in R. The simplest class is called Date, which is used to represent calendar dates.
x <- Sys.Date() # return the current date.
class(x)
x # A Date object is printed the same way as a character vector. However, it has additional attributes not present in the vector class.
# We can conduct calculations involving time intervals with Date
x + 7 # tells which date would be in 7 days.
x - 1000 # tells what the date was 1000 days ago.
# Switch between the character vector and Date classes
x <- as.character(x)
class(x)
# Convert the character vector back to Date
x <- as.Date(x)
class(x)
# We can create a sequence of consecutive dates using seq()
seq(from = as.Date("2013-01-01"), 
    to = as.Date("2013-02-01"), by = 3) # gives consecutive dates separated by three days from each other, from January 1st to February 1st 2013.
    
# Common encoding types of year, month, and day elements and theire respective symbols in R:
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

# Examine time and the tmax vectors. First, find out both are numeric data
class(time)
class(tmax)
# See what the values of these vectors look like by printing the first 10 values from each one of them
time[1:10] # contains dates in %Y%m%d format.
tmax[1:10]
# Convert time into Date object. First convert numeric data to character
time <- as.Date(as.character(time), format = "%Y%m%d") 
time[1:10]
class(time)
# Now that is a vector of dates, we have more freedom to treat data as a time series.

# Examine time series ####

# View the documentation on climic data from NOAA
View(dat)
# The missing value marked as -9999. Convert -9999 to NA
tmax[tmax == -9999] <- NA
# The temperature is provided in tenths of Celsius degree. Convert to Celsius units
tmax <- tmax / 10
tmax[1:10]
# Check the range of values each vector contains
range(time) # from March 1st, 1931 to May 15th, 2014.
range(tmax, na.rm = TRUE)
# The values of time seems to be consecutive dates. Prove that again by comparing a consecutive sequence all_dates covering the time period from March 1st, 1931 to May 15th, 2014.
range_t <- range(time)
all_dates <- seq(range_t[1], range_t[length(range_t)], 1)
length(all_dates)
length(time) # missing at least one date.
# Check how many and which dates are missing. First, verify if all dates appear in the time vector
all(all_dates %in% time) # FALSE.
# Next question will be which ones are missing?
which(!all_dates %in% time) # the missing date is the 5499th element.
# Call the date by using index
all_dates[which(!all_dates %in% time)]
# Manually examine the CSV file and confirm that the date March 20th 1946 is skipped for some reason.
# Another interesting question is what day had the highest temperature?
max(tmax, rm.na = TRUE)
time[which.max(tmax)] # on June 26th 1994 the highest temperature was 41.7.

# Creating subsets based on dates ####

# If we're interested in a particular subset of the time series, e.g, from December 31st 2005 to January 1st 2014, we could create a subset of the dates in that time period. First, create a logical vector pointing at all the dates we want to keep:
w <- time > as.Date("2005-12-31") & time < as.Date("2014-1-1")
# Find out the ratio between the subset and the number of days in the complete series
sum(w)/length(w) # about 9.6% of the total amount of data.
# Use vector w to create subsets of both time and tmax vectors
time <- time[w]
tmax <- tmax[w]
# Note that the selection is not inclusive of the end dates, since we use > and < operators, instead of >= and <=.
range(time)

# Introducing graphical functions ####

# Display vectors using base graphics
plot(tmax) # the value of the tmax vector are plotted on the y axis as a function of their index on the x axis.
# When plotting a time series, we would usually like to have the time of observation on the x axis and see the line graph rather than data points:
plot(time, tmax, type = "l") # "l" argument indicates a line plot.
# Notice that the time vector is automatically formatted so that year breakpoints are labeled on the x axis.
# The plot could also use this expression
plot(tmax ~ time, type = "l") # the ~ operator creates a special type of object, a formular object: tmax is the dependent variable, and time is the independent variable.

# There are other graphic systems in R aside from Base R: lattice and ggplot2. Create a data frame with labels for x and y axes.
dat <- data.frame(time = time, tmax = tmax)
# Base graphics
plot(tmax ~ time, dat, type = "l")
# With lattice
library(lattice)
xyplot(tmax ~ time, data = dat, type = "l")
# With ggplot2
library(ggplot2)
ggplot(dat, aes(x = time, y = tmax)) +
  geom_line()
# The difference is sometimes just a matter of taste, but there are some non-overlapping features among these 3 systems.