\name{compare_flow_dirs}
\alias{compare_flow_dirs}
\title{
Compare two flow direction datasets.
}
\description{
The function takes two flow direction maps and compares it using a confusion matrix.
}
\usage{
compare_flow_dirs(dirdem1, dirdem2, cat)
}

\arguments{
  \item{dirdem1}{
The first of the two flow direction (raster) maps
}
  \item{dirdem2}{
The second of the two flow direction (raster) maps
}
  \item{cat}{
A map of the catchment for which they have to be compared. The flowdir maps will be masked by this raster.
}
}
\details{

}
\value{
The result is a confusion matrix conf
}
\references{

}
\author{
B.P. Ottow
}
\note{
}

\seealso{
}
\examples{
## The function is currently defined as
function (dirdem1, dirdem2, cat) 
{
    t0 <- Sys.time()
    com1 <- mask(dirdem1, cat)
    com2 <- mask(dirdem2, cat)
    com <- com1
    for (i in seq(1, 8)) {
        for (j in seq(1, 8)) {
            com[com1 == i & com2 == j] <- as.integer(paste(i, 
                j, sep = ""))
        }
    }
    frequentie <- freq(com)
    names <- c("northeast", "north", "northwest", "west", "southwest", 
        "south", "southeast", "east", "error")
    confusionmatrix <- matrix(nr = 9, nc = 9)
    rownames(confusionmatrix) <- names
    colnames(confusionmatrix) <- names
    for (i in seq(1, 8)) {
        confusionmatrix[seq(1, 8), i] <- frequentie[seq((2 + 
            i * 8), (9 + i * 8)), 2]
    }
    for (i in seq(1:8)) {
        confusionmatrix[i, 9] <- round((sum(confusionmatrix[i, 
            seq(1, 8)]) - confusionmatrix[i, i])/sum(confusionmatrix[i, 
            seq(1, 8)]), 2)
    }
    for (i in seq(1:8)) {
        confusionmatrix[9, i] <- round((sum(confusionmatrix[seq(1, 
            8), i]) - confusionmatrix[i, i])/sum(confusionmatrix[seq(1, 
            8)], i), 2)
    }
    return(confusionmatrix)
    minutes <- round(as.double(difftime(Sys.time(), t0, units = "mins")))
    print(paste("ran function compare_flow_dirs in", minutes, 
        "minutes"))
  }
}
\keyword{}
\keyword{}
