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


# 15.4.1 Exercises

# 1. There are some suspiciously high numbers in tvhours. Is the mean a good summary?

# 2. For each factor in gss_cat identify whether the order of the levels is arbitrary or principled.

gss_cat %>%
  select_if (is.factor) %>% 
  sapply(levels)

# 3. Why did moving “Not applicable” to the front of the levels move it to the bottom of the plot?
rincome <- gss_cat %>%
  group_by(rincome) %>%
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

ggplot(rincome, aes(age, fct_reorder(rincome, age))) + geom_point()
rincome %>% select(rincome, age) %>% arrange(age)

ggplot(rincome, aes(age, fct_relevel(rincome, "Not applicable"))) + geom_point()
fct_relevel(rincome$rincome, "Not applicable")


# 15.5.1 Exercises

# 1. How have the proportions of people identifying as Democrat, Republican, and Independent changed over time?
gss_cat$partyid2 <- fct_collapse(gss_cat$partyid,
                         NULL = c("No answer", "Don't know", "Other party"),
                         rep = c("Strong republican", "Not str republican"),
                         ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                         dem = c("Not str democrat", "Strong democrat")
)

party_count <- gss_cat %>% 
                filter(partyid2 %in% c("rep", "ind", "dem")) %>% 
                group_by(partyid2, year) %>% 
                count()

ggplot(party_count, aes(year, n, colour = partyid2)) +
  geom_point() +
  geom_line() + 
  labs(colour = "Партия")

# вариант с mutate
ggplot(
  gss_cat %>%
    mutate(partyid = fct_collapse(partyid,
                                  other = c("No answer", "Don't know", "Other party"),
                                  rep = c("Strong republican", "Not str republican"),
                                  ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                  dem = c("Not str democrat", "Strong democrat"))) %>%
    count(partyid, year),
  aes(year, n, colour = partyid)) +
geom_point() +
geom_line() + 
labs(colour = "Партия")

# 2. How could you collapse rincome into a small set of categories?
levels(gss_cat$rincome)
# fct_collapse или fct_relabel?
