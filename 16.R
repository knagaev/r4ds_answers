library(lubridate)

# 16.2.4 Exercises

# 1. What happens if you parse a string that contains invalid dates?

ymd(c("2010-10-10", "bananas"))

# 2. What does the tzone argument to today() do? Why is it important?

today()
#[1] "2017-03-14"

today("Asia/Vladivostok")
#[1] "2017-03-15"

# 3. Use the appropriate lubridate function to parse each of the following dates:
  
d1 <- "February 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014

parse_date_time(d1, "%B %d, %Y")
ymd(d2)
dmy(d3)
mdy(d4)
mdy(d5)
