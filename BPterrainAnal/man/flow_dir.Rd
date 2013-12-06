\name{flow_dir}
\alias{flow_dir}
\title{
Calculate the flow direction for a pixel.
}
\description{
This function can be used by a focal function to calculate a flow direction map from a dem.
}
\usage{
flow_dir(w)
}
\arguments{
  \item{w}{
The focal window.
}
}
\details{

}
\value{
The value is a number from 1-8. Times 45 to convert to degrees, starting at east, anti-clockwise. 0 if the pixel is the lowest in the window.
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
function (w) 
{
    s <- w
    values <- c(3, 2, 1, 4, 0, 8, 5, 6, 7)
    for (i in seq(1, length(w))) {
        if (i \%in\% c(1, 3, 7, 9)) {
            s[i] <- (w[5] - w[i])/sqrt(2)
        }
        else {
            s[i] <- w[5] - w[i]
        }
    }
    max <- max(s)
    index <- match(max, s)
    return(values[index])
  }

set.seed(1)
d=matrix(sample(0:9,9,replace=TRUE), nrow=3, ncol=3)
d
check <- flow_dir(d)
check
}
\keyword{}
\keyword{}
