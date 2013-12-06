GRASS_watershed <-
function(dem_loc, GRASS_dir) {
  t0 <- Sys.time()
  # initialize and input
  initGRASS(GRASS_dir, home=tempdir(), override=T)
  execGRASS("r.in.gdal", flags="o", parameters=list(input=dem_loc, output="DEM"))
  execGRASS("g.region", parameters=list(rast="DEM"))
  # processing
  execGRASS("r.watershed", flags="overwrite", 
            parameters=list(elevation="DEM", stream="stream",
                            threshold=as.integer(10000),
                            drainage="drainage", basin="basin", accumulation="accumulation"))
  execGRASS("r.thin", flags="overwrite", parameters=list(input="stream", output="streamt"))
  execGRASS("r.water.outlet", flags="overwrite", parameters=list(drainage="drainage", basin="bigbasin", easting="136.04007", northing="-4.57661"))
  # out
  execGRASS("r.out.gdal", parameters=list(input="drainage", format="GTiff", output="data/drainage.tif"))
  execGRASS("r.out.gdal", parameters=list(input="basin", format="GTiff", output="data/basin.tif"))
  execGRASS("r.out.gdal", parameters=list(input="bigbasin", format="GTiff", output="data/bigbasin.tif"))
  execGRASS("r.out.gdal", parameters=list(input="accumulation", format="GTiff", output="data/accumulation.tif"))
  execGRASS("r.out.gdal", parameters=list(input="stream", format="GTiff", output="data/stream.tif"))
  seconds <- round(as.double( difftime(Sys.time(), t0, units = 'secs')))
  print(paste("ran function GRASS_watershed in",seconds, "seconds"))
}
