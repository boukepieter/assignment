\name{dl_from_dropbox}
\alias{dl_from_dropbox}

\title{
Downdload files from dropbox.
}
\description{
To run the main script several datasets are needed, some of them can be downloaded from dropbox.
}
\usage{
dl_from_dropbox(x, key)
}
\arguments{
  \item{x}{
the full name of the file
}
  \item{key}{
the key provided by dropbox
}
}
\details{
}
\value{
The file is downloaded to the workspace.
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
function (x, key) 
{
    require(RCurl)
    bin <- getBinaryURL(paste0("https://dl.dropboxusercontent.com/s/", 
        key, "/", x), ssl.verifypeer = FALSE)
    con <- file(x, open = "wb")
    writeBin(bin, con)
    close(con)
    message(noquote(paste(x, "read into", getwd())))
  }

# example
dl_from_dropbox("dem.tif", "5xy13ptwjoj5cie")
}
\keyword{}
\keyword{}
