batches_to_process <- function(raster, threads) {
  
  startRow <- ceiling(seq(1, raster@nrows, length.out = threads))
  rowNum     <- diff(startRow)
  
  rowNum[length(rowNum)] <- rowNum[length(rowNum)] + 1
  startRow[length(startRow)] <- NA
  startRow <- na.omit(startRow)
  
  return(
    data.frame(threadID = 1:(threads - 1), startRow, rowNum)
  )
}
