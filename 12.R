es_MX <- locale("es", grouping_mark = ".")
parse_number("$1.123.456,00", locale = es_MX)

t <- default_locale()

d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014
t1 <- "1705"
t2 <- "11:15:10.12 PM"

parse_date(d1, "%B %d, %y")


stocks %>% 
  spread(year, return, convert = TRUE) %>% 
  gather("year", "return", `2015`:`2016`, convert = TRUE) 

## 12.3.3 Exercises
### 1.Why are gather() and spread() not perfectly symmetrical?
### Carefully consider the following example:
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  spread(year, return) %>% 
  gather("year", "return", `2015`:`2016`)
###
stocks %>% 
  spread(year, return, convert = TRUE) %>% 
  gather("year", "return", `2015`:`2016`, convert = TRUE)

### 2.Why does this code fail?
table4a %>% 
  gather(1999, 2000, key = "year", value = "cases")
#> Error in combine_vars(vars, ind_list): Position must be between 0 and n
###
table4a %>% 
  gather(`1999`:`2000`, key = "year", value = "cases")

table4a %>% 
  gather(2, 3, key = "year", value = "cases")

### 3.Why does spreading this tibble fail? How could you add a new column to fix the problem?

people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
###
people <- tribble(
  ~id, ~name,             ~key,    ~value,
  #-|---------------|--------|------
  1, "Phillip Woods",   "age",       45,
  2, "Phillip Woods",   "height",   186,
  2, "Phillip Woods",   "age",       50,
  3, "Jessica Cordero", "age",       37,
  3, "Jessica Cordero", "height",   156
 )
people %>% spread(key = key, value = value)

### 4.Tidy the simple tibble below. Do you need to spread or gather it? What are the variables?
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
###
preg %>% gather(2:3, key = "sex", value = "qty")


## 12.4.3 Exercises

### 1.What do the extra and fill arguments do in separate()? Experiment with the various options for the following two toy datasets.

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three")
           #, extra = "merge"
           , remove = FALSE
           )

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"), fill = "left")



