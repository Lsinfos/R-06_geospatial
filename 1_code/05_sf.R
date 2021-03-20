# 5. SF PACKAGE

# Load the libraries for geospatial analysis
library(sf)
library(spData)

# Simple feature ####
# Simple features refers to a formal standard that describes how objects in the real world can be represented in computers, with emphasis on spatial geometry of these objects.
# Load the world dataset from spData package, which is a spatial object containing spatial and attribute columns:
data(world) 
# Check out the names of the columns:
names(world)
# # Simple feature objects in R are stored in a data frame, with geographic data occupying a special column, usually named "geom" or "geometry". Have an overview of the variables within the world object:
summary(world['lifeExp']) # also outputs a report on geometry.
# sf objects are easy to subset.
world_mini <- world[1:2, 1:3]
world_mini # output including additional geodata.

# Basic map making ####
# Basic maps are created in sf with plot().
plot(world) # creates multiple maps, one for each variable.
plot(world[3:6]) # plot multiple variables.
plot(world["pop"]) # plot a single variable.
# Plots are added as layers to existing images by setting add = TRUE. 
world_asia <- world[world$continent == 'Asia', ]
asia = st_union(world_asia)
plot(world['pop'], reset = FALSE)
plot(asia, add = TRUE, col = 'red')
# Adding layers this way can be used to verify the geographic correspondence between layers.
# Because sf extends base R plotting methods, plot()’s arguments also work with sf objects.
plot(world['continent'], reset = FALSE)
cex <- sqrt(world$pop) / 10000
world_cents <- st_centroid(world, of_largest = TRUE) # converts one geometry type to another (polygons to points), the aesthetics of which are varied in the cex argument.
plot(st_geometry(world_cents), 
     add = TRUE, 
     cex = cex)
# expandBB: specific argument to geodata.
india <- world[world$name_long == 'India', ]
plot(st_geometry(india),
     expandBB = c(0, 0.2, 0.1, 1),
     col = 'gray', lwd = 3)
plot(world_asia[0], add = TRUE)

# Geometry types ####