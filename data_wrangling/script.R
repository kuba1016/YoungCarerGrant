library(tidyverse)
library(readxl)
library(janitor)


#Load first sheet 

application_decision_month <- read_xlsx("raw_data/Young+Carer+Grant+-+Tables+-+April+2020.xlsx",sheet = 2,skip = 3)

# Cleaning NA and columns

application_decision_month<- application_decision_month %>% 
  rename(year = ...1, month = ...2) %>% 
  filter(!is.na(`Total applications received`)) %>% 
  filter(!is.na(month)) %>% clean_names()

#Fixing the missing values

pplication_decision_month$year[application_decision_month$month == "November"] <- "2019"
application_decision_month$year[application_decision_month$month == "December"] <- "2019"
application_decision_month$year[application_decision_month$month == "February"] <- "2020"
application_decision_month$month[application_decision_month$month == "October2"] <- "October"

# Changing the column types 
dates <- application_decision_month %>% select(year,month)
stats <- application_decision_month %>% select( -year,-month) %>% mutate_all(as.numeric)
df <- cbind(dates,stats)
class(df)

# Writing CSV

write_csv(df,"clean_data/application_decision_month.csv")
