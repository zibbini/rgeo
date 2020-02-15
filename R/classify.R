
classify <- function(raster, at, labels = NULL){
  
  #' Classify a raster to specified thresholds
  #' 
  #' @description A faster implementation of the cut() function in the raster package for doing the same task.
  #' 
  #' @param raster The raster layer to classify.
  #' @param at The threshold(s) at which to classify.
  #' @param labels Labels for various thresholds. Defualt is numbered 1:n where n is the number of thresholds. 
  #' 
  #' @usage classify(raster, at, labels = NULL)
  #' 
  #' @details Note that unlike cut(), you do not have to supply a min and max value as both are computed within 
  #' the function. Further, the classified values are returned as a numeric vector and are not added to the raster layer 
  #' in the global environment. To do so you can simply re-assign them to the your raster object as follows:
  #' 
  #' raster@data@values <- classify(raster, at = c(thresholds), labels = NULL)
  #' 
  
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

docstring::docstring(classify)
