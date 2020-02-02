rasterSize <- function(raster, format = "mb", verbose = TRUE) {
  
  byteSize   <- unlist(strsplit(raster@file@datanotation, split = ""))
  rasterSize <- raster@ncols * raster@nrows * as.numeric(byteSize[4])
  
  if (format == "gb") {
    rasterSize <- c(rasterSize / 10^9, format)
  } else if (format == "mb") {
    rasterSize <- c(rasterSize / 10^6, format)
  } else if (format == "kb") {
    rasterSize <- c(rasterSize / 10^3, format)
  } else {
    stop("Format not recognised, see details in ?rasterSize for more info.")
  }
  
  if (verbose == TRUE) {
    cat("Raster object is of size:", rasterSize[1], rasterSize[2])
  } else {
    return(as.numeric(rasterSize[1]))
  }
  
}