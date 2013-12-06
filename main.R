# Author: B.P. Ottow
# Date: 06-12-2013
#
# Dependencies: rasta, spgrass6, RCurl, BPterrainAnal
# Depends also on GRASS 6 installation.
# Change the location of the GRASS installation here:
GRASS_dir <- "C:/Program Files (x86)/GRASS GIS 6.4.3"

# The goal of this script is doing some terrain analysis with R and GRASS
# and comparing the results with each other and existing datasets.
# The starting point is a SRTM dem for the area of a watershed in Papua.
# First with this dem a flow direction map will be calculated making use
# of a focal function. Then GRASS will be used to produce a flowdirection
# map as well. These two flow direction maps will be compared with a plot
# and a confusionmatrix. The GRASS function delivers a basin map as well.
# This map will be visually compared with the watershed given by HydroSHED.

# installing dependencies and loading packages and input data
install.packages("spgrass6", dependencies=T)
install.packages("RCurl", dependencies=T)
# for windows computer: (tested and works)
install.packages('BPterrainAnal_1.0.zip', repos = NULL, dependencies = TRUE)
# for non-windows computers: (not tested)
install.packages('BPterrainAnal_1.0.tar.gz', repos = NULL, dependencies = TRUE)
# if package doesn't work use:
# source("functions.R")
library(BPterrainAnal)
dir.create("plots/")
source("readdata.R") 


# calculate flow direction with focal function
# Running the function takes quite long, 23 minutes on my laptop
# The result is saved on dropbox, the second function can be used to download
# the map, that will be much quicker.
calc_flow_dir(dem) # 23 minutes
dl_dirdem() # much shorter
dirdem <- raster("data/dirdem.tif") 

# GRASS watershed
GRASS_watershed("data/dem.tif", GRASS_dir)

# Load in result
basin <- raster("data/basin.tif")
bigbasin <- raster("data/bigbasin.tif")
drainage <- raster("data/drainage.tif")

# Compare the two different flow accumulation maps
# plot (in pdf)
draindem <- drainage
projection(draindem) <- projection(dem)
draindem[drainage < 0] <- NA
pdf("plots/mygraph.pdf", width=7, height=3)
plot_dirdem(dirdem, draindem)
dev.off()
# confusion matrix:
cat <- rasterize(refcatchment, dem)
conf <- compare_flow_dirs(dirdem, draindem, cat)
conf

## Compare basin results
# plot of all (sub)basins:
plot(basin)
plot(refcatchment, add=T)
# The subbasin boundaries are quite similar to the HydroSHED boundary.

# plot of final catchment:
plot(bigbasin)
plot(refcatchment, border="white", add=T)
# Apparantly not all subbasins are connected due to sinks.
# This can be overcome using the RSAGA package and SAGA GIS to fill the sinks.