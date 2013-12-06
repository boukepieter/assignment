\name{dl_dirdem}
\alias{dl_dirdem}
\title{
Download dirdem.tif, result if the calc_flow_dir function.
}
\description{
The calc_flow_dir function takes quite a long time so for the example area the result can be downloaded from dropbox.
}
\usage{
dl_dirdem()
}
\details{
}
\value{
The result is a flow direction map saved in the data folder under the name dirdem.tif.
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
function () 
{
    dl_from_dropbox("dirdem.tif", "v68asekyagzytjl")
    file.copy("dirdem.tif", "data/dirdem.tif")
    file.remove("dirdem.tif")
  }
}
\keyword{}
\keyword{}
