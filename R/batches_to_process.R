# Currently not in use, to be used with parallel methods.

batches_to_process <- function(raster, threads) {
  
  startRow <- ceiling(seq(1, raster@nrows, length.out = threads))
  rowNum   <- diff(startRow)
  
  rowNum <- rowNum - 1
  rowNum[length(rowNum)] <- rowNum[length(rowNum)] + 1
  startRow[length(startRow)] <- NA
  startRow <- na.omit(startRow)
  endRow <- startRow + rowNum
  
  return(
    data.frame(threadID = 1:(threads - 1), startRow, rowNum, endRow)
  )
}
