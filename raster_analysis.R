#required raster and GIS libraries
install.packages("raster")
install.packages("rgdal")
install.packages("rgeos")
install.packages("RColorBrewer")
install.packages("tmap")

library(raster)
library(rgdal)
library(rgeos)
library(RColorBrewer)
library(tmap)

setwd("M:\\Remote sensing_Google Street View")
#loading data
image<-raster("M:\\Remote sensing_Google Street View\\ndvi_above023.tif")

# class       : RasterLayer 
# dimensions  : 10905, 8293, 90435165  (nrow, ncol, ncell)
# resolution  : 0.6, 0.6  (x, y)
# extent      : 561250.4, 566226.2, 4180287, 4186830  (xmin, xmax, ymin, ymax)
# coord. ref. : +proj=utm +zone=10 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0 
# data source : M:\Remote sensing_Google Street View\sunset_ndvi.tif 
# names       : sunset_ndvi 
# values      : -0.7061611, 0.5964125  (min, max)

#0.23 NDVI threshold used to seperate trees and healthy grass
#converts values above 0.25 to 1 and others to zero

trees_nearROAD<-image>0.23
tm_shape(trees_nearROAD)+tm_raster(palette = "Greys")+tm_legend(outside=TRUE,text.size=.8)

image[image<1]<-NA

pol<-rasterToPolygons(image,dissolve = TRUE)

writeRaster(image,"M:\\Remote sensing_Google Street View\\ndvi_above023_only.tif")


writeOGR(pol,dsn='.',layer = 'pol',driver="ESRI Shapefile")








