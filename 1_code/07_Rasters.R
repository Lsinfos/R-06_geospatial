# RASTERS

# A raster is essentialy a matrix with spatial reference information. Similarly, a multiband raster is essentially a three-dimensional array with spatial reference information. 

# Matrix ####

# A matrix is a two-dimensional collection of elements, all of the same type, where the number of elements in all rows and all columns is identical.
# Create a matrix with the matrix function by specifying its values in form of a vector and dimensions
matrix(1:6, ncol = 3)
# Parameters of a matrix:
# data: the vector of the values for the matrix(e.g, 1:6)
# nrow: the number of rows
# ncol: the number of columns
# byrow: whether the matrix is filled column by column (FALSE by default) or row by row (TRUE by default).
matrix(1:6, nrow = 3)
matrix(1:6, nrow = 2) #nrow and ncol parameters determine the number of rows and columns, respectively. 
# Whe the allocated number of cells is smaller or larger than the number of values in the vector that is being used to populate the matrix, the vector is either deprecated or recycled, respectively.
matrix(12:1, ncol = 4, nrow = 2)
matrix(12:1, ncol = 4, nrow = 4)

# Useful functions to examine the properties of a matrix are analogous to the functions used for vectors and data frames.
x <- matrix(7:12, ncol = 3, byrow = TRUE)
x
length(x)
# nrow() and ncol() returns the number of rows and colums respectively
nrow(x)
ncol(x)
# dim function returns both numbers of rows and columns
dim(x)

# Convert  a matrix into a vector 
as.vector(x)
# Matrices can be subsetted using two-dimensional indices
x[, c(1,3)] 
x[2, ] # all the values of 2nd row.
# Using the apply function to make calculation on rows or column of a matrix.
apply(x, 2, mean)
# There are also specific functions for calculating rows and columns respectively
colMeans(x)
