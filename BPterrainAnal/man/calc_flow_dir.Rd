\name{calc_flow_dir}
\alias{calc_flow_dir}
\title{
Calculates flow direction using a focal function.
}
\description{
Calculates flow direction using a focal function.
}
\usage{
calc_flow_dir(dem)
}

\arguments{
  \item{dem}{
A digital terrain model. For example SRTM.
}
}
\details{

}
\value{
The function saves the result in the data folder under the name dirdem.tif.
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

function (dem) 
{
    t0 <- Sys.time()
    w = matrix(1, nrow = 3, ncol = 3)
    dirdem <- focal(dem, w, fun = flow_dir)
    writeRaster(dirdem, filename = "data/dirdem.tif", format = "GTiff")
    minutes <- round(as.double(difftime(Sys.time(), t0, units = "mins")))
    print(paste("ran function calc_flow_dir in", minutes, "minutes"))
  }
}

\keyword{ }
\keyword{  }
