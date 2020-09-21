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
    to = as.Date("2013-02-01"), by = 3)
    
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
