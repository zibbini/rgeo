enoughRAM <- function(raster) {
  
  #' Memory related functions
  #' 
  #' @description Calculate if there is enough ram for processing the raster object in the memory assigned to the 
  #' current R session.
  #' 
  #' @param raster A given raster layer. 
  #' 
  #' @usage enoughRAM(raster)
  #' 
  #' @details TRUE or FALSE are returned based on if there is enough ram for processing the raster in memory. 
  
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

docstring::docstring(enoughRAM)
