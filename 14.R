library(stringr)

#14.2.5 Exercises

# 1. In code that doesn’t use stringr, you’ll often see paste() and paste0(). What’s the difference between the two functions? What stringr function are they equivalent to? How do the functions differ in their handling of NA?
(nth <- paste0(1:12, c("st", "nd", "rd", rep("th", 9))))

paste0(month.abb, "is the", nth, "month of the year.")
paste(month.abb, "is the", nth, "month of the year.")

str_c(month.abb, "is the", nth, "month of the year.", sep = " ")
str_c(month.abb, "is the", nth, "month of the year.", sep = " ", collapse = "")

# 3. Use str_length() and str_sub() to extract the middle character from a string. What will you do if the string has an even number of characters?

S <- "month"
str_sub(S, str_length(S) / 2 + 1, str_length(S) / 2 + 1)

S <- "year"
str_sub(S, str_length(S) / 2 + 1, str_length(S) / 2 + 1)

# 4. What does str_wrap() do? When might you want to use it?
thanks_path <- file.path(R.home("doc"), "THANKS")
thanks <- str_c(readLines(thanks_path), collapse = "\n")
thanks <- word(thanks, 1, 3, fixed("\n\n"))
cat(str_wrap(thanks), "\n")
cat(str_wrap(thanks, width = 40), "\n")
cat(str_wrap(thanks, width = 60, indent = 2), "\n")
cat(str_wrap(thanks, width = 60, exdent = 2), "\n")
cat(str_wrap(thanks, width = 0, exdent = 2), "\n")
