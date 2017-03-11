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

# 2. What is the most common relig in this survey? What’s the most common partyid?
gss_cat %>% 
  group_by(relig) %>% 
  summarise(n = n()) %>% 
  top_n(n = 1, wt = n)

gss_cat %>% 
  group_by(partyid) %>% 
  summarise(n = n()) %>% 
  top_n(n = 1, wt = n)

# 3. Which relig does denom (denomination) apply to? How can you find out with a table? How can you find out with a visualisation?

gss_cat %>% 
  group_by(relig, denom) %>% 
  summarise(n = n())
  
gss_cat %>% 
  group_by(relig) %>% 
  distinct(denom) %>% 
  arrange(relig, denom) %>% 
  ggplot(aes(relig)) +
    geom_bar()

