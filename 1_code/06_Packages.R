# PACKAGES ####

# All predefined objects in R are collected in libraries or packages. Several are distributed with the R installation file, and some of them are automatically loaded into computer memory when starting R. E.g, to use the lattice pakage which is automatically installed with R, we still need to load it first
library(lattice)
# To install contributed packages from CRAN network, e.g, the reshape2
install.packages("reshape2")
install.packages("plyr")
# Download a package is a one-time procedure, unless a new version of the package came out and we need to reinstall it. However, to use the package we'll have to load it manually each time the program is restarted.
library(reshape2)
library(plyr)

# Reshape data wire reshape2 ####

# Reshaping operations are an inevitable step of every data analysis process since most of the time, the data we work with will be structured differently from what is required to use a given function or type of software.
# A wide table consists of columns for each measured variable, e.g
head(iris)
# A long table has a single column holds the variable names and another holds the measured values. To convert a wide table to a long one, use melt() from the reshape2 package
iris_melt <- melt(iris, id.vars = "Species") # id.vars: identifier variables, which describes each measured unit. 
iris_melt # 2 new columns are created, holding the measure variables names and values, respectively.

# Similarly, use melt() to convert the climatic table from previous example to a long table
dat <- read.csv("dat.csv")
dat_melt <- melt(dat, measure.vars = c("tpcp", "mmxt", "mmnt")) # specify which columns contain measured variables.
head(dat_melt)

# dcast() is also a function in reshape2 package, which casts the data back to wide format. Variables can be specified using a formular object: var1 + var2 + var3 ~.
# "." indicates no variable.
# "..." indicates all remaining variables.
dat2 <- dcast(dat_melt,...~ variable) # 
head(dat2)
# Alternatively we can have the months form new column
dat2 <- dcast(dat_melt, station + station_name + variable + year ~ month)
head(dat2) # This form is ideal to answer question like which month is the warmest in each station (using apply, e.g)
# Aggregation can also takes place within dcast()
dat2 <- dcast(dat_melt, year ~ variable, mean, na.rm = TRUE)
head(dat2)
# The disadvantage of aggregation with dcast() is that we must apply the same function across all variables.

# Aggregating with plyr ####

# The plyr package is intended to comprise an alternative, in many cases an easier one, to apply and other base R functions.
# ddply function operates on a data frame, splits the table to subsets according to the unique levels in one or more columns. The data from each subset is then used to calculate a single value, for each of the new columns in the new data frame.
# E.g, calculate the average area size of a flower's petals and sepals per species
ddply(iris, .(Species), summarize,
      sepal_area = mean(Sepal.Length * Sepal.Width),
      petall_area = mean(Petal.Length * Petal.Width))

# ddply() contains several arguments:
# input data frame (e.g: iris)
# the name(s) of the column(s), which defines subsets, in () and preceded by "." (more names will be separated by commas).
# mode of operation: summarize (new columns form a new, aggregrated, table), and transform (new columns are appended back to the input table).
# 4th argument and onward: user-specified extensions for calculation of new columns based on values in the original column.

# Calculate the iris data frame again with transform mode
ddply(iris, .(Species), transform,
      sepal_area = mean(Sepal.Length * Sepal.Width),
      petall_area = mean(Petal.Length * Petal.Width)) # original table is preserved, with 2 new columns joined in.

# Use ddply() to aggregate the climatic data table from a monthly to an annual timescale. Firs filter out those variable/year combinations where not all the 12 months are present.
dat3 <- ddply(dat_melt, .(station, year, variable), transform,
      months_available = length(value[!is.na(value)])) # remove NAs.
head(dat3)
# Using the new colum "month_available" to remove the combination with less than 12 months of data in order to reduce the bias in the annual average
dat3 <- dat3[dat3$months_available == 12, ]
# Next create a table to only hold the location data (latitude, longitude, elevation) for each metorological station
spain_stations <- ddply(dat3, .(station), summarize,
                        latitude = latitude[1],
                        longitude = longitude[1],
                        elevation = elevation[1])
head(spain_stations) # it's frequently useful to have such table, e.g, to plot the stations' spatial locations.
# Save this data frame for later use
write.csv(spain_stations, "spain_stations.csv", row.names = FALSE)
# Now aggregate the climatic data to find the sum of each month
spain_annual <- ddply(dat3, .(station, variable, year), summarize,
                      value = ifelse(variable[1] == "tpcp", 
                      sum(value, na.rm = TRUE),
                      mean(value, na.rm = TRUE)))
head(spain_annual)
# Save this data frame for later use, too
write.csv(spain_annual, "spain_annual.csv", row.names = FALSE)

# Joining tables with join() ####

# Working with spatial data often requires to join data from an external table (csv, Excel...) with the attribute table of a spatial data set (such as ESRI shapefile). Base R provides merge function to perform such tasks, but the simpler way is using join function from plyr package.
# Read a table that contains a serie of dates
dates <- read.csv("modis_dates.csv")
head(dates) # this table indicates the dates of the MODIS satellite images acquisition with the image column corresponding to bands in a multiband raster.
# Create a column for Date class
dates$Date <- as.Date(paste
                      (dates$year, dates$month, dates$day, sep = "-"))
head(dates)
# Now create a table of seasons
month <- c(12, 1:11)
season <- rep(c("winter", "spring", "summer", "fall"), each = 3)
seasons <- data.frame(month, season)
seasons # The table indicates which season a given month belongs to.
# Join the two tables: dates and seasons
dates <- join(dates, seasons, "month") # by default join() performs a left join (type = "left) which retains all rows of the left table. 
head(dates) # the 3rd argument (by = "month") of join() indicates which column to join. 

# Joining the stations and coordinate summary from spain_stations and the aggregated annual climatic data spain_annual.
combined <- join(spain_stations, spain_annual, 
                 by = "station", type = "right")
head(combined) # this table contains duplicate data since the latitude, longitude and elevation records are identical in each station/variable/year. In such cases, it's more efficient to keep two separate tables.