# rgeo

This repo is an effort at consoloditating the current raster tools available on R and producing further optimised revisions of such tools. Currently, manipulating and analysing large geospatial data in R is both a rocky and slow process if you don't have a particularly fast machine. Further, not all methods work as intended and often use sub-optimal solutions. 

To illustrate, below are the results for classifying and extracting the xyz values of a relatively large raster. Test results compare functions written here and those found in the `raster` package. All testing was conducted on a system with an i5-7300u and 8gb RAM, with Manjaro XFCE as the operating system on linux. 

The test data used here is a digital terrain model (DTM) of Plymouth and the surrounding areas, at a resolution of ~1m. This DTM is ~317.9 Mb in GeoTiff format and contains roughly 79 million points. It was constructed from the ascii LIDAR files: SX45ne, SX45nw, SX45se, SX45sw, SX46se, SX46sw, SX55nw, SX55sw, SX56sw, which can be downloaded [here](https://environment.data.gov.uk/DefraDataDownload/?Mode=survey). 

### Classifying results

Here the the raster was classified to four thresholds: min, 2m, 5m and max. 

``` r
library(raster)
DTM <- raster("DTM.tif")

# rgeo 
microbenchmark::microbenchmark(classify(test, at = c(2,5)), times = 10L) 

# raster package
microbenchmark::microbenchmark(raster::cut(test, breaks = c(-10.08, 2, 5, 126.170)), times = 10L)
```

*Unit: seconds*

expr | min | lq | mean | median | uq | max | neval
--- | --- | --- | --- | --- | --- | --- | ---
classify(test, at = c(2, 5)) | 3.039677 | 3.054341 | 3.08061 | 3.064573 | 3.070116 | 3.269607 | 10
raster::cut(test, breaks = c(-10.08, 2, 5, 126.17)) | 3.851293 | 7.822391 | 7.560331 | 8.01715 | 8.06603 | 8.207009 | 10

### Extracting xyz results

Here the DTM was simply converted to an xyz dataframe. 

``` r
library(raster)
DTM <- raster("DTM.tif")

# rgeo 
microbenchmark::microbenchmark(extract_xyz(test), times = 10L)

# raster package
microbenchmark::microbenchmark(raster::rasterToPoints(test), times = 10L)
```
*Unit: seconds*

expr | min | lq | mean | median | uq | max | neval
--- | --- | --- | --- | --- | --- | --- | ---
extract_xyz(test) | 3.976426 | 4.1043 | 4.095051 | 4.106489 | 4.110322 | 4.116398 | 10
raster::rasterToPoints(test) | 4.927814 | 12.77142 | 12.00122 | 12.78671 | 12.79453 | 12.80327 | 10

## Summary

Both results show that a substantial reduction in time taken can be found when revising current available methods. Speed-ups of up to ~3x were found, with revisions remaining pure R based and not offloading any computation onto a faster C language. 

## Further information

Please note that the methods included in this repo are S3 functions and only support single raster layers. The S4 methods found in the `raster` package are still the best choice for handling more complex raster objects. 
