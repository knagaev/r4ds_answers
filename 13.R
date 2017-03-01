
### 1.Compute the average delay by destination, then join on the airports data frame so you can show the spatial distribution of delays. Here’s an easy way to draw a map of the United States:
  
  airports %>%
  semi_join(flights %>%
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()
#(Don’t worry if you don’t understand what semi_join() does — you’ll learn about it next.)
#You might want to use the size or colour of the points to display the average delay for each airport.

###

delays <- 
airports %>%
  inner_join(flights %>% 
               group_by(dest) %>% 
               summarise("mean_arr_delay" = -mean(arr_delay)), c( "faa" = "dest"))

delays %>%
  ggplot(aes(lon, lat, size = mean_arr_delay)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

### 2.Add the location of the origin and destination (i.e. the lat and lon) to flights.
flights %>%
  inner_join(airports, c("dest" = "faa")) %>% 
  rename(dest_lat = lat, dest_lon = lon) %>% 
  inner_join(airports, c("origin" = "faa")) %>% 
  rename(origin_lat = lat, origin_lon = lon)

               

