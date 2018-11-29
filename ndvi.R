library(raster)
library(rgdal)
library(rgeos)

library(RColorBrewer)
options(stringsAsFactors = FALSE)

setwd("M:\\Remote sensing_Google Street View\\Oakland_kaiser_NAIP")

naip<-stack("m_3712214_se_10_h_20160531.tif")

naip_br<-brick(naip)

naip_ndvi <- (naip_br[[4]] - naip_br[[1]]) / (naip_br[[4]] + naip_br[[1]])

writeRaster(x = naip_ndvi,
            filename="naip_ndvi.tif",
            format = "GTiff", # save as a tif # save as a INTEGER rather than a float
            overwrite = TRUE) 
hist(naip_ndvi,
     main = "NDVI_Oakland",
     col = "blue",
     xlab = "NDVI Index Value")

naip_ndwi <- (naip_br[[2]] - naip_br[[4]]) / (naip_br[[2]] + naip_br[[4]])

writeRaster(x = naip_ndwi,
            filename="naip_ndwi.tif",
            format = "GTiff", # save as a tif # save as a INTEGER rather than a float
            overwrite = TRUE)