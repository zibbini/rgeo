freeRAM <- function() {
  
  #' Memory related functions
  #' 
  #' @description Calculates how much RAM is available in the current R session. Output is in kB. 
  
  require(magrittr, quietly = TRUE)
  
  osName <- Sys.info()[["sysname"]]
  
  if (osName == "Windows") {
    
    x <- system2("wmic", args =  "OS get FreePhysicalMemory /Value", stdout = TRUE)
    x <- x[grepl("FreePhysicalMemory", x)]
    x <- gsub("FreePhysicalMemory=", "", x, fixed = TRUE)
    gsub("\r", "", x, fixed = TRUE) %>% as.integer()
    
  } else if (osName == 'Linux') {
    
    x <- system2('free', args='-k', stdout=TRUE)
    strsplit(x[2], " +")[[1]][4] %>% as.integer()
    
  } else {
    stop("OS not supported. See details in ?get_freeMemoryKB for more info.")
  }
}

docstring::docstring(freeRAM)