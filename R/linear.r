##' extinction spectrum
##'
##' extinction spectrum
##' @title extinction_spectrum
##' @param cluster list describing a cluster
##' @param material list
##' @param n medium refractive index
##' @param progress logical, display progress bar
##' @return data.frame
##' @author baptiste Auguie
linear_extinction_spectrum <- function(cluster, material, n=1.33, progress=FALSE){
  
  k0 <- 2*pi/material$wavelength
  kn <- k0*n
  invalpha <- make.invalpha(cluster, material, polarizability.fun=polarizability.ellipsoid, n=n, kuwata=TRUE)
  
    Nwavelengths <- length(k0)
    Nparticles <- nrow(cluster$r)
    
    stopifnot(is.matrix(invalpha),
              is.matrix(clust$r), 
              is.matrix(clust$angles))

    stopifnot(ncol(invalpha)/3 == Nparticles,
              nrow(invalpha) == Nwavelengths)
  
  res <- data.frame(linear$linear_extinction_spectrum(kn, invalpha, cluster$r,
                          cluster$angles, as.integer(progress)))
  names(res) <- c('s', 'p')
  res$wavelength <- material$wavelength
  melt(res, meas=c("s", "p"))

}

##' dispersion spectrum
##'
##' dispersion spectrum
##' @title dispersion_spectrum
##' @param cluster list describing a cluster
##' @param angles matrix of incident Euler angles
##' @param material list
##' @param n medium refractive index
##' @param progress logical, display progress bar
##' @param full logical
##' @return data.frame
##' @author baptiste Auguie
dispersion_spectrum <- function (cluster,  angles, material, n = 1.33, progress = FALSE, invert=FALSE) 
{
    k0 <- 2 * pi/material$wavelength
    kn <- k0 * n

    
    invalpha <- make.invalpha(cluster, material, polarizability.fun = polarizability.ellipsoid, 
        n = n, kuwata = TRUE)
    
    Nwavelengths <- length(k0)
    Nparticles <- nrow(cluster$r)
    Nangles <- nrow(angles)
    
    stopifnot(is.matrix(invalpha),
              is.matrix(angles),
              is.matrix(clust$r), 
              is.matrix(clust$angles))

    stopifnot(ncol(invalpha)/3 == Nparticles,
              nrow(invalpha) == Nwavelengths)

       
    res <- linear$dispersion_spectrum(kn, invalpha, 
                                      clust$r, clust$angles, angles,
                                      as.integer(full), as.integer(invert))
    
    rbind(
          data.frame(wavelength = rep(material$wavelength, each=Nangles),
                     angles=angles[rep(seq.int(Nangles), Nwavelengths), ],
                     value = c(res[, 1, , drop=TRUE]),
                     type="extinction", polarisation="p"),
          data.frame(wavelength = rep(material$wavelength, each=Nangles),
                     angles=angles[rep(seq.int(Nangles), Nwavelengths), ],
                     value = c(res[, 2, , drop=TRUE]),
                     type="absorption", polarisation="p"),
          data.frame(wavelength = rep(material$wavelength, each=Nangles),
                     angles=angles[rep(seq.int(Nangles), Nwavelengths), ],
                     value = c(res[, 3, , drop=TRUE]),
                     type="extinction", polarisation="s"),
          data.frame(wavelength = rep(material$wavelength, each=Nangles),
                     angles=angles[rep(seq.int(Nangles), Nwavelengths), ],
                     value = c(res[, 4, , drop=TRUE]),
                     type="absorption", polarisation="s")
          )
}
