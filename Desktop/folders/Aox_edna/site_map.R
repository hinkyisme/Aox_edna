sites <- read.csv(file = "sites.csv", sep = ",", header = TRUE)
xy.dat <- sites[c("Longitude", "Latitude")]
sites <- SpatialPointsDataFrame(coords = xy.dat, sites)
# get sites
require(ggmap)
require(gstudio)
map <- ggmap(population_map(sites, map.type = "roadmap", zoom = 12), stratum = Site) + geom_point(aes())
#####
# for map of river depth and then volume, in gis go into 3d analyst, and functional surface, l
# look up "surface volume"
# however, Geoff's extent does not cover my extent
# look up data from website and interpolate?
#####
# use either IDW or natural neighbor in interpolation in spatial tools for interpolation
# of two rasters (input is NOSS data)