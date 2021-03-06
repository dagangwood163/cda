% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rgl.r
\name{rgl.ellipsoids}
\alias{rgl.ellipsoids}
\title{rgl.ellipsoids}
\usage{
rgl.ellipsoids(positions, sizes, angles, colour = "red", ...)
}
\arguments{
\item{positions}{matrix of positions}

\item{sizes}{matrix of axis lengths}

\item{angles}{matrix of Euler angles}

\item{colour}{colour of each ellipsoid}

\item{...}{additional params}
}
\value{
rgl mesh
}
\description{
Create a list of rgl ellipsoids oriented in space
}
\details{
each ellipsoid is specified by its position, dimensions, and Euler angles
}
\examples{
cl <- helix(0.5, 1, 36, delta=pi/6, n.smooth=1e3)
sizes <- equal_sizes(0.04,0.02,0.02,NROW(cl$positions))
\dontrun{ require(rgl) ; rgl.ellipsoids(cl$positions, sizes, cl$angles, col="gold") }
}
\seealso{
Other user_level rgl: \code{\link{rgl.ellipsoid}}
}
\author{
baptiste Auguie
}
\concept{user_level rgl}
