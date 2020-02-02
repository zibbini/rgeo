extract_xyz_at_row <- function(raster, startRow, rowNum) {
  
  xmin <- raster@extent@xmin
  ymin <- raster@extent@ymin
  ymax <- raster@extent@ymax
  xmax <- raster@extent@xmax
  nrows <- raster@nrows
  ncols <- raster@ncols
  
  x <- xmin + (((1:ncols) - 0.5) * ((xmax - xmin) / ncols))
  
  y <- ymax - (((1:((startRow + rowNum)-1)) - 0.5) * ((ymax - ymin) / nrows))
  
  if (requireNamespace("raster", quietly = TRUE)) {
    
    xyz <- na.omit(data.frame(x = rep.int(x = x, times = rowNum),
                      y = rep(x = y, each = ncols), 
                      z = raster::getValues(raster, row = startRow, nrow = rowNum))
    )
    
  } else {
    
    stop("The raster package is required for this method.")
    
  }
  
  return(xyz)
  
}
