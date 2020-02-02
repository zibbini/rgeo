max_raster <- function(raster){
  
  if (requireNamespace("raster", quietly = TRUE)) {
    
    max <- max(getValues(raster), na.rm = TRUE)
    
  } else {
    
    stop("The raster package is required for this method.")
    
  }
  
  return(max)
  
}