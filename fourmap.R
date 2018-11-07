rm(list=ls())
setwd("C:/Users/firat/Desktop/maptrial")
library("foreign")
library("rgdal")
install.packages("rgeos")
library("rgeos")
#install.packages("sp")
library("sp")
library("tmap")
library("leaflet")
library("RColorBrewer")
library(foreign)
gedata <-read.dbf("ge.dbf", as.is = FALSE)
head(gedata)
ge <- readOGR(".", "ge")
head(ge)
str(ge@data)
#OA.Census <- merge(ge, map, by.x="NAME", by.y="NAME")
#head(OA.Census)
plot(ge$AKP1Nov2015, ge$CONS1Nov2015)

tm_shape(ge) + tm_borders(alpha=.4)
proj4string(ge) <- CRS("+init=EPSG:4326")
#OA.Census <-SpatialPolygonsDataFrame(OA.Census, proj4string = CRS("+init=EPSG:5637"))
#crs(OA.Census) 

tm_shape(ge) + tm_borders(alpha=.4) +
  tm_shape(ge) + tm_dots(col = "AKP16", palette = "Reds", style = "quantile") 

tm_shape(ge) + tm_borders(alpha=.4) + 
  tm_shape(ge) + tm_bubbles(size = "AKP16", col = "AKP16", palette = "Blues", style = "quantile", legend.size.show = FALSE, title.col = "AKP %") +
  tm_layout(legend.text.size = 0.5, legend.title.size = 1, legend.position = c("left", "bottom"), frame = TRUE) 

tm_shape(ge) + tm_fill("AKP16", palette = "Reds", style = "equal", title = "%AKP16") + 
  tm_borders(alpha=.4) + tm_borders(alpha=.4)+
  tm_shape(ge) + tm_bubbles(size = "CONS16", col = "CONS16", palette = "Blues", style = "equal", legend.size.show = FALSE, title.col = "%CONS16") +
  tm_layout(legend.text.size = 0.5, legend.title.size = 1, legend.position = c("left", "bottom"), frame = FALSE) 

tm_shape(ge) + tm_fill("AKP16", n = 4, palette = "Reds", style = "equal", title = "%AKP16") + 
  tm_borders(alpha=.4) +  tm_borders(alpha=1.5) + tm_shape(ge) + tm_bubbles(size = "CONS16", col = "CONS16", palette = "Blues", style = "equal", legend.size.show = FALSE, title.col = "%CONS16") +
  tm_layout(legend.outside=TRUE, legend.text.size = 0.5, legend.title.size = 1, legend.outside.position = c("right","bottom"), frame = TRUE) 

map1<-tm_shape(ge) + tm_fill("AKP07", n = 4, palette = "Reds", style = "equal", title = "%AKP07") + 
  tm_borders(alpha=.8) + tm_borders(alpha=.4)+
  tm_shape(ge) + tm_bubbles(size = "CONS07", col = "CONS07", n = 4, palette = "Blues", style = "equal", legend.size.show = FALSE, title.col = "%CONS07") +
  tm_layout(legend.text.size = 0.2, legend.title.size = 0.4, legend.position = c("left", "bottom"), frame = FALSE) 

map2<-tm_shape(ge) + tm_fill("AKP11", n = 4, palette = "Reds", style = "equal", title = "%AKP11") + 
  tm_borders(alpha=.8) + tm_borders(alpha=.4)+
  tm_shape(ge) + tm_bubbles(size = "CONS11", col = "CONS11", n = 4, palette = "Blues", style = "equal", legend.size.show = FALSE, title.col = "%CONS11") +
  tm_layout(legend.text.size = 0.2, legend.title.size = 0.4, legend.position = c("left", "bottom"), frame = FALSE) 

map3<-tm_shape(ge) + tm_fill("AKP15", n = 4, palette = "Reds", style = "equal", title = "%AKP15") + 
  tm_borders(alpha=.8) + tm_borders(alpha=.4)+
  tm_shape(ge) + tm_bubbles(size = "CONS15", col = "CONS15", n = 4, palette = "Blues", style = "equal", legend.size.show = FALSE, title.col = "%CONS15") +
  tm_layout(legend.text.size = 0.2, legend.title.size = 0.4, legend.position = c("left", "bottom"), frame = FALSE) 

map4<-tm_shape(ge) + tm_fill("AKP16", n = 4, palette = "Reds", style = "equal", title = "%AKP16") + 
  tm_borders(alpha=.8) + tm_borders(alpha=.4)+
  tm_shape(ge) + tm_bubbles(size = "CONS16", col = "CONS16", n = 4, palette = "Blues", style = "equal", legend.size.show = TRUE, title.col = "%CONS16") +
  tm_layout(legend.text.size = 0.2, legend.title.size = 0.4, legend.position = c("left", "bottom"), frame = FALSE) 


tmap_arrange(map1, map2, map3, map4)
tmap_mode("view")
tmap_last()

map2<-tm_shape(ge) + tm_fill("AKP16", n = 5, palette = "Reds", style = "equal", title = "%AKP16") + 
  tm_borders(alpha=.8) +  tm_borders(alpha=1.5) + tm_shape(ge) + tm_bubbles(size = "KURD16", col = "KURD16", n = 5, palette = "Purples", style = "equal", legend.size.show = FALSE, title.col = "%KURD16") +
  tm_layout(legend.text.size = 0.5, legend.title.size = 1, legend.position = c("left", "bottom"), frame = TRUE) 

tmap_arrange(map1, map2)


m1 <- tm_shape(ge)+ 
  tm_polygons("reds") +
  tm_facets(along = "name")

tmap_animation(m1, filename="Dutch_provinces.gif", width=800, delay=40)

# tmap_mode("view")
# install.packages("gmap")

tm_basemap() + tm_shape(OA.Census) + tm_fill("AKP16", n = 4, border.col = "black", border.lwd = 0.1, border.alpha = 0.2, palette = "Reds", style = "equal", title = "%AKP16") 
+ tm_layout(legend.text.size = 0.5, legend.title.size = 1, legend.position = c("right", "center"), frame = TRUE)
+ tm_borders(alpha=.8) + tm_borders(alpha=.4)

# tm_shape(OA.Census) + tm_dots(title = "House Prices (?)", border.col = "black", border.lwd = 0.1, border.alpha = 0.2, col = "Price", style = "quantile", palette = "Reds")
# 
#   #tm_shape(OA.Census) + tm_bubbles(size = "CONS16", col = "CONS16", n = 4, palette = "Blues", style = "equal", legend.size.show = FALSE, title.col = "%CONS16") +
#   #tm_layout(legend.text.size = 0.5, legend.title.size = 1, legend.position = c("right", "center"), frame = FALSE)
# 
# map2<-tm_shape(OA.Census) + tm_fill("AKP16", n = 4, palette = "Reds", style = "equal", title = "%AKP16") +
#   tm_borders(alpha=.8) +  tm_borders(alpha=1.5) + tm_shape(OA.Census) + tm_bubbles(size = "KURD16", col = "KURD16", n = 4, palette = "Purples", style = "equal", legend.size.show = FALSE, title.col = "%KURD16") +
#   tm_layout(legend.text.size = 0.5, legend.title.size = 1, legend.position = c("right", "center"), frame = FALSE)
# 
# 
# 
# install.packages("raster")
# install.packages("dismo")
# library(raster)
# library(dismo)
# google.map <- gmap("Turkey", type = "satellite")
# install.packages("rgdal")
# install.packages("XML")
# library(rgdal)
# library(XML)
# install.packages("sp")
# library(ggmap)
tmap_animation
m1 <- tm_shape(ge) + tm_fill("AKP07", n = 4, palette = "Reds", style = "equal", title = "%AKP07") + 
  tm_borders(alpha=1) +
  tm_bubbles(size = "CONS07", col = "CONS07", n = 4, palette = "Blues", style = "equal", legend.size.show = TRUE, title.col = "%CONS07") +
  tm_layout(legend.bg.color="lightblue", legend.bg.alpha=.5, legend.frame=TRUE, legend.text.size = 0.2, legend.title.size = 0.4)+
  tm_polygons("yellow") 

m1
ttm()
tmap_animation(m1, filename="AKP07.gif", width=800, delay=40)
install.packages('installr')
library(installr)
install.ImageMagick()

m1 <- tm_shape(ge) + tm_fill("AKP16", n = 5, palette = "Reds", style = "equal", title = "%AKP16") + 
  tm_borders(alpha=.4) +  tm_borders(alpha=1.5) + 
  tm_shape(ge) + tm_bubbles(size = "CONS16", col = "CONS16", palette = "Blues", style = "equal", legend.size.show = FALSE, title.col = "%CONS16") +
  tm_layout(legend.outside=TRUE, legend.text.size = 0.5, legend.title.size = 1, legend.outside.position = c("right","bottom"), frame = TRUE) +
  tm_facets(free.scales.symbol.size = FALSE, nrow=1,ncol=1)
m1
tmap_animation(m1, filename="AKP16.gif", width=800, delay=40)


tm_shape(ge) + tm_fill("AKP16", n = 5, palette = "Reds", style = "equal", title = "%AKP16") + 
  tm_borders(alpha=.4) +  tm_borders(alpha=1.5) + 
  tm_shape(ge) + tm_bubbles(size = "KURD16", col = "KURD16", palette = "Blues", style = "equal", legend.size.show = FALSE, title.col = "%KURD16") +
  tm_layout(legend.outside=TRUE, legend.text.size = 0.5, legend.title.size = 1, legend.outside.position = c("right","bottom"), frame = TRUE) +
  tm_facets(free.scales.symbol.size = FALSE, nrow=1,ncol=1)

