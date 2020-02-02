extract_xyz <- function(raster) {
  
  xmin <- raster@extent@xmin
  ymin <- raster@extent@ymin
  ymax <- raster@extent@ymax
  xmax <- raster@extent@xmax
  nrows <- raster@nrows
  ncols <- raster@ncols
  
  x <- xmin + (((1:ncols) - 0.5) * ((xmax - xmin) / ncols))
  
  y <- ymax - (((1:nrows) - 0.5) * ((ymax - ymin) / nrows))
  
  if (requireNamespace("raster", quietly = TRUE)) {
    
    xyz <- na.omit(data.frame(x = rep.int(x = x, times = nrows),
                              y = rep(x = y, each = ncols), 
                              z = raster::getValues(raster, row = 1, nrow = nrows))
    )
    
  } else {
    
    stop("The raster package is required for this method.")
    
  }
  
  return(xyz)
  
}
