
classify <- function(raster, at, labels = NULL){
  
  if (requireNamespace("raster", quietly = TRUE)) {
    
    if (enoughRAM(raster)) {
      
      rasterVal  <- raster::getValues(raster)
      thresholds <- c(min(rasterVal), unique(at), max(rasterVal))
      
      if (is.null(labels)) {
        
        .bincode(rasterVal, breaks = thresholds, right = TRUE, include.lowest = TRUE)
        
      } else if (length(labels) == (length(thresholds) - 1)){
        
        classVals <- .bincode(rasterVal, breaks = thresholds, right = TRUE, include.lowest = TRUE)
        factor(classVals, seq_along(labels), labels, ordered = FALSE)
        
      } else {
        
        stop("Labels supplied not equal to number of levels to be classified. 
            See details in ?classify for more info.")
      }
      
    } else {
      
      stop("Raster size too large for processing in memory.")
      
    }
    
  } else {
    
    stop("Package raster required for this function.")
  
  }
}
