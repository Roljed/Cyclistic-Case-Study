## ----setup, include=FALSE-------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = '/Users/ynahshon/Developer/Projects/Case_study_1-Bike_Share/12_months/csv/')


## ----library setup, message=FALSE-----------------------------------------------------------------------------------------
library(tidyverse)
library(lubridate)
library(ggplot2)
library(gridExtra)
library(scales)


## ----reading csv files, message=FALSE, results='hide'---------------------------------------------------------------------
  
f1_2020_11 <- read_csv("202011-divvy-tripdata.csv")
f2_2020_12 <- read_csv("202012-divvy-tripdata.csv")
f3_2021_01 <- read_csv("202101-divvy-tripdata.csv")
f4_2021_02 <- read_csv("202102-divvy-tripdata.csv")
f5_2021_03 <- read_csv("202103-divvy-tripdata.csv")
f6_2021_04 <- read_csv("202104-divvy-tripdata.csv")
f7_2021_05 <- read_csv("202105-divvy-tripdata.csv")
f8_2021_06 <- read_csv("202106-divvy-tripdata.csv")
f9_2021_07 <- read_csv("202107-divvy-tripdata.csv")
f10_2021_08 <- read_csv("202108-divvy-tripdata.csv")
f11_2021_09 <- read_csv("202109-divvy-tripdata.csv")
f12_2021_10 <- read_csv("202110-divvy-tripdata.csv")


## ----column names review, message=FALSE, results='hide'-------------------------------------------------------------------
dim(f1_2020_11)

colnames(f1_2020_11)
glimpse(f1_2020_11)
colnames(f2_2020_12)
glimpse(f2_2020_12)
colnames(f3_2021_01)
glimpse(f3_2021_01)
colnames(f4_2021_02)
glimpse(f4_2021_02)
colnames(f5_2021_03)
glimpse(f5_2021_03)
colnames(f6_2021_04)
glimpse(f6_2021_04)
colnames(f7_2021_05)
glimpse(f7_2021_05)
colnames(f8_2021_06)
glimpse(f8_2021_06)
colnames(f9_2021_07)
glimpse(f9_2021_07)
colnames(f10_2021_08)
glimpse(f10_2021_08)
colnames(f11_2021_09)
glimpse(f11_2021_09)
colnames(f12_2021_10)
glimpse(f12_2021_10)

str(f1_2020_11)
str(f2_2020_12)
str(f3_2021_01)
str(f4_2021_02)
str(f5_2021_03)
str(f6_2021_04)
str(f7_2021_05)
str(f8_2021_06)
str(f9_2021_07)
str(f10_2021_08)
str(f11_2021_09)
str(f12_2021_10)


## ----fix column names-----------------------------------------------------------------------------------------------------
f1_2020_11 <- mutate(f1_2020_11, start_station_id = as.character(start_station_id),
                  end_station_id = as.character(end_station_id)) 


## ----stacking dataframes, message=FALSE-----------------------------------------------------------------------------------
all_trips <- bind_rows(f1_2020_11, f2_2020_12, f3_2021_01, f4_2021_02, f5_2021_03, f6_2021_04, f7_2021_05, f8_2021_06, f9_2021_07, f10_2021_08, f11_2021_09, f12_2021_10)


## -------------------------------------------------------------------------------------------------------------------------
colnames(all_trips)
dim(all_trips)
head(all_trips)
str(all_trips)
summary(all_trips)


## ----inspec nan values----------------------------------------------------------------------------------------------------
colSums(is.na(all_trips))


## ----clean-up column removal----------------------------------------------------------------------------------------------
all_trips_v2 <- all_trips %>%
  select(-c(start_lat, start_lng, end_lat, end_lng))


## ----adding date columns--------------------------------------------------------------------------------------------------
all_trips_v2$date <- as.Date(all_trips_v2$started_at) #The default format is yyyy-mm-dd
all_trips_v2$month <- format(as.Date(all_trips_v2$date), "%m")
all_trips_v2$day <- format(as.Date(all_trips_v2$date), "%d")
all_trips_v2$year <- format(as.Date(all_trips_v2$date), "%Y")
all_trips_v2$day_of_week <- format(as.Date(all_trips_v2$date), "%A")
all_trips_v2$hour <- format(as.POSIXct(all_trips_v2$started_at), format = "%H")

all_trips_v2$day_of_week <- 
  ordered(all_trips_v2$day_of_week, levels=c("Sunday", "Monday", "Tuesday",
                                             "Wednesday", "Thursday", 
                                             "Friday", "Saturday"))


## ----ride_length calculation----------------------------------------------------------------------------------------------
all_trips_v2$ride_length <- difftime(all_trips_v2$ended_at,all_trips_v2$started_at)

# Inspect the structure of the columns
str(all_trips_v2)


## ----casting, results='hide'----------------------------------------------------------------------------------------------
is.factor(all_trips_v2$ride_length)
all_trips_v2$ride_length <- as.numeric(as.character(all_trips_v2$ride_length))
is.numeric(all_trips_v2$ride_length)


## -------------------------------------------------------------------------------------------------------------------------
colSums(is.na(all_trips_v2))


## ----station names inspection, message=FALSE------------------------------------------------------------------------------
unique_station_names = sort(intersect(unique(all_trips_v2$start_station_name), unique(all_trips_v2$end_station_name)))


## ----remove bad data------------------------------------------------------------------------------------------------------
distinct(all_trips_v2) # no duplicates

# Remove ride_length <= 60 or ride_length > 60*60*24
rides_to_be_removed <- subset(all_trips_v2, ride_length <= 60 | ride_length > 60*60*24)
all_trips_fixed_rides_length <- subset(all_trips_v2, ride_length > 60 & ride_length <= 60*60*24)


## ----drop bad station names, message=FALSE--------------------------------------------------------------------------------
# Remove test (26), repair (8) and check (26) start and end stations

all_trips_v3 <- all_trips_fixed_rides_length[!grepl("TEST", all_trips_fixed_rides_length$start_station_name) & !grepl("TEST", all_trips_fixed_rides_length$end_station_name),]

all_trips_v3 <- all_trips_fixed_rides_length[!grepl("REPAIR", all_trips_fixed_rides_length$start_station_name) & !grepl("REPAIR", all_trips_fixed_rides_length$end_station_name),]

all_trips_v3 <- all_trips_fixed_rides_length[!grepl("CHECKING", all_trips_fixed_rides_length$start_station_name) & !grepl("CHECKING", all_trips_fixed_rides_length$end_station_name),]



## ----drop NA rows ,message=FALSE------------------------------------------------------------------------------------------
colSums(is.na(all_trips_v3))
all_trips_v4 <- drop_na(all_trips_v3)
colSums(is.na(all_trips_v4))


## ----renaming of columns--------------------------------------------------------------------------------------------------
(all_trips_v4 <- rename(all_trips_v4,
                  user_type = member_casual))


## ----summary--------------------------------------------------------------------------------------------------------------
summary(all_trips_v4)

# Get the first starting date and the last date
mindate <- min(all_trips_v4$started_at)
maxdate <- max(all_trips_v4$started_at)



## ----user type statistic--------------------------------------------------------------------------------------------------
ride_length_stats <- all_trips_v4 %>%
  group_by(user_type) %>%
  summarize(min_ride_time = min(ride_length, na.rm = TRUE),
            max_ride_time = max(ride_length, na.rm = TRUE),
            average_ride_time = mean(ride_length, na.rm = TRUE),
            median_ride_time = median(ride_length, na.rm = TRUE))

avg_user_ride_time <- ggplot(ride_length_stats, mapping = aes(x = user_type, y = average_ride_time / 60, fill = user_type)) +
  geom_col(show.legend = FALSE) +
  labs(title = "User Ride Time",
       subtitle = 'Average time in minutes',
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x = "User",
       y = "Time")

median_user_ride_time <- ggplot(ride_length_stats, mapping = aes(x = user_type, y = median_ride_time / 60, fill = user_type)) +
  geom_col(show.legend = FALSE) +
  labs(title = "User Ride Time",
       subtitle = 'Median time in minutes',
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x = "User",
       y = "Time")



grid.arrange(avg_user_ride_time, median_user_ride_time, ncol=2)


## ----weekday calculation--------------------------------------------------------------------------------------------------
weekdays_rides <- all_trips_v4 %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(user_type, weekday) %>% 
  summarise(number_of_rides = n() ,average_duration = mean(ride_length)) %>%
  arrange(user_type,weekday)


## ----weekday total rides--------------------------------------------------------------------------------------------------
ggplot(weekdays_rides, aes(x = weekday, y = number_of_rides, fill = user_type)) + 
  geom_col(show.legend = FALSE, position = "dodge") +
  facet_wrap(~user_type) +
  labs(title="Number of rides by rider type",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Weekdays",
       y="Number of Rides") +
  scale_y_continuous(labels = comma)


## ----weekday average ride-------------------------------------------------------------------------------------------------
ggplot(weekdays_rides, aes(x = weekday, y = average_duration / 60, fill = user_type)) + 
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title="Average duration",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Weekdays",
       y="Number of Rides")


## ----month trips, message=FALSE-------------------------------------------------------------------------------------------
monthly_trips <- all_trips_v4 %>%
  group_by(user_type, month) %>% 
  summarise(number_of_rides = n() ,average_duration = mean(ride_length)) %>%
  arrange(month)


## -------------------------------------------------------------------------------------------------------------------------
ggplot(monthly_trips, aes(x = month, y = number_of_rides, fill= user_type)) +
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title = "Monthly trips, Member vs Casual",
       caption = paste0("Data Source by Motivate Internatiol INC."),
       x="Months",
       y="Number of Rides") + 
  theme(axis.text.x = element_text(angle = 50,hjust = 1)) +
  scale_y_continuous(labels = comma)


## -------------------------------------------------------------------------------------------------------------------------
ggplot(monthly_trips, aes(x = month, y = average_duration, fill= user_type)) +
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title = "Monthly trips, Member vs Casual",
       caption = "Data Source by Motivate Internatiol INC.",
       x="Months",
       y="Average duration") + 
  theme(axis.text.x = element_text(angle = 50,hjust = 1)) + 
  scale_y_continuous(labels = comma) 


## ----message=FALSE--------------------------------------------------------------------------------------------------------
daytime_hours <- all_trips_v4 %>%
  group_by(user_type, hour) %>%
  summarize(number_of_rides = n(), average_duration = mean(ride_length))


## -------------------------------------------------------------------------------------------------------------------------
ggplot(daytime_hours, aes(x = hour, y = number_of_rides, fill = user_type)) + 
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title="Daytime hour preference",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Hour",
       y="Number of Rides") +
  coord_flip() +
  scale_y_continuous(labels = comma)


## -------------------------------------------------------------------------------------------------------------------------
ggplot(daytime_hours, aes(x = hour, y = average_duration / 60, fill = user_type)) + 
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title="Daytime hour preference",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Hour",
       y="Average Duration") +
  coord_flip() +
  scale_y_continuous(labels = comma)


## ----prefered bike type---------------------------------------------------------------------------------------------------
bike_type <- all_trips_v4 %>%
  group_by(user_type, rideable_type) %>% 
  summarise(number_of_rides = n() ,average_duration = mean(ride_length))


## -------------------------------------------------------------------------------------------------------------------------
ggplot(bike_type, aes(x = rideable_type, y = number_of_rides, fill = user_type)) + 
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title="Bike type preference",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Bike type",
       y="Number of Rides") +
  scale_y_continuous(labels = comma)


## ----bike type preference-------------------------------------------------------------------------------------------------
ggplot(bike_type, aes(x = rideable_type, y = average_duration / 60, fill = user_type)) + 
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title="Bike type preference",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Bike type",
       y="Average Duration")


## ----popular stations start, message=FALSE--------------------------------------------------------------------------------
popular_start_stations <- all_trips_v4 %>% 
  group_by(user_type, start_station_name) %>% 
  summarize (number_of_rides = n()) %>% 
  arrange(-number_of_rides)

ggplot(popular_start_stations[1:10,], aes(x = start_station_name, y = number_of_rides, fill= user_type)) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title = "Popular Start Stations",
       caption = "Data Source by Motivate Internatiol INC.",
       x="Stations",
       y="Number of Rides") +
  scale_y_continuous(labels = comma) +
  theme(axis.text.x = element_text(angle = 50,hjust = 1))



## ----popular stations end, message=FALSE----------------------------------------------------------------------------------
popular_end_stations <- all_trips_v4 %>% 
  group_by(user_type, end_station_name) %>% 
  summarize (number_of_rides = n()) %>% 
  arrange(-number_of_rides)

ggplot(popular_end_stations[1:10,], aes(x = end_station_name, y = number_of_rides, fill= user_type)) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title = "Popular End Stations",
       caption = "Data Source by Motivate Internatiol INC.",
       x="Stations",
       y="Number of Rides") +
  scale_y_continuous(labels = comma) +
  theme(axis.text.x = element_text(angle = 50,hjust = 1))



## ----top popular stations, message=FALSE----------------------------------------------------------------------------------
top_popular_station <- all_trips_v4 %>%
  group_by(start_station_name, user_type) %>%
  summarise(number_of_rides = n()) %>%
  arrange(-number_of_rides)

ggplot(top_popular_station[1:20,], aes(x = start_station_name, y = number_of_rides, fill = user_type)) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title = "Top Popular Stations",
       caption = "Data Source by Motivate Internatiol INC.",
       x="Stations",
       y="Number of Rides") +
  scale_y_continuous(labels = comma) +
  theme(axis.text.x = element_text(angle = 50,hjust = 1))


