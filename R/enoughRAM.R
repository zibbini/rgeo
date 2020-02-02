enoughRAM <- function(raster) {
  
  require(magrittr)
  
  osName <- Sys.info()[["sysname"]]
  
  if (osName == "Windows") {
    
    x <- system2("wmic", args =  "OS get FreePhysicalMemory /Value", stdout = TRUE)
    x <- x[grepl("FreePhysicalMemory", x)]
    x <- gsub("FreePhysicalMemory=", "", x, fixed = TRUE)
    x <- gsub("\r", "", x, fixed = TRUE) %>% as.integer()
    
  } else if (osName == 'Linux') {
    
    x <- system2('free', args='-k', stdout=TRUE)
    x <- strsplit(x[2], " +")[[1]][4] %>% as.integer()
    
  } else {
    stop("OS not supported. See details in ?get_freeMemoryKB for more info.")
  }
  
  if (rasterSize(raster = raster, format = "kb", verbose = FALSE)*2 >= x/2) {
    return(FALSE)
  } else { 
    return(TRUE)}
  
}



# Transform to check if there is enough ram available for retrieving the raster values
# have separate values assigned to each datatype
# Is datatype of raster equal to any of the recognised datatypes in R
# If yes, multiply by corresponding byte size of each format, divide by 1000 for kB and then check if < 
# available ram. If yes, proceed with normal method, if not, proceed with paralle method processing chunks at
# a time.

# Batch calculation needs to consider available ram, as well as available to each node or thread.
# Then calculate based on this multiple. Assign number of values to compute based on this. 

