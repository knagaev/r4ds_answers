library(forcats)

# 15.3.1 Exercise

# 1. Explore the distribution of rincome (reported income). What makes the default bar chart hard to understand? How could you improve the plot?

gss_cat %>% 
  group_by(rincome) %>% 
  summarise(n = n()) %>% 
  mutate(rincome = fct_reorder(rincome, n)) %>%
  ggplot(aes(rincome, n)) +
  coord_flip() +
  geom_bar(stat = "identity")
