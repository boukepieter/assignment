flow_dir <-
function(w) { 
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
