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

dmy(d3)
mdy(d4)
mdy(d5)

# не работает
# l <- locale("en")
# guess_formats(d1, "BdY", locale = l)

Sys.setlocale("LC_TIME", "English")
x <- ymd(d2)
cx <- as.character(x, format="%B %d %Y")
guess_formats(cx, "BdY", print_matches = FALSE)
cx


# 16.3.4 Exercises

# 1. How does the distribution of flight times within a day change over the
# course of the year?

# 2. Compare dep_time, sched_dep_time and dep_delay. Are they consistent?
# Explain your findings.
make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
    sched_arr_time = make_datetime_100(year, month, day, sched_arr_time),
    overnight = arr_time < dep_time,
    arr_time = arr_time + days(overnight * 1),
    sched_arr_time = sched_arr_time + days(overnight * 1))

flights_dt %>% 
  mutate(calc_dep_delay = sched_dep_time - dep_time,
         conv_dep_delay = -60 * dep_delay) %>%
  filter(calc_dep_delay != conv_dep_delay) %>% 
  mutate(aligned_delay = calc_dep_delay - conv_dep_delay)


# 3. Compare air_time with the duration between the departure and arrival.
# Explain your findings. (Hint: consider the location of the airport.)

# 4. How does the average delay time change over the course of a day? Should you
# use dep_time or sched_dep_time? Why?

# 5. On what day of the week should you leave if you want to minimise the chance
# of a delay?
flights_dt %>%
  mutate(wd = wday(dep_time),
         is_delayed = dep_delay > 0
         ) %>% 
  group_by(wd) %>% 
  summarise(delayed_prop = sum(is_delayed == TRUE) / n()) %>% 
  filter(delayed_prop == min(delayed_prop))


# 6. What makes the distribution of diamonds$carat and flights$sched_dep_time
# similar?
diamonds %>% 
ggplot(aes(carat)) +
  geom_freqpoly(bins = 100)

flights %>% 
  ggplot(aes(sched_dep_time)) +
  geom_freqpoly(bins = 100)

# 7. Confirm my hypothesis that the early departures of flights in minutes 20-30
# and 50-60 are caused by scheduled flights that leave early. Hint: create a
# binary variable that tells you whether or not a flight was delayed.



# 16.4.5 Exercises

# 1. Why is there months() but no dmonths()?

# 2. Explain days(overnight * 1) to someone who has just started learning R. How does it work?

# 3. Create a vector of dates giving the first day of every month in 2015.
# Create a vector of dates giving the first day of every month in the current
# year.
fm2015 <- 1:12 %>% 
  make_date(2015, .)

fm_this_year <- 1:12 %>% 
  make_date(year(today()), .)


# 4. Write a function that given your birthday (as a date), returns how old you are in years.
how_old <- function(x)
{
  ddays(today() - x)
}


# 5. Why can’t (today() %--% (today() + years(1)) / months(1) work?
