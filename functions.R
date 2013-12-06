flow_dir <- function(w) { 
  s <- w
  values <- c(3,2,1,4,0,8,5,6,7)
  for (i in seq(1,length(w))){
    if (i %in% c(1,3,7,9)){ s[i] <- (w[5] - w[i]) / sqrt(2)}
    else {s[i] <- w[5] - w[i]}
  }
  max <- max(s)
  index <- match(max, s)
  return(values[index])
}
calc_flow_dir <- function(dem) {
  t0 <- Sys.time()
  w=matrix(1,nrow=3,ncol=3)
  dirdem <- focal(dem, w, fun=flow_dir)
  writeRaster(dirdem, filename="data/dirdem.tif", format="GTiff")
  minutes <- round(as.double( difftime(Sys.time(), t0, u = 'mins')))
  print(paste("ran function calc_flow_dir in", minutes, "minutes"))
}
dl_from_dropbox <- function(x, key) { 
  require(RCurl) 
  bin <- getBinaryURL(paste0("https://dl.dropboxusercontent.com/s/", key, "/", x), ssl.verifypeer = FALSE) 
  con <- file(x, open = "wb") 
  writeBin(bin, con) 
  close(con) 
  message(noquote(paste(x, "read into", getwd()))) 
}
dl_dirdem <- function() {
  dl_from_dropbox("dirdem.tif", "v68asekyagzytjl")
  file.copy("dirdem.tif", "data/dirdem.tif")
  file.remove("dirdem.tif")
}
plot_dirdem <- function(dirdem1, dirdem2) {
  cols <- c("white", brewer.pal(9, "Set1")[1:8])
  leg <- c("sink", "northeast", "north", "northwest", "west", "southwest", "south", "southeast", "east")
  opar <- par(mfrow=c(1,3))
  plot(dirdem1, col=cols, legend=F, ylim=c(-5, -3.5), xlim=c(135.4, 137.1))
  plot(dirdem2, col=cols, legend=F, ylim=c(-5, -3.5), xlim=c(135.4, 137.1))
  par(opar)
  legend("right", leg, fill=cols)
}
GRASS_watershed <- function(dem_loc, GRASS_dir) {
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
  seconds <- round(as.double( difftime(Sys.time(), t0, u = 'secs')))
  print(paste("ran function GRASS_watershed in",seconds, "seconds"))
}
compare_flow_dirs <- function(dirdem1,dirdem2,cat){
  t0 <- Sys.time()
  com1 <- mask(dirdem1,cat)
  com2 <- mask(dirdem2,cat)
  com <- com1
  for (i in seq(1,8)){
    for (j in seq(1,8)){
      com[com1 == i & com2 == j] <- as.integer(paste(i,j,sep=""))
    }
  }
  frequentie <- freq(com)
  names <- c("northeast", "north", "northwest", "west", "southwest", "south", "southeast", "east", "error")
  confusionmatrix <- matrix(nr=9, nc=9)
  rownames(confusionmatrix) <- names
  colnames(confusionmatrix) <- names
  for (i in seq(1,8)){
    confusionmatrix[seq(1,8),i] <- frequentie[seq((2 + i * 8),(9 + i * 8)),2]
  }
  for (i in seq(1:8)){
    confusionmatrix[i,9] <- round((sum(confusionmatrix[i,seq(1,8)]) - confusionmatrix[i,i]) / 
                                    sum(confusionmatrix[i,seq(1,8)]),2)
  }
  for (i in seq(1:8)){
    confusionmatrix[9,i] <- round((sum(confusionmatrix[seq(1,8),i]) - confusionmatrix[i,i]) / 
                                    sum(confusionmatrix[seq(1,8)],i),2)
  }
  minutes <- round(as.double( difftime(Sys.time(), t0, u = 'mins')))
  print(paste("ran function compare_flow_dirs in",minutes, "minutes"))
  return(confusionmatrix)
}



