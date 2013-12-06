# Watersheds
dir.create("data/watershed")
download.file('http://earlywarning.usgs.gov/hydrodata/sa_shapefiles_zip/as_bas_30s_beta.zip', 
              destfile='as_bas_30s_beta.zip')
unzip('as_bas_30s_beta.zip', exdir="data/watershed")

x.min <- "135"
y.min <- "-5"
x.max <- "139"
y.max <- "-3"
out.shape.file <- "M:/geo-scripting/assignment_scratch/data/watershed/clip2.shp"
in.shape.file <- "M:/geo-scripting/assignment_scratch/data/watershed/as_bas_30s_beta.shp"
system(paste('"C:/Program Files (x86)/FWTools2.4.7/bin/ogr2ogr" -clipsrc ', x.min, y.min, x.max, y.max, 
             out.shape.file, in.shape.file))

catchments_papua <- readOGR(dsn=out.shape.file, layer="clip2")
big_catchments <- catchments_papua[catchments_papua$AREA_SQKM > 10,]

# Papua shape
indonesia <- raster::getData("GADM", country = "IDN", level = 1)
papua <- indonesia[indonesia$NAME_1 == "Papua",]
writeOGR(papua, "data", "papua", "ESRI Shapefile")

# Select river
point <- drawPoly()
projection(point) <- projection(big_catchments)
keep <- gContains( point, big_catchments,byid=TRUE )
catchments <- big_catchments[keep[,1],]
catchments@data
Rivercatch <- catchments[catchments$AREA_SQKM > 1000,]

plot(papua)
plot(Rivercatch, col="Blue", add=T)

writeOGR(Rivercatch, dsn="data/watershed", layer="catchment", driver="ESRI Shapefile", overwrite_layer=T)

# SRTM
# dir.create("data/SRTM")
extent(Rivercatch)
for (y in seq(3,5)){
  for (x in seq(135,137)){
    filename <- paste("S0", y, "E", x, ".hgt.zip", sep="")
         download.file(paste("http://dds.cr.usgs.gov/srtm/version2_1/SRTM3/Eurasia/", filename, sep=""), 
                       destfile=paste("data/SRTM/", filename, sep=""))
    unzip(paste("data/SRTM/", filename, sep=""), exdir="data/SRTM")
  }
}
for (y in seq(3,5)){
  for (x in seq(135,137)){
    filename <- paste("S0", y, "E", x, ".hgt", sep="")
    dem_add <- raster(paste("data/SRTM/", filename, sep=""))
    dem <- merge(dem, dem_add)
  }
}
extent <- drawExtent()
dem_river <- crop(dem, extent)
plot(dem_river)
plot(Rivercatch, add=T)
writeRaster(dem_river, filename="data/dem.tif", format="GTiff")
