\name{plot_dirdem}
\alias{plot_dirdem}

\title{
Plot two flow direction maps to a pdf.
}
\description{
The function plots two flow direction maps and a legend to a pdf in the folder plots.
}
\usage{
plot_dirdem(dirdem1, dirdem2)
}

\arguments{
  \item{dirdem1}{
First flow direction map.
}
  \item{dirdem2}{
Second flow direction map.
}
}
\details{
}
\value{
A pdf with two plots of the flow direction maps.
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
function (dirdem1, dirdem2) 
{
    cols <- c("white", brewer.pal(9, "Set1")[1:8])
    leg <- c("sink", "northeast", "north", "northwest", "west", 
        "southwest", "south", "southeast", "east")
    opar <- par(mfrow = c(1, 3))
    plot(dirdem1, col = cols, legend = F, ylim = c(-5, -3.5), 
        xlim = c(135.4, 137.1))
    plot(dirdem2, col = cols, legend = F, ylim = c(-5, -3.5), 
        xlim = c(135.4, 137.1))
    par(opar)
    legend("right", leg, fill = cols)
  }
}
\keyword{}
\keyword{}
