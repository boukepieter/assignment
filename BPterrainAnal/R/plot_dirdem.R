plot_dirdem <-
function(dirdem1, dirdem2) {
  cols <- c("white", brewer.pal(9, "Set1")[1:8])
  leg <- c("sink", "northeast", "north", "northwest", "west", "southwest", "south", "southeast", "east")
  opar <- par(mfrow=c(1,3))
  plot(dirdem1, col=cols, legend=F, ylim=c(-5, -3.5), xlim=c(135.4, 137.1))
  plot(dirdem2, col=cols, legend=F, ylim=c(-5, -3.5), xlim=c(135.4, 137.1))
  par(opar)
  legend("right", leg, fill=cols)
}
