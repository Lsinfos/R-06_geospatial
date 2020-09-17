# 2. FUNCTIONS 

# 2.1 Parameters ####

# When specifying several arguments in a function, we need to assign each argument to the respective parameter using the operator =
# E.g, examine the seq() function. Seq() creates a sequential vector based on the input:
# from: This parameter specifies where to begin
# to: This parameter specifies where to end
# by: This parameter specifies the step size
seq(from = 100, to = 150, by = 10)
seq(from = 190, to = 150, by = -10)

# There are several important rules regarding function calls involving more than one argurment:
# The names of the parameters can be omitted as long as the arguments are entered in the default order, which specified in the function definition.
seq(from = 5, to = 10, by = 1)
seq(5, 10, 1) # two expressions are equivalent.
# The name of the first argument of the mean() function is x, but we can omit it during the function call
mean(1:10)
mean(x = 1:10)
# If the parameter names are specified, the arguments order can be altered
seq(to = 10, by = 1, from = 5)
# Argument can be skipped as long as they have a default value in the function definition.
seq(5, 10, 1)
seq(5, 10) # default by parameter is 1.

# 2.2 Creating vectors with parameters ####

# New vectors populated with default values (0 for numeric, "" for character, and FALSE for logical) can be created via vector() function, specifying the mode and length parameters
vector(mode = "numeric", length = 2)
vector(mode = "character", length = 10)
vector(mode = "logical", length = 3)

# Creating repetitive vectors with rep() function (rep for replicate) and specify how many times to replicate it
rep(x = 22, times = 10)
# rep() can operate on vectors longer than 1
x = c(18, 0, 9)
rep(x, 3)

# Substrings: extracting subsets of character strings 
x <- "Subsetting strings"
substr(x, start = 1, stop = 14)
substr(x, 6, 14)
substr(x, 1, 3)

# 2.3 Writing new functions ####

# A function is an object loaded into the computer's temporary and can be activated (usually with specific arguments) to perform a certain action. 
# Aside from built-in functions in R, new functions could be defined. E.g:
add_five <- function(x) {
  x_plus_five = x + 5
  return(x_plus_five)
}
# The components of the add_five function:
# the function's name: add_five
# the assignment operator: <-
# the function definition operator: function
# the function's parameters, possibly with default values, within (): x
# opening bracket for code section: {
# the function's body code: x_plus_five
# the definition of the returned value: return(x_plus_five)
# closing bracket for the code section: }

# The code that constitutes the function's body will run every time the function is called
add_five(5)
add_five(7)
# When a function is called, the object that are provided as arguments are assigned to local objects within the function's environment so that the function's code can use them. These objects exist only while the function runs and are inaccessible from the global environment after the function is defined.
x_plus_five # returns error.
# Every function returns a value that we would frequently like to preserve for subsequent calculations. 
result <- add_five(3)
result
# The return(x_plus_five) expression can be skipped since by default, the function returns the last created object (which is x_plus_five)
add_five <- function(x) x + 5

# 2.4 Setting default values for the arguments ####

# We can assign default arguments to parameters during the function's definition. This way, we will be able to skip some of the parameters during a function call. 
# If we call a functions without default value, it will result in error 
add_five()
# Provide a default value
add_five <- function(x = 1) x + 5
add_five()

# Many default functions in R have default arguments for some of the parameters
vector() # default arguments for the mode and length parameters of the vector function are "logical" and 0.
# There's no limitation for the class each argument in a function call must belong, as long as we have not defined those limitations
add_five("one") # returns an error.