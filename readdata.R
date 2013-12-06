# Author: B.P. Ottow
# Date: 06-12-2013
# Dependencies: Rasta, RCurl, BPterrainAnal

# Data downloaded and preprocessed in readdata2.R
# The result is loaded here.

# https://www.dropbox.com/s/5xy13ptwjoj5cie/dem.tif
dl_from_dropbox("dem.tif", "5xy13ptwjoj5cie")
file.copy("dem.tif", "data/dem.tif")
file.remove("dem.tif")

# SRTM DEM for catchment
dem <- raster("data/dem.tif") 

# HydroSHEDS catchment boundary
refcatchment <- readOGR(dsn="data", layer="catchment") 