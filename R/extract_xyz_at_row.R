extract_xyz_at_row <- function(raster, startRow, rowNum) {
  
  #' Convert a raster layer to xyz format
  #' 
  #' @description A faster implementation of the rasterToPoints() function in the raster package for doing the same task.
  #' 
  #' @param raster The raster layer to convert.
  #' @param startRow The initial row to start conversion from.
  #' @param rowNum The number of rows to convert to xyz from the initial row.
  #' 
  #' @usage extract_xyz_at_row(raster, startRow, rowNum)
  #' 
  #' @details Note that this function only supports single raster layer objects. 
  #' Support for more complex raster objects will be added in due course.
  #' 
  
  xmin <- raster@extent@xmin
  ymin <- raster@extent@ymin
  ymax <- raster@extent@ymax
  xmax <- raster@extent@xmax
  nrows <- raster@nrows
  ncols <- raster@ncols
  
  x <- xmin + (((1:ncols) - 0.5) * ((xmax - xmin) / ncols))
  
  y <- ymax - (((1:((startRow + rowNum)-1)) - 0.5) * ((ymax - ymin) / nrows))
  
  if (requireNamespace("raster", quietly = TRUE)) {
    
    xyz <- data.frame(x = rep.int(x = x, times = rowNum),
                      y = rep(x = y, each = ncols), 
                      z = raster::getValues(raster, row = startRow, nrow = rowNum)
    )
    
  } else {
    
    stop("The raster package is required for this method.")
    
  }
  
  return(xyz)
  
}


