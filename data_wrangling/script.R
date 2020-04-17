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

application_decision_month$year[application_decision_month$month == "November"] <- "2019"
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

# Load secon sheet
channels_application_rec <- read_xlsx("raw_data/Young+Carer+Grant+-+Tables+-+April+2020.xlsx",sheet = 3,skip = 4)

#Cleaning data

channels_application_rec <- channels_application_rec %>% rename(channel = ...1, october = October1) %>% 
  filter(channel !="Total") %>% 
  select(channel, october,November,December,January,February, ...7) %>%
  clean_names() %>% 
  filter(channel %in% c("Online","Paper","Phone")) %>% 
  select(-x7)

## Writing CSV
write_csv(channels_application_rec,"clean_data/channels_application_rec.csv")

