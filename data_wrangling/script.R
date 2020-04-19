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
  select(-x7)%>% mutate(channel = str_to_lower(channel))

## Writing CSV
write_csv(channels_application_rec,"clean_data/channels_application_rec.csv")

# Load third sheet

age_group <- read_xlsx("raw_data/Young+Carer+Grant+-+Tables+-+April+2020.xlsx",sheet = 4,skip = 3)

#Cleaning data

age_group <- age_group %>% 
  filter(...1!="Total") %>%
  rename(age_group = ...1) %>% 
  clean_names() %>%
  filter(!is.na(total_applications_received)) %>% 
  mutate(age_group=replace(age_group,which(age_group=="Other2"),"other")) %>% 
  select(-percent_of_total_applications_received,-percent_authorised,-percent_denied,-percent_withdrawn)

# Writing CSV

write_csv(age_group,"clean_data/age_group.csv")

# Load fourth sheet

by_location <- read_xlsx("raw_data/Young+Carer+Grant+-+Tables+-+April+2020.xlsx",sheet = 5,skip = 3)

#Cleaning data

by_location <- by_location %>% rename(location = ...1) %>% 
  clean_names() %>% 
  filter(location != "Total") %>% 
  select(-starts_with("percent")) %>% 
  filter(!is.na(total_applications_received),location!="No address4") %>% 
  mutate(location = str_remove(location,"[0-9]")) %>% 
  filter(location != "Unknown - Scottish address")


location <- by_location %>% select(location)
stats <- by_location %>% select(-location) %>% mutate_all(as.numeric)
by_location <- cbind(location,stats)

# Writing CSV

write_csv(by_location,"clean_data/by_location.csv")

# Load fith sheet
cared_for_person <- read_xlsx("raw_data/Young+Carer+Grant+-+Tables+-+April+2020.xlsx",sheet = 6,skip = 3)

#Cleaning data

cared_for_person <- cared_for_person %>% rename(cared_for_person = ...1) %>% 
  clean_names() %>% 
  filter(!cared_for_person %in% c("Total","Unknown2")) %>% 
  select(-starts_with("percent")) %>% 
  filter(!is.na(total_applications_received)) 

info <- cared_for_person %>% select(cared_for_person)
stats <- cared_for_person %>% select(-cared_for_person) %>% mutate_all(as.numeric)
cared_for_person <- cbind(info,stats)

# Writing CSV

write_csv(cared_for_person,"clean_data/cared_for_person.csv")

# Load sixth sheet

value_of_payments <- read_xlsx("raw_data/Young+Carer+Grant+-+Tables+-+April+2020.xlsx",sheet = 8,skip = 2)

#Cleaning data

value_of_payments <- value_of_payments %>% 
  clean_names() %>% 
  rename(value_of_payments = value_of_payments1_2_3) %>% 
  select(-percent_of_total_payments) %>% 
  filter(!is.na(local_authority), local_authority != "Total",!is.na(value_of_payments)) %>% 
  filter(local_authority != "No address6") %>% mutate(local_authority = str_remove(local_authority, "[0-9]")) %>% 
  mutate(value_of_payments = as.numeric(value_of_payments))


# Writing CSV

write_csv(value_of_payments, "clean_data/value_of_payments.csv")



# Lad the csv file from http://geoportal.statistics.gov.uk/

geo_local_authority <- 
  read_csv("raw_data/Local_Authority_Districts_December_2017_Super_Generalised_Clipped_Boundaries_in_Great_Britain.csv")

#  extracting geo of scotish local authorities

geo_local_authority <- geo_local_authority %>% select(lad17nm,long,lat) %>%
  rename(location = lad17nm) %>% 
  filter(lat > 55) %>% arrange(lat) %>% filter(!location  %in% c("Northumberland",
                                                                 "North Tyneside",
                                                                 "Newcastle upon Tyne"))
# Save CSV 

write_csv(geo_local_authority, "clean_data/geo_local_authority.csv")


