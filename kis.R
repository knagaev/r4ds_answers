kis2017 <- read_delim("C:\\_in\\дозагрузки\\Комплексное ипотечное страхование (026)\\adacta1\\2017\\trace_20170215.log", 
                      delim = "|",
                      col_names = FALSE,
                      trim_ws = TRUE,
                      locale = readr::locale(encoding = "CP1251")
                      )

kis2017 <- kis2017[complete.cases(kis2017), ]

test <-kis2017$X3[2]
test
str_match(test, ".+Z:\\\\дозагрузки\\\\Комплексное ипотечное страхование \\(026\\)\\\\(.+)\\\\esb_ibsi\\\\(.+xml).+ ---> .+?: (.+)") 

yfe <- function(test)
{
  str_match(test, ".+Z:\\\\дозагрузки\\\\Комплексное ипотечное страхование \\(026\\)\\\\(.+)\\\\esb_ibsi\\\\(.+xml).+ ---> .+?: (.+)") 
}

#y <- yfe(test)[[2]]

parsed_kis <- kis2017 %>% 
                transmute(
                       date_log = str_sub(X1, start = 7),
                       year = yfe(X3)[, 2],
                       file_name = yfe(X3)[, 3],
                       err_message = yfe(X3)[, 4]
                       )
for (yr in c("2016", "2015", "2014", "2013", "2012", "2011", "2008"))
{
lf <- list.files(paste0("C:\\_in\\дозагрузки\\Комплексное ипотечное страхование (026)"), 
                 pattern = "trace",
                 full.names = TRUE,
                 recursive = TRUE)

kis <- map(lf, function(x){
                    log_cnts <- read_delim(x, 
                      delim = "|",
                      col_names = FALSE,
                      trim_ws = TRUE,
                      locale = readr::locale(encoding = "CP1251")) %>% 
#                      .[complete.cases(.), ] %>% 
                      filter(X2 == "EventLevel: Debug" & !str_detect(X3, "Early")) %>% 
                      transmute(
                        date_log = str_sub(X1, start = 7),
                        year = yfe(X3)[, 2],
                        file_name = yfe(X3)[, 3],
                        err_message = yfe(X3)[, 4],
                        path = x
#                        ,src_message = yfe(X3)[, 1]
                      )
                    })

# объединение наборов и удаление дубликатов (остаётся наиболее поздняя запись)
kis_all <- kis %>% reduce(full_join) %>% group_by(file_name) %>% filter(date_log == max(date_log))

write_csv(kis_all, paste0("C:\\_in\\дозагрузки\\Комплексное ипотечное страхование (026)\\all.csv")) 

kis_stat <- kis_all %>% 
                    group_by(err_message) %>% 
                    count() %>% 
                    arrange(desc(n))

write_csv(kis_stat, paste0("C:\\_in\\дозагрузки\\Комплексное ипотечное страхование (026)\\all_stat_.csv")) 
}

