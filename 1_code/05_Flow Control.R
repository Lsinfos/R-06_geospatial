# 5. FLOW CONTROL ####

# One of the most important themes in programming is the flow control - operations that are used to control the sequences of our code execution. 

# 5.1 Conditional statements ####

# The purpose of conditional statements is to condition the execution of a given code section. 
x <- 3
if (x > 2) {print("x is large!")}
# A conditional statement is composed of the following elements:
# The conditional statement operator (if)
# The conditional parenthese (), e.g, (x > 2)
# Code section opening bracket ({)
# The code section to execute when the condition is met (e.g, print(...))
# Code section closing bracket (})

# Importantly, the condition should be an expression that returns a single logical value. 
x <- 0
if (x > 2) {print("x is large!")} # the condition is FALSE, so the code is not executed.
# Optionally, the else operator can be used to add another code section. This will be executed when the condition in if is FALSE
x <- 3
if (x > 2) {
  print("x is large!")
  } else {print("x is small!")}
x <- 1 # run the code again and the else statement is executed.

# ifelse is another conditional operator, specialized in working on vectors element by element. Ifelse requires 3 arguments: a logical vector, a value for TRUE, and a value for FALSE. The result is a new vector with the same length where TRUE and FALSE are replaced with the alternative values.
x <- c(-1, -8, 2, 5, -3, 5, -9)
ifelse(x < 0, -x, x) # results a vector of absolute values.

# Import the climatic data from the previous exercise
dat <- read.csv("dat.csv")
dat$mmxt[1:7]
ifelse(dat$mmxt[1:7] < 10, "cold", "warm")

# 5.2 Loops ####

# Loops are used when a code selection needs to be executed repeatedly. The way the number of times a code selection is determined distinguishes the different types of loops.
# For loop is esp useful in many data analysis tasks. The code selection is executed for a predetermined number of times. This is equal to the number of elements in the vector initiating the loop.
for(i in 1:5) {print(i)} # the code is executed 5 times as the number of elements in the vector 1:5.
# A for loop expression includes the following components:
# The for loop operator (for)
# The name of the object that will get the consecutive vector elements in each run (e.g, i)
# The in operator (in)
# The loop vector (e.g, 1:5)
# The code selection to be executed repeatedly (e.g, print(i))

# 5.3 Apply family  functions ####

# The collection of apply functions are used to apply a function we choose over subsets of object, and then join the results to form into a single object once again. The apply functions are a defining feature of R, they replace the necessity to write explicit loops in many common situations in data analysis, which make the code shorter and more elegant.
# The tapply() is used to apply a function over different selections of a vector, which requires 3 arguments:
# x: the vector that the function will operate upon.
# index: the vector that defines the subset of x
# A function that will be applied to the subsets of x.

# Use an available dataset in R as an example
iris
# Create a random subset of 6 rows (out of the original 150) 
iris <- iris[sample(1:nrow(iris), 6), ] # since it's a random sample, the exact values will be different each time.
# Using tapply, we can quickly find out, e.g, the average petal width per species
x <- tapply(iris$Petal.Width, iris$Species, mean)
x
# The returned object is an array, which is a vector with an additional attribute stating the number and size of its dimensions. The array is named using the values in the grouping vector.
x["setosa"]
# The array could be transformed to a vector 
as.numeric(x)
# The apply functions are similar to loops in purpose and concept, but much simpler and clearer in syntax. E.g, the tapply() example can be performed with a for loop
x <- NULL
for(i in unique(iris$Species)) {
  x <- c(x, mean(iris$Sepal.Width[iris$Species == i]))
}
names(x) <- unique(iris$Species)
x

# Using tapply for the climic data to find out how many stations and which ones with at least one missing value within its respective time series of precipitation amount.
any(is.na(dat[dat$station_name == "IZANA SP", "tpcp"])) # for one station.
result <- tapply(dat$tpcp, dat$station_name, 
                 function(x) any(is.na(x))) # for all stations.
# Check out the first 10 results
result[1:10]
# Check how many stations have at least one missing value
sum(result)
# Too see which stations these are, subset the result array with the array itself, since the TRUEU values in that array exactly define the subset
result[result]
# Extract the names of those stations
names(result[result])

# apply() is also used to apply a certain function on subsets of data, but instead of operating on subsets defined by a grouping object, it does this on the margins of an array. The 1st and 3rd arguments are similar to tapply(), but the 2nd parameter defines the dimension across which we would like to apply the function.
apply(iris[ ,1:4], 1, mean) # find out the mean measured value for each of the five individual plants by averaging the values on the first dimension (row).
apply(iris[ ,1:4], 2, mean) # find out the mean measured value for the 4 measured traits by avaraging the second dimension (column).
# Additional arguments can also be passed in apply(), which, in turn, be passed to the specific applied function. E.g, mean() has an additional parameter, na.rm, which can be set to FALSE in apply().
# Assign a NA value to the table for example
iris[3,2] <- NA 
iris
# Use apply with mean() and its default setting
apply(iris[ ,1:4], 2, mean) # result in a NA.
# Set na.rm = TRUE
apply(iris[ ,1:4], 2, mean, na.rm = TRUE)