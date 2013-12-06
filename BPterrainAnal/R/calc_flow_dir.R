calc_flow_dir <-
function(dem) {
  t0 <- Sys.time()
  w=matrix(1,nrow=3,ncol=3)
  dirdem <- focal(dem, w, fun=flow_dir)
  writeRaster(dirdem, filename="data/dirdem.tif", format="GTiff")
  minutes <- round(as.double( difftime(Sys.time(), t0, units = 'mins')))
  print(paste("ran function calc_flow_dir in", minutes, "minutes"))
}
