\name{GRASS_watershed}
\alias{GRASS_watershed}
\title{
Using GRASS watershed function the basin and flow directions are calculated.
}
\description{
GRASS is used for some terrain analysis. First with the dem the function watershed is used, after that the ´big basin´ is calculated by selecting the outflow coordinate. The result is written in the data folder.
}
\usage{
GRASS_watershed(dem_loc, GRASS_dir)
}
\arguments{
  \item{dem_loc}{
The location of the dem file to be used.
}
  \item{GRASS_dir}{
The directory where GRASS is installed.
}
}
\details{
}
\value{
The resulting maps are saved in the data folder. These include drainage, basin, bigbasin, accumulation and stream.
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
function (dem_loc, GRASS_dir) 
{
    t0 <- Sys.time()
    initGRASS(GRASS_dir, home = tempdir(), override = T)
    execGRASS("r.in.gdal", flags = "o", parameters = list(input = dem_loc, 
        output = "DEM"))
    execGRASS("g.region", parameters = list(rast = "DEM"))
    execGRASS("r.watershed", flags = "overwrite", parameters = list(elevation = "DEM", 
        stream = "stream", threshold = as.integer(10000), drainage = "drainage", 
        basin = "basin", accumulation = "accumulation"))
    execGRASS("r.thin", flags = "overwrite", parameters = list(input = "stream", 
        output = "streamt"))
    execGRASS("r.water.outlet", flags = "overwrite", parameters = list(drainage = "drainage", 
        basin = "bigbasin", easting = "136.04007", northing = "-4.57661"))
    execGRASS("r.out.gdal", parameters = list(input = "drainage", 
        format = "GTiff", output = "data/drainage.tif"))
    execGRASS("r.out.gdal", parameters = list(input = "basin", 
        format = "GTiff", output = "data/basin.tif"))
    execGRASS("r.out.gdal", parameters = list(input = "bigbasin", 
        format = "GTiff", output = "data/bigbasin.tif"))
    execGRASS("r.out.gdal", parameters = list(input = "accumulation", 
        format = "GTiff", output = "data/accumulation.tif"))
    execGRASS("r.out.gdal", parameters = list(input = "stream", 
        format = "GTiff", output = "data/stream.tif"))
    seconds <- round(as.double(difftime(Sys.time(), t0, units = "secs")))
    print(paste("ran function GRASS_watershed in", seconds, "seconds"))
  }
GRASS_dir <- "C:/Program Files (x86)/GRASS GIS 6.4.3"
dl_from_dropbox("dem.tif", "5xy13ptwjoj5cie")
GRASS_watershed("dem.tif", GRASS_dir)
}
\keyword{}
\keyword{}
