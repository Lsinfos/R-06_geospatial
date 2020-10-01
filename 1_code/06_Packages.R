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