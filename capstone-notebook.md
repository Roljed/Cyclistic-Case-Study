capstone-notebook
================
Yaad Nahshon
11/15/2021

# The Study

## Step 1 - Ask

**Key tasks**

1.  Identify the business task

2.  Consider key stakeholders

**The business task**

How do annual members and casual riders use Cyclistic bikes differently?

**Key stakeholders**

1.  Cyclistic executive team.

2.  Lily Moreno - director of marketing and my manager.

------------------------------------------------------------------------

## Step 2 - Prepare

**Key tasks**

1.  Download data and store it appropriately.

-   All data was collected from
    [here](https://divvy-tripdata.s3.amazonaws.com/index.html).

1.  Identify how it’s organized.

2.  Sort and filter the data.

3.  Determine the credibility of the data.

### Libraries setup

``` r
library(tidyverse)
library(lubridate)
library(ggplot2)
library(gridExtra)
library(scales)
```

### Data import

``` r
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
```

Inspect the dataframes and look for incongruencies

    ## [1] 259716     13

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

    ## Rows: 259,716
    ## Columns: 13
    ## $ ride_id            <chr> "BD0A6FF6FFF9B921", "96A7A7A4BDE4F82D", "C61526D065…
    ## $ rideable_type      <chr> "electric_bike", "electric_bike", "electric_bike", …
    ## $ started_at         <dttm> 2020-11-01 13:36:00, 2020-11-01 10:03:26, 2020-11-…
    ## $ ended_at           <dttm> 2020-11-01 13:45:40, 2020-11-01 10:14:45, 2020-11-…
    ## $ start_station_name <chr> "Dearborn St & Erie St", "Franklin St & Illinois St…
    ## $ start_station_id   <dbl> 110, 672, 76, 659, 2, 72, 76, NA, 58, 394, 623, NA,…
    ## $ end_station_name   <chr> "St. Clair St & Erie St", "Noble St & Milwaukee Ave…
    ## $ end_station_id     <dbl> 211, 29, 41, 185, 2, 76, 72, NA, 288, 273, 2, 506, …
    ## $ start_lat          <dbl> 41.89418, 41.89096, 41.88098, 41.89550, 41.87650, 4…
    ## $ start_lng          <dbl> -87.62913, -87.63534, -87.61675, -87.68201, -87.620…
    ## $ end_lat            <dbl> 41.89443, 41.90067, 41.87205, 41.91774, 41.87645, 4…
    ## $ end_lng            <dbl> -87.62338, -87.66248, -87.62955, -87.69139, -87.620…
    ## $ member_casual      <chr> "casual", "casual", "casual", "casual", "casual", "…

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

    ## Rows: 131,573
    ## Columns: 13
    ## $ ride_id            <chr> "70B6A9A437D4C30D", "158A465D4E74C54A", "5262016E0F…
    ## $ rideable_type      <chr> "classic_bike", "electric_bike", "electric_bike", "…
    ## $ started_at         <dttm> 2020-12-27 12:44:29, 2020-12-18 17:37:15, 2020-12-…
    ## $ ended_at           <dttm> 2020-12-27 12:55:06, 2020-12-18 17:44:19, 2020-12-…
    ## $ start_station_name <chr> "Aberdeen St & Jackson Blvd", NA, NA, NA, NA, NA, N…
    ## $ start_station_id   <chr> "13157", NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
    ## $ end_station_name   <chr> "Desplaines St & Kinzie St", NA, NA, NA, NA, NA, NA…
    ## $ end_station_id     <chr> "TA1306000003", NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ start_lat          <dbl> 41.87773, 41.93000, 41.91000, 41.92000, 41.80000, 4…
    ## $ start_lng          <dbl> -87.65479, -87.70000, -87.69000, -87.70000, -87.590…
    ## $ end_lat            <dbl> 41.88872, 41.91000, 41.93000, 41.91000, 41.80000, 4…
    ## $ end_lng            <dbl> -87.64445, -87.70000, -87.70000, -87.70000, -87.590…
    ## $ member_casual      <chr> "member", "member", "member", "member", "member", "…

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

    ## Rows: 96,834
    ## Columns: 13
    ## $ ride_id            <chr> "E19E6F1B8D4C42ED", "DC88F20C2C55F27F", "EC45C94683…
    ## $ rideable_type      <chr> "electric_bike", "electric_bike", "electric_bike", …
    ## $ started_at         <dttm> 2021-01-23 16:14:19, 2021-01-27 18:43:08, 2021-01-…
    ## $ ended_at           <dttm> 2021-01-23 16:24:44, 2021-01-27 18:47:12, 2021-01-…
    ## $ start_station_name <chr> "California Ave & Cortez St", "California Ave & Cor…
    ## $ start_station_id   <chr> "17660", "17660", "17660", "17660", "17660", "17660…
    ## $ end_station_name   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "Wood St & Augu…
    ## $ end_station_id     <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "657", "13258",…
    ## $ start_lat          <dbl> 41.90034, 41.90033, 41.90031, 41.90040, 41.90033, 4…
    ## $ start_lng          <dbl> -87.69674, -87.69671, -87.69664, -87.69666, -87.696…
    ## $ end_lat            <dbl> 41.89000, 41.90000, 41.90000, 41.92000, 41.90000, 4…
    ## $ end_lng            <dbl> -87.72000, -87.69000, -87.70000, -87.69000, -87.700…
    ## $ member_casual      <chr> "member", "member", "member", "member", "casual", "…

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

    ## Rows: 49,622
    ## Columns: 13
    ## $ ride_id            <chr> "89E7AA6C29227EFF", "0FEFDE2603568365", "E6159D746B…
    ## $ rideable_type      <chr> "classic_bike", "classic_bike", "electric_bike", "c…
    ## $ started_at         <dttm> 2021-02-12 16:14:56, 2021-02-14 17:52:38, 2021-02-…
    ## $ ended_at           <dttm> 2021-02-12 16:21:43, 2021-02-14 18:12:09, 2021-02-…
    ## $ start_station_name <chr> "Glenwood Ave & Touhy Ave", "Glenwood Ave & Touhy A…
    ## $ start_station_id   <chr> "525", "525", "KA1503000012", "637", "13216", "1800…
    ## $ end_station_name   <chr> "Sheridan Rd & Columbia Ave", "Bosworth Ave & Howar…
    ## $ end_station_id     <chr> "660", "16806", "TA1305000029", "TA1305000034", "TA…
    ## $ start_lat          <dbl> 42.01270, 42.01270, 41.88579, 41.89563, 41.83473, 4…
    ## $ start_lng          <dbl> -87.66606, -87.66606, -87.63110, -87.67207, -87.625…
    ## $ end_lat            <dbl> 42.00458, 42.01954, 41.88487, 41.90312, 41.83816, 4…
    ## $ end_lng            <dbl> -87.66141, -87.66956, -87.62750, -87.67394, -87.645…
    ## $ member_casual      <chr> "member", "casual", "member", "member", "member", "…

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

    ## Rows: 228,496
    ## Columns: 13
    ## $ ride_id            <chr> "CFA86D4455AA1030", "30D9DC61227D1AF3", "846D87A156…
    ## $ rideable_type      <chr> "classic_bike", "classic_bike", "classic_bike", "cl…
    ## $ started_at         <dttm> 2021-03-16 08:32:30, 2021-03-28 01:26:28, 2021-03-…
    ## $ ended_at           <dttm> 2021-03-16 08:36:34, 2021-03-28 01:36:55, 2021-03-…
    ## $ start_station_name <chr> "Humboldt Blvd & Armitage Ave", "Humboldt Blvd & Ar…
    ## $ start_station_id   <chr> "15651", "15651", "15443", "TA1308000021", "525", "…
    ## $ end_station_name   <chr> "Stave St & Armitage Ave", "Central Park Ave & Bloo…
    ## $ end_station_id     <chr> "13266", "18017", "TA1308000043", "13323", "E008", …
    ## $ start_lat          <dbl> 41.91751, 41.91751, 41.84273, 41.96881, 42.01270, 4…
    ## $ start_lng          <dbl> -87.70181, -87.70181, -87.63549, -87.65766, -87.666…
    ## $ end_lat            <dbl> 41.91774, 41.91417, 41.83066, 41.95283, 42.05049, 4…
    ## $ end_lng            <dbl> -87.69139, -87.71676, -87.64717, -87.64999, -87.677…
    ## $ member_casual      <chr> "casual", "casual", "casual", "casual", "casual", "…

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

    ## Rows: 337,230
    ## Columns: 13
    ## $ ride_id            <chr> "6C992BD37A98A63F", "1E0145613A209000", "E498E15508…
    ## $ rideable_type      <chr> "classic_bike", "docked_bike", "docked_bike", "clas…
    ## $ started_at         <dttm> 2021-04-12 18:25:36, 2021-04-27 17:27:11, 2021-04-…
    ## $ ended_at           <dttm> 2021-04-12 18:56:55, 2021-04-27 18:31:29, 2021-04-…
    ## $ start_station_name <chr> "State St & Pearson St", "Dorchester Ave & 49th St"…
    ## $ start_station_id   <chr> "TA1307000061", "KA1503000069", "20121", "TA1305000…
    ## $ end_station_name   <chr> "Southport Ave & Waveland Ave", "Dorchester Ave & 4…
    ## $ end_station_id     <chr> "13235", "KA1503000069", "20121", "13235", "20121",…
    ## $ start_lat          <dbl> 41.89745, 41.80577, 41.74149, 41.90312, 41.74149, 4…
    ## $ start_lng          <dbl> -87.62872, -87.59246, -87.65841, -87.67394, -87.658…
    ## $ end_lat            <dbl> 41.94815, 41.80577, 41.74149, 41.94815, 41.74149, 4…
    ## $ end_lng            <dbl> -87.66394, -87.59246, -87.65841, -87.66394, -87.658…
    ## $ member_casual      <chr> "member", "casual", "casual", "member", "casual", "…

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

    ## Rows: 531,633
    ## Columns: 13
    ## $ ride_id            <chr> "C809ED75D6160B2A", "DD59FDCE0ACACAF3", "0AB83CB88C…
    ## $ rideable_type      <chr> "electric_bike", "electric_bike", "electric_bike", …
    ## $ started_at         <dttm> 2021-05-30 11:58:15, 2021-05-30 11:29:14, 2021-05-…
    ## $ ended_at           <dttm> 2021-05-30 12:10:39, 2021-05-30 12:14:09, 2021-05-…
    ## $ start_station_name <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ start_station_id   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ end_station_name   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ end_station_id     <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ start_lat          <dbl> 41.90000, 41.88000, 41.92000, 41.92000, 41.94000, 4…
    ## $ start_lng          <dbl> -87.63000, -87.62000, -87.70000, -87.70000, -87.690…
    ## $ end_lat            <dbl> 41.89000, 41.79000, 41.92000, 41.94000, 41.94000, 4…
    ## $ end_lng            <dbl> -87.61000, -87.58000, -87.70000, -87.69000, -87.700…
    ## $ member_casual      <chr> "casual", "casual", "casual", "casual", "casual", "…

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

    ## Rows: 729,595
    ## Columns: 13
    ## $ ride_id            <chr> "99FEC93BA843FB20", "06048DCFC8520CAF", "9598066F68…
    ## $ rideable_type      <chr> "electric_bike", "electric_bike", "electric_bike", …
    ## $ started_at         <dttm> 2021-06-13 14:31:28, 2021-06-04 11:18:02, 2021-06-…
    ## $ ended_at           <dttm> 2021-06-13 14:34:11, 2021-06-04 11:24:19, 2021-06-…
    ## $ start_station_name <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ start_station_id   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ end_station_name   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "Michigan Ave &…
    ## $ end_station_id     <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "13042", NA, NA…
    ## $ start_lat          <dbl> 41.80, 41.79, 41.80, 41.78, 41.80, 41.78, 41.79, 41…
    ## $ start_lng          <dbl> -87.59, -87.59, -87.60, -87.58, -87.59, -87.58, -87…
    ## $ end_lat            <dbl> 41.80000, 41.80000, 41.79000, 41.80000, 41.79000, 4…
    ## $ end_lng            <dbl> -87.6000, -87.6000, -87.5900, -87.6000, -87.5900, -…
    ## $ member_casual      <chr> "member", "member", "member", "member", "member", "…

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

    ## Rows: 822,410
    ## Columns: 13
    ## $ ride_id            <chr> "0A1B623926EF4E16", "B2D5583A5A5E76EE", "6F264597DD…
    ## $ rideable_type      <chr> "docked_bike", "classic_bike", "classic_bike", "cla…
    ## $ started_at         <dttm> 2021-07-02 14:44:36, 2021-07-07 16:57:42, 2021-07-…
    ## $ ended_at           <dttm> 2021-07-02 15:19:58, 2021-07-07 17:16:09, 2021-07-…
    ## $ start_station_name <chr> "Michigan Ave & Washington St", "California Ave & C…
    ## $ start_station_id   <chr> "13001", "17660", "SL-012", "17660", "17660", "1766…
    ## $ end_station_name   <chr> "Halsted St & North Branch St", "Wood St & Hubbard …
    ## $ end_station_id     <chr> "KA1504000117", "13432", "KA1503000044", "13196", "…
    ## $ start_lat          <dbl> 41.88398, 41.90036, 41.86038, 41.90036, 41.90035, 4…
    ## $ start_lng          <dbl> -87.62468, -87.69670, -87.62581, -87.69670, -87.696…
    ## $ end_lat            <dbl> 41.89937, 41.88990, 41.89017, 41.89456, 41.88659, 4…
    ## $ end_lng            <dbl> -87.64848, -87.67147, -87.62619, -87.65345, -87.658…
    ## $ member_casual      <chr> "casual", "casual", "member", "member", "casual", "…

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

    ## Rows: 804,352
    ## Columns: 13
    ## $ ride_id            <chr> "99103BB87CC6C1BB", "EAFCCCFB0A3FC5A1", "9EF4F46C57…
    ## $ rideable_type      <chr> "electric_bike", "electric_bike", "electric_bike", …
    ## $ started_at         <dttm> 2021-08-10 17:15:49, 2021-08-10 17:23:14, 2021-08-…
    ## $ ended_at           <dttm> 2021-08-10 17:22:44, 2021-08-10 17:39:24, 2021-08-…
    ## $ start_station_name <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ start_station_id   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ end_station_name   <chr> NA, NA, NA, NA, NA, NA, NA, "Clark St & Grace St", …
    ## $ end_station_id     <chr> NA, NA, NA, NA, NA, NA, NA, "TA1307000127", NA, NA,…
    ## $ start_lat          <dbl> 41.77000, 41.77000, 41.95000, 41.97000, 41.79000, 4…
    ## $ start_lng          <dbl> -87.68000, -87.68000, -87.65000, -87.67000, -87.600…
    ## $ end_lat            <dbl> 41.77000, 41.77000, 41.97000, 41.95000, 41.77000, 4…
    ## $ end_lng            <dbl> -87.68000, -87.63000, -87.66000, -87.65000, -87.620…
    ## $ member_casual      <chr> "member", "member", "member", "member", "member", "…

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

    ## Rows: 756,147
    ## Columns: 13
    ## $ ride_id            <chr> "9DC7B962304CBFD8", "F930E2C6872D6B32", "6EF7213790…
    ## $ rideable_type      <chr> "electric_bike", "electric_bike", "electric_bike", …
    ## $ started_at         <dttm> 2021-09-28 16:07:10, 2021-09-28 14:24:51, 2021-09-…
    ## $ ended_at           <dttm> 2021-09-28 16:09:54, 2021-09-28 14:40:05, 2021-09-…
    ## $ start_station_name <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "Clark St &…
    ## $ start_station_id   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "TA13070001…
    ## $ end_station_name   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ end_station_id     <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ start_lat          <dbl> 41.89000, 41.94000, 41.81000, 41.80000, 41.88000, 4…
    ## $ start_lng          <dbl> -87.68000, -87.64000, -87.72000, -87.72000, -87.740…
    ## $ end_lat            <dbl> 41.89, 41.98, 41.80, 41.81, 41.88, 41.88, 41.74, 41…
    ## $ end_lng            <dbl> -87.67, -87.67, -87.72, -87.72, -87.71, -87.74, -87…
    ## $ member_casual      <chr> "casual", "casual", "casual", "casual", "casual", "…

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

    ## Rows: 631,226
    ## Columns: 13
    ## $ ride_id            <chr> "620BC6107255BF4C", "4471C70731AB2E45", "26CA69D43D…
    ## $ rideable_type      <chr> "electric_bike", "electric_bike", "electric_bike", …
    ## $ started_at         <dttm> 2021-10-22 12:46:42, 2021-10-21 09:12:37, 2021-10-…
    ## $ ended_at           <dttm> 2021-10-22 12:49:50, 2021-10-21 09:14:14, 2021-10-…
    ## $ start_station_name <chr> "Kingsbury St & Kinzie St", NA, NA, NA, NA, NA, NA,…
    ## $ start_station_id   <chr> "KA1503000043", NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ end_station_name   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ end_station_id     <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    ## $ start_lat          <dbl> 41.88919, 41.93000, 41.92000, 41.92000, 41.89000, 4…
    ## $ start_lng          <dbl> -87.63850, -87.70000, -87.70000, -87.69000, -87.710…
    ## $ end_lat            <dbl> 41.89000, 41.93000, 41.94000, 41.92000, 41.89000, 4…
    ## $ end_lng            <dbl> -87.63000, -87.71000, -87.72000, -87.69000, -87.690…
    ## $ member_casual      <chr> "member", "member", "member", "member", "member", "…

    ## spec_tbl_df [259,716 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:259716] "BD0A6FF6FFF9B921" "96A7A7A4BDE4F82D" "C61526D06582BDC5" "E533E89C32080B9E" ...
    ##  $ rideable_type     : chr [1:259716] "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : POSIXct[1:259716], format: "2020-11-01 13:36:00" "2020-11-01 10:03:26" ...
    ##  $ ended_at          : POSIXct[1:259716], format: "2020-11-01 13:45:40" "2020-11-01 10:14:45" ...
    ##  $ start_station_name: chr [1:259716] "Dearborn St & Erie St" "Franklin St & Illinois St" "Lake Shore Dr & Monroe St" "Leavitt St & Chicago Ave" ...
    ##  $ start_station_id  : num [1:259716] 110 672 76 659 2 72 76 NA 58 394 ...
    ##  $ end_station_name  : chr [1:259716] "St. Clair St & Erie St" "Noble St & Milwaukee Ave" "Federal St & Polk St" "Stave St & Armitage Ave" ...
    ##  $ end_station_id    : num [1:259716] 211 29 41 185 2 76 72 NA 288 273 ...
    ##  $ start_lat         : num [1:259716] 41.9 41.9 41.9 41.9 41.9 ...
    ##  $ start_lng         : num [1:259716] -87.6 -87.6 -87.6 -87.7 -87.6 ...
    ##  $ end_lat           : num [1:259716] 41.9 41.9 41.9 41.9 41.9 ...
    ##  $ end_lng           : num [1:259716] -87.6 -87.7 -87.6 -87.7 -87.6 ...
    ##  $ member_casual     : chr [1:259716] "casual" "casual" "casual" "casual" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_double(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_double(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

    ## spec_tbl_df [131,573 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:131573] "70B6A9A437D4C30D" "158A465D4E74C54A" "5262016E0F1F2F9A" "BE119628E44F871E" ...
    ##  $ rideable_type     : chr [1:131573] "classic_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : POSIXct[1:131573], format: "2020-12-27 12:44:29" "2020-12-18 17:37:15" ...
    ##  $ ended_at          : POSIXct[1:131573], format: "2020-12-27 12:55:06" "2020-12-18 17:44:19" ...
    ##  $ start_station_name: chr [1:131573] "Aberdeen St & Jackson Blvd" NA NA NA ...
    ##  $ start_station_id  : chr [1:131573] "13157" NA NA NA ...
    ##  $ end_station_name  : chr [1:131573] "Desplaines St & Kinzie St" NA NA NA ...
    ##  $ end_station_id    : chr [1:131573] "TA1306000003" NA NA NA ...
    ##  $ start_lat         : num [1:131573] 41.9 41.9 41.9 41.9 41.8 ...
    ##  $ start_lng         : num [1:131573] -87.7 -87.7 -87.7 -87.7 -87.6 ...
    ##  $ end_lat           : num [1:131573] 41.9 41.9 41.9 41.9 41.8 ...
    ##  $ end_lng           : num [1:131573] -87.6 -87.7 -87.7 -87.7 -87.6 ...
    ##  $ member_casual     : chr [1:131573] "member" "member" "member" "member" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_character(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_character(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

    ## spec_tbl_df [96,834 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:96834] "E19E6F1B8D4C42ED" "DC88F20C2C55F27F" "EC45C94683FE3F27" "4FA453A75AE377DB" ...
    ##  $ rideable_type     : chr [1:96834] "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : POSIXct[1:96834], format: "2021-01-23 16:14:19" "2021-01-27 18:43:08" ...
    ##  $ ended_at          : POSIXct[1:96834], format: "2021-01-23 16:24:44" "2021-01-27 18:47:12" ...
    ##  $ start_station_name: chr [1:96834] "California Ave & Cortez St" "California Ave & Cortez St" "California Ave & Cortez St" "California Ave & Cortez St" ...
    ##  $ start_station_id  : chr [1:96834] "17660" "17660" "17660" "17660" ...
    ##  $ end_station_name  : chr [1:96834] NA NA NA NA ...
    ##  $ end_station_id    : chr [1:96834] NA NA NA NA ...
    ##  $ start_lat         : num [1:96834] 41.9 41.9 41.9 41.9 41.9 ...
    ##  $ start_lng         : num [1:96834] -87.7 -87.7 -87.7 -87.7 -87.7 ...
    ##  $ end_lat           : num [1:96834] 41.9 41.9 41.9 41.9 41.9 ...
    ##  $ end_lng           : num [1:96834] -87.7 -87.7 -87.7 -87.7 -87.7 ...
    ##  $ member_casual     : chr [1:96834] "member" "member" "member" "member" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_character(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_character(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

    ## spec_tbl_df [49,622 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:49622] "89E7AA6C29227EFF" "0FEFDE2603568365" "E6159D746B2DBB91" "B32D3199F1C2E75B" ...
    ##  $ rideable_type     : chr [1:49622] "classic_bike" "classic_bike" "electric_bike" "classic_bike" ...
    ##  $ started_at        : POSIXct[1:49622], format: "2021-02-12 16:14:56" "2021-02-14 17:52:38" ...
    ##  $ ended_at          : POSIXct[1:49622], format: "2021-02-12 16:21:43" "2021-02-14 18:12:09" ...
    ##  $ start_station_name: chr [1:49622] "Glenwood Ave & Touhy Ave" "Glenwood Ave & Touhy Ave" "Clark St & Lake St" "Wood St & Chicago Ave" ...
    ##  $ start_station_id  : chr [1:49622] "525" "525" "KA1503000012" "637" ...
    ##  $ end_station_name  : chr [1:49622] "Sheridan Rd & Columbia Ave" "Bosworth Ave & Howard St" "State St & Randolph St" "Honore St & Division St" ...
    ##  $ end_station_id    : chr [1:49622] "660" "16806" "TA1305000029" "TA1305000034" ...
    ##  $ start_lat         : num [1:49622] 42 42 41.9 41.9 41.8 ...
    ##  $ start_lng         : num [1:49622] -87.7 -87.7 -87.6 -87.7 -87.6 ...
    ##  $ end_lat           : num [1:49622] 42 42 41.9 41.9 41.8 ...
    ##  $ end_lng           : num [1:49622] -87.7 -87.7 -87.6 -87.7 -87.6 ...
    ##  $ member_casual     : chr [1:49622] "member" "casual" "member" "member" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_character(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_character(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

    ## spec_tbl_df [228,496 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:228496] "CFA86D4455AA1030" "30D9DC61227D1AF3" "846D87A15682A284" "994D05AA75A168F2" ...
    ##  $ rideable_type     : chr [1:228496] "classic_bike" "classic_bike" "classic_bike" "classic_bike" ...
    ##  $ started_at        : POSIXct[1:228496], format: "2021-03-16 08:32:30" "2021-03-28 01:26:28" ...
    ##  $ ended_at          : POSIXct[1:228496], format: "2021-03-16 08:36:34" "2021-03-28 01:36:55" ...
    ##  $ start_station_name: chr [1:228496] "Humboldt Blvd & Armitage Ave" "Humboldt Blvd & Armitage Ave" "Shields Ave & 28th Pl" "Winthrop Ave & Lawrence Ave" ...
    ##  $ start_station_id  : chr [1:228496] "15651" "15651" "15443" "TA1308000021" ...
    ##  $ end_station_name  : chr [1:228496] "Stave St & Armitage Ave" "Central Park Ave & Bloomingdale Ave" "Halsted St & 35th St" "Broadway & Sheridan Rd" ...
    ##  $ end_station_id    : chr [1:228496] "13266" "18017" "TA1308000043" "13323" ...
    ##  $ start_lat         : num [1:228496] 41.9 41.9 41.8 42 42 ...
    ##  $ start_lng         : num [1:228496] -87.7 -87.7 -87.6 -87.7 -87.7 ...
    ##  $ end_lat           : num [1:228496] 41.9 41.9 41.8 42 42.1 ...
    ##  $ end_lng           : num [1:228496] -87.7 -87.7 -87.6 -87.6 -87.7 ...
    ##  $ member_casual     : chr [1:228496] "casual" "casual" "casual" "casual" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_character(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_character(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

    ## spec_tbl_df [337,230 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:337230] "6C992BD37A98A63F" "1E0145613A209000" "E498E15508A80BAD" "1887262AD101C604" ...
    ##  $ rideable_type     : chr [1:337230] "classic_bike" "docked_bike" "docked_bike" "classic_bike" ...
    ##  $ started_at        : POSIXct[1:337230], format: "2021-04-12 18:25:36" "2021-04-27 17:27:11" ...
    ##  $ ended_at          : POSIXct[1:337230], format: "2021-04-12 18:56:55" "2021-04-27 18:31:29" ...
    ##  $ start_station_name: chr [1:337230] "State St & Pearson St" "Dorchester Ave & 49th St" "Loomis Blvd & 84th St" "Honore St & Division St" ...
    ##  $ start_station_id  : chr [1:337230] "TA1307000061" "KA1503000069" "20121" "TA1305000034" ...
    ##  $ end_station_name  : chr [1:337230] "Southport Ave & Waveland Ave" "Dorchester Ave & 49th St" "Loomis Blvd & 84th St" "Southport Ave & Waveland Ave" ...
    ##  $ end_station_id    : chr [1:337230] "13235" "KA1503000069" "20121" "13235" ...
    ##  $ start_lat         : num [1:337230] 41.9 41.8 41.7 41.9 41.7 ...
    ##  $ start_lng         : num [1:337230] -87.6 -87.6 -87.7 -87.7 -87.7 ...
    ##  $ end_lat           : num [1:337230] 41.9 41.8 41.7 41.9 41.7 ...
    ##  $ end_lng           : num [1:337230] -87.7 -87.6 -87.7 -87.7 -87.7 ...
    ##  $ member_casual     : chr [1:337230] "member" "casual" "casual" "member" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_character(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_character(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

    ## spec_tbl_df [531,633 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:531633] "C809ED75D6160B2A" "DD59FDCE0ACACAF3" "0AB83CB88C43EFC2" "7881AC6D39110C60" ...
    ##  $ rideable_type     : chr [1:531633] "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : POSIXct[1:531633], format: "2021-05-30 11:58:15" "2021-05-30 11:29:14" ...
    ##  $ ended_at          : POSIXct[1:531633], format: "2021-05-30 12:10:39" "2021-05-30 12:14:09" ...
    ##  $ start_station_name: chr [1:531633] NA NA NA NA ...
    ##  $ start_station_id  : chr [1:531633] NA NA NA NA ...
    ##  $ end_station_name  : chr [1:531633] NA NA NA NA ...
    ##  $ end_station_id    : chr [1:531633] NA NA NA NA ...
    ##  $ start_lat         : num [1:531633] 41.9 41.9 41.9 41.9 41.9 ...
    ##  $ start_lng         : num [1:531633] -87.6 -87.6 -87.7 -87.7 -87.7 ...
    ##  $ end_lat           : num [1:531633] 41.9 41.8 41.9 41.9 41.9 ...
    ##  $ end_lng           : num [1:531633] -87.6 -87.6 -87.7 -87.7 -87.7 ...
    ##  $ member_casual     : chr [1:531633] "casual" "casual" "casual" "casual" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_character(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_character(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

    ## spec_tbl_df [729,595 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:729595] "99FEC93BA843FB20" "06048DCFC8520CAF" "9598066F68045DF2" "B03C0FE48C412214" ...
    ##  $ rideable_type     : chr [1:729595] "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : POSIXct[1:729595], format: "2021-06-13 14:31:28" "2021-06-04 11:18:02" ...
    ##  $ ended_at          : POSIXct[1:729595], format: "2021-06-13 14:34:11" "2021-06-04 11:24:19" ...
    ##  $ start_station_name: chr [1:729595] NA NA NA NA ...
    ##  $ start_station_id  : chr [1:729595] NA NA NA NA ...
    ##  $ end_station_name  : chr [1:729595] NA NA NA NA ...
    ##  $ end_station_id    : chr [1:729595] NA NA NA NA ...
    ##  $ start_lat         : num [1:729595] 41.8 41.8 41.8 41.8 41.8 ...
    ##  $ start_lng         : num [1:729595] -87.6 -87.6 -87.6 -87.6 -87.6 ...
    ##  $ end_lat           : num [1:729595] 41.8 41.8 41.8 41.8 41.8 ...
    ##  $ end_lng           : num [1:729595] -87.6 -87.6 -87.6 -87.6 -87.6 ...
    ##  $ member_casual     : chr [1:729595] "member" "member" "member" "member" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_character(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_character(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

    ## spec_tbl_df [822,410 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:822410] "0A1B623926EF4E16" "B2D5583A5A5E76EE" "6F264597DDBF427A" "379B58EAB20E8AA5" ...
    ##  $ rideable_type     : chr [1:822410] "docked_bike" "classic_bike" "classic_bike" "classic_bike" ...
    ##  $ started_at        : POSIXct[1:822410], format: "2021-07-02 14:44:36" "2021-07-07 16:57:42" ...
    ##  $ ended_at          : POSIXct[1:822410], format: "2021-07-02 15:19:58" "2021-07-07 17:16:09" ...
    ##  $ start_station_name: chr [1:822410] "Michigan Ave & Washington St" "California Ave & Cortez St" "Wabash Ave & 16th St" "California Ave & Cortez St" ...
    ##  $ start_station_id  : chr [1:822410] "13001" "17660" "SL-012" "17660" ...
    ##  $ end_station_name  : chr [1:822410] "Halsted St & North Branch St" "Wood St & Hubbard St" "Rush St & Hubbard St" "Carpenter St & Huron St" ...
    ##  $ end_station_id    : chr [1:822410] "KA1504000117" "13432" "KA1503000044" "13196" ...
    ##  $ start_lat         : num [1:822410] 41.9 41.9 41.9 41.9 41.9 ...
    ##  $ start_lng         : num [1:822410] -87.6 -87.7 -87.6 -87.7 -87.7 ...
    ##  $ end_lat           : num [1:822410] 41.9 41.9 41.9 41.9 41.9 ...
    ##  $ end_lng           : num [1:822410] -87.6 -87.7 -87.6 -87.7 -87.7 ...
    ##  $ member_casual     : chr [1:822410] "casual" "casual" "member" "member" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_character(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_character(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

    ## spec_tbl_df [804,352 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:804352] "99103BB87CC6C1BB" "EAFCCCFB0A3FC5A1" "9EF4F46C57AD234D" "5834D3208BFAF1DA" ...
    ##  $ rideable_type     : chr [1:804352] "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : POSIXct[1:804352], format: "2021-08-10 17:15:49" "2021-08-10 17:23:14" ...
    ##  $ ended_at          : POSIXct[1:804352], format: "2021-08-10 17:22:44" "2021-08-10 17:39:24" ...
    ##  $ start_station_name: chr [1:804352] NA NA NA NA ...
    ##  $ start_station_id  : chr [1:804352] NA NA NA NA ...
    ##  $ end_station_name  : chr [1:804352] NA NA NA NA ...
    ##  $ end_station_id    : chr [1:804352] NA NA NA NA ...
    ##  $ start_lat         : num [1:804352] 41.8 41.8 42 42 41.8 ...
    ##  $ start_lng         : num [1:804352] -87.7 -87.7 -87.7 -87.7 -87.6 ...
    ##  $ end_lat           : num [1:804352] 41.8 41.8 42 42 41.8 ...
    ##  $ end_lng           : num [1:804352] -87.7 -87.6 -87.7 -87.7 -87.6 ...
    ##  $ member_casual     : chr [1:804352] "member" "member" "member" "member" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_character(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_character(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

    ## spec_tbl_df [756,147 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:756147] "9DC7B962304CBFD8" "F930E2C6872D6B32" "6EF72137900BB910" "78D1DE133B3DBF55" ...
    ##  $ rideable_type     : chr [1:756147] "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : POSIXct[1:756147], format: "2021-09-28 16:07:10" "2021-09-28 14:24:51" ...
    ##  $ ended_at          : POSIXct[1:756147], format: "2021-09-28 16:09:54" "2021-09-28 14:40:05" ...
    ##  $ start_station_name: chr [1:756147] NA NA NA NA ...
    ##  $ start_station_id  : chr [1:756147] NA NA NA NA ...
    ##  $ end_station_name  : chr [1:756147] NA NA NA NA ...
    ##  $ end_station_id    : chr [1:756147] NA NA NA NA ...
    ##  $ start_lat         : num [1:756147] 41.9 41.9 41.8 41.8 41.9 ...
    ##  $ start_lng         : num [1:756147] -87.7 -87.6 -87.7 -87.7 -87.7 ...
    ##  $ end_lat           : num [1:756147] 41.9 42 41.8 41.8 41.9 ...
    ##  $ end_lng           : num [1:756147] -87.7 -87.7 -87.7 -87.7 -87.7 ...
    ##  $ member_casual     : chr [1:756147] "casual" "casual" "casual" "casual" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_character(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_character(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

    ## spec_tbl_df [631,226 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:631226] "620BC6107255BF4C" "4471C70731AB2E45" "26CA69D43D15EE14" "362947F0437E1514" ...
    ##  $ rideable_type     : chr [1:631226] "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : POSIXct[1:631226], format: "2021-10-22 12:46:42" "2021-10-21 09:12:37" ...
    ##  $ ended_at          : POSIXct[1:631226], format: "2021-10-22 12:49:50" "2021-10-21 09:14:14" ...
    ##  $ start_station_name: chr [1:631226] "Kingsbury St & Kinzie St" NA NA NA ...
    ##  $ start_station_id  : chr [1:631226] "KA1503000043" NA NA NA ...
    ##  $ end_station_name  : chr [1:631226] NA NA NA NA ...
    ##  $ end_station_id    : chr [1:631226] NA NA NA NA ...
    ##  $ start_lat         : num [1:631226] 41.9 41.9 41.9 41.9 41.9 ...
    ##  $ start_lng         : num [1:631226] -87.6 -87.7 -87.7 -87.7 -87.7 ...
    ##  $ end_lat           : num [1:631226] 41.9 41.9 41.9 41.9 41.9 ...
    ##  $ end_lng           : num [1:631226] -87.6 -87.7 -87.7 -87.7 -87.7 ...
    ##  $ member_casual     : chr [1:631226] "member" "member" "member" "member" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_character(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_character(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

Convert start_station_id and end_station_id to character so that they
can stack correctly

``` r
f1_2020_11 <- mutate(f1_2020_11, start_station_id = as.character(start_station_id),
                  end_station_id = as.character(end_station_id)) 
```

Stack individual month’s data frames into one big data frame

``` r
all_trips <- bind_rows(f1_2020_11, f2_2020_12, f3_2021_01, f4_2021_02, f5_2021_03, f6_2021_04, f7_2021_05, f8_2021_06, f9_2021_07, f10_2021_08, f11_2021_09, f12_2021_10)
```

------------------------------------------------------------------------

## Step 3 - Process

**Key tasks**

1.  Check the data for errors.

2.  Choose your tools.

3.  Transform the data so you can work with it effectively.

4.  Document the cleaning process.

Inspect the new table that has been created

``` r
colnames(all_trips) #List of column names
```

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

``` r
nrow(all_trips) #How many rows are in data frame? 
```

    ## [1] 5378834

``` r
dim(all_trips) #Dimensions of the data frame? 
```

    ## [1] 5378834      13

``` r
head(all_trips) #See the first 6 rows of data frame. Also tail(all_trips)
```

    ## # A tibble: 6 × 13
    ##   ride_id          rideable_type started_at          ended_at            start_station_n…
    ##   <chr>            <chr>         <dttm>              <dttm>              <chr>           
    ## 1 BD0A6FF6FFF9B921 electric_bike 2020-11-01 13:36:00 2020-11-01 13:45:40 Dearborn St & E…
    ## 2 96A7A7A4BDE4F82D electric_bike 2020-11-01 10:03:26 2020-11-01 10:14:45 Franklin St & I…
    ## 3 C61526D06582BDC5 electric_bike 2020-11-01 00:34:05 2020-11-01 01:03:06 Lake Shore Dr &…
    ## 4 E533E89C32080B9E electric_bike 2020-11-01 00:45:16 2020-11-01 00:54:31 Leavitt St & Ch…
    ## 5 1C9F4EF18C168C60 electric_bike 2020-11-01 15:43:25 2020-11-01 16:16:52 Buckingham Foun…
    ## 6 7259585D8276D338 electric_bike 2020-11-14 15:55:17 2020-11-14 16:44:38 Wabash Ave & 16…
    ## # … with 8 more variables: start_station_id <chr>, end_station_name <chr>,
    ## #   end_station_id <chr>, start_lat <dbl>, start_lng <dbl>, end_lat <dbl>,
    ## #   end_lng <dbl>, member_casual <chr>

``` r
str(all_trips) #See list of columns and data types (numeric, character, etc) 
```

    ## spec_tbl_df [5,378,834 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:5378834] "BD0A6FF6FFF9B921" "96A7A7A4BDE4F82D" "C61526D06582BDC5" "E533E89C32080B9E" ...
    ##  $ rideable_type     : chr [1:5378834] "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : POSIXct[1:5378834], format: "2020-11-01 13:36:00" "2020-11-01 10:03:26" ...
    ##  $ ended_at          : POSIXct[1:5378834], format: "2020-11-01 13:45:40" "2020-11-01 10:14:45" ...
    ##  $ start_station_name: chr [1:5378834] "Dearborn St & Erie St" "Franklin St & Illinois St" "Lake Shore Dr & Monroe St" "Leavitt St & Chicago Ave" ...
    ##  $ start_station_id  : chr [1:5378834] "110" "672" "76" "659" ...
    ##  $ end_station_name  : chr [1:5378834] "St. Clair St & Erie St" "Noble St & Milwaukee Ave" "Federal St & Polk St" "Stave St & Armitage Ave" ...
    ##  $ end_station_id    : chr [1:5378834] "211" "29" "41" "185" ...
    ##  $ start_lat         : num [1:5378834] 41.9 41.9 41.9 41.9 41.9 ...
    ##  $ start_lng         : num [1:5378834] -87.6 -87.6 -87.6 -87.7 -87.6 ...
    ##  $ end_lat           : num [1:5378834] 41.9 41.9 41.9 41.9 41.9 ...
    ##  $ end_lng           : num [1:5378834] -87.6 -87.7 -87.6 -87.7 -87.6 ...
    ##  $ member_casual     : chr [1:5378834] "casual" "casual" "casual" "casual" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ride_id = col_character(),
    ##   ..   rideable_type = col_character(),
    ##   ..   started_at = col_datetime(format = ""),
    ##   ..   ended_at = col_datetime(format = ""),
    ##   ..   start_station_name = col_character(),
    ##   ..   start_station_id = col_double(),
    ##   ..   end_station_name = col_character(),
    ##   ..   end_station_id = col_double(),
    ##   ..   start_lat = col_double(),
    ##   ..   start_lng = col_double(),
    ##   ..   end_lat = col_double(),
    ##   ..   end_lng = col_double(),
    ##   ..   member_casual = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

``` r
summary(all_trips) #Statistical summary of data. Mainly for numerics
```

    ##    ride_id          rideable_type        started_at                 
    ##  Length:5378834     Length:5378834     Min.   :2020-11-01 00:00:08  
    ##  Class :character   Class :character   1st Qu.:2021-05-17 12:45:18  
    ##  Mode  :character   Mode  :character   Median :2021-07-13 22:33:14  
    ##                                        Mean   :2021-06-27 18:37:41  
    ##                                        3rd Qu.:2021-09-02 18:18:14  
    ##                                        Max.   :2021-10-31 23:59:49  
    ##                                                                     
    ##     ended_at                   start_station_name start_station_id  
    ##  Min.   :2020-11-01 00:02:20   Length:5378834     Length:5378834    
    ##  1st Qu.:2021-05-17 13:07:36   Class :character   Class :character  
    ##  Median :2021-07-13 22:57:23   Mode  :character   Mode  :character  
    ##  Mean   :2021-06-27 18:58:10                                        
    ##  3rd Qu.:2021-09-02 18:35:16                                        
    ##  Max.   :2021-11-03 21:45:48                                        
    ##                                                                     
    ##  end_station_name   end_station_id       start_lat       start_lng     
    ##  Length:5378834     Length:5378834     Min.   :41.64   Min.   :-87.84  
    ##  Class :character   Class :character   1st Qu.:41.88   1st Qu.:-87.66  
    ##  Mode  :character   Mode  :character   Median :41.90   Median :-87.64  
    ##                                        Mean   :41.90   Mean   :-87.65  
    ##                                        3rd Qu.:41.93   3rd Qu.:-87.63  
    ##                                        Max.   :42.08   Max.   :-87.52  
    ##                                                                        
    ##     end_lat         end_lng       member_casual     
    ##  Min.   :41.51   Min.   :-88.07   Length:5378834    
    ##  1st Qu.:41.88   1st Qu.:-87.66   Class :character  
    ##  Median :41.90   Median :-87.64   Mode  :character  
    ##  Mean   :41.90   Mean   :-87.65                     
    ##  3rd Qu.:41.93   3rd Qu.:-87.63                     
    ##  Max.   :42.17   Max.   :-87.44                     
    ##  NA's   :4831    NA's   :4831

Inspect NaN values

``` r
colSums(is.na(all_trips))
```

    ##            ride_id      rideable_type         started_at           ended_at 
    ##                  0                  0                  0                  0 
    ## start_station_name   start_station_id   end_station_name     end_station_id 
    ##             600479             600586             646471             646548 
    ##          start_lat          start_lng            end_lat            end_lng 
    ##                  0                  0               4831               4831 
    ##      member_casual 
    ##                  0

### Remove bad data

Remove lat, long, birthyear

``` r
all_trips_v2 <- all_trips %>%
  select(-c(start_lat, start_lng, end_lat, end_lng))
```

### Adding date formats

Add columns that list the date, month, day, hour and year of each ride.

``` r
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
```

Add a “ride_length” calculation to all_trips_v2 (in seconds).

``` r
all_trips_v2$ride_length <- difftime(all_trips_v2$ended_at,all_trips_v2$started_at)

# Inspect the structure of the columns
str(all_trips_v2)
```

    ## tibble [5,378,834 × 16] (S3: tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:5378834] "BD0A6FF6FFF9B921" "96A7A7A4BDE4F82D" "C61526D06582BDC5" "E533E89C32080B9E" ...
    ##  $ rideable_type     : chr [1:5378834] "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : POSIXct[1:5378834], format: "2020-11-01 13:36:00" "2020-11-01 10:03:26" ...
    ##  $ ended_at          : POSIXct[1:5378834], format: "2020-11-01 13:45:40" "2020-11-01 10:14:45" ...
    ##  $ start_station_name: chr [1:5378834] "Dearborn St & Erie St" "Franklin St & Illinois St" "Lake Shore Dr & Monroe St" "Leavitt St & Chicago Ave" ...
    ##  $ start_station_id  : chr [1:5378834] "110" "672" "76" "659" ...
    ##  $ end_station_name  : chr [1:5378834] "St. Clair St & Erie St" "Noble St & Milwaukee Ave" "Federal St & Polk St" "Stave St & Armitage Ave" ...
    ##  $ end_station_id    : chr [1:5378834] "211" "29" "41" "185" ...
    ##  $ member_casual     : chr [1:5378834] "casual" "casual" "casual" "casual" ...
    ##  $ date              : Date[1:5378834], format: "2020-11-01" "2020-11-01" ...
    ##  $ month             : chr [1:5378834] "11" "11" "11" "11" ...
    ##  $ day               : chr [1:5378834] "01" "01" "01" "01" ...
    ##  $ year              : chr [1:5378834] "2020" "2020" "2020" "2020" ...
    ##  $ day_of_week       : Ord.factor w/ 7 levels "Sunday"<"Monday"<..: 1 1 1 1 1 7 7 7 7 7 ...
    ##  $ hour              : chr [1:5378834] "13" "10" "00" "00" ...
    ##  $ ride_length       : 'difftime' num [1:5378834] 580 679 1741 555 ...
    ##   ..- attr(*, "units")= chr "secs"

Convert “ride_length” from Factor to numeric so we can run calculations
on the data

``` r
is.factor(all_trips_v2$ride_length)
```

    ## [1] FALSE

``` r
all_trips_v2$ride_length <- as.numeric(as.character(all_trips_v2$ride_length))
is.numeric(all_trips_v2$ride_length)
```

    ## [1] TRUE

There are no invaluable NaN rows to be removed

``` r
colSums(is.na(all_trips_v2))
```

    ##            ride_id      rideable_type         started_at           ended_at 
    ##                  0                  0                  0                  0 
    ## start_station_name   start_station_id   end_station_name     end_station_id 
    ##             600479             600586             646471             646548 
    ##      member_casual               date              month                day 
    ##                  0                  0                  0                  0 
    ##               year        day_of_week               hour        ride_length 
    ##                  0                  0                  0                  0

Inspect station names

``` r
unique_station_names = sort(intersect(unique(all_trips_v2$start_station_name), unique(all_trips_v2$end_station_name)))
```

Fix ride length

``` r
dim(all_trips_v2) # 5378834 rows
```

    ## [1] 5378834      16

``` r
distinct(all_trips_v2) # no duplicates
```

    ## # A tibble: 5,378,834 × 16
    ##    ride_id          rideable_type started_at          ended_at           
    ##    <chr>            <chr>         <dttm>              <dttm>             
    ##  1 BD0A6FF6FFF9B921 electric_bike 2020-11-01 13:36:00 2020-11-01 13:45:40
    ##  2 96A7A7A4BDE4F82D electric_bike 2020-11-01 10:03:26 2020-11-01 10:14:45
    ##  3 C61526D06582BDC5 electric_bike 2020-11-01 00:34:05 2020-11-01 01:03:06
    ##  4 E533E89C32080B9E electric_bike 2020-11-01 00:45:16 2020-11-01 00:54:31
    ##  5 1C9F4EF18C168C60 electric_bike 2020-11-01 15:43:25 2020-11-01 16:16:52
    ##  6 7259585D8276D338 electric_bike 2020-11-14 15:55:17 2020-11-14 16:44:38
    ##  7 91FE5C8F8A676594 electric_bike 2020-11-14 16:47:29 2020-11-14 17:03:03
    ##  8 9E7A79ADA90C2695 electric_bike 2020-11-14 16:04:15 2020-11-14 16:19:33
    ##  9 A5B02C0D41DBCDAF electric_bike 2020-11-14 16:24:09 2020-11-14 16:51:34
    ## 10 8234407C29FE41DC electric_bike 2020-11-14 01:24:22 2020-11-14 01:31:42
    ## # … with 5,378,824 more rows, and 12 more variables: start_station_name <chr>,
    ## #   start_station_id <chr>, end_station_name <chr>, end_station_id <chr>,
    ## #   member_casual <chr>, date <date>, month <chr>, day <chr>, year <chr>,
    ## #   day_of_week <ord>, hour <chr>, ride_length <dbl>

``` r
# Remove ride_length <= 60 or ride_length > 60*60*24
rides_to_be_removed <- subset(all_trips_v2, ride_length <= 60 | ride_length > 60*60*24)
all_trips_fixed_rides_length <- subset(all_trips_v2, ride_length > 60 & ride_length <= 60*60*24)
dim(all_trips_fixed_rides_length)
```

    ## [1] 5292133      16

Drop bad station names

``` r
# Remove test (26), repair (8) and check (26) start and end stations

all_trips_v3 <- all_trips_fixed_rides_length[!grepl("TEST", all_trips_fixed_rides_length$start_station_name) & !grepl("TEST", all_trips_fixed_rides_length$end_station_name),]

all_trips_v3 <- all_trips_fixed_rides_length[!grepl("REPAIR", all_trips_fixed_rides_length$start_station_name) & !grepl("REPAIR", all_trips_fixed_rides_length$end_station_name),]

all_trips_v3 <- all_trips_fixed_rides_length[!grepl("CHECKING", all_trips_fixed_rides_length$start_station_name) & !grepl("CHECKING", all_trips_fixed_rides_length$end_station_name),]
```

    ##            ride_id      rideable_type         started_at           ended_at 
    ##                  0                  0                  0                  0 
    ## start_station_name   start_station_id   end_station_name     end_station_id 
    ##             581709             581808             621545             621614 
    ##      member_casual               date              month                day 
    ##                  0                  0                  0                  0 
    ##               year        day_of_week               hour        ride_length 
    ##                  0                  0                  0                  0

``` r
dim(all_trips_v3)
```

    ## [1] 5292107      16

``` r
colSums(is.na(all_trips_v3))
```

    ##            ride_id      rideable_type         started_at           ended_at 
    ##                  0                  0                  0                  0 
    ## start_station_name   start_station_id   end_station_name     end_station_id 
    ##             581709             581808             621545             621614 
    ##      member_casual               date              month                day 
    ##                  0                  0                  0                  0 
    ##               year        day_of_week               hour        ride_length 
    ##                  0                  0                  0                  0

``` r
all_trips_v4 <- drop_na(all_trips_v3)
dim(all_trips_v4)
```

    ## [1] 4432377      16

``` r
colSums(is.na(all_trips_v4))
```

    ##            ride_id      rideable_type         started_at           ended_at 
    ##                  0                  0                  0                  0 
    ## start_station_name   start_station_id   end_station_name     end_station_id 
    ##                  0                  0                  0                  0 
    ##      member_casual               date              month                day 
    ##                  0                  0                  0                  0 
    ##               year        day_of_week               hour        ride_length 
    ##                  0                  0                  0                  0

``` r
(dim(all_trips_v3)[1] - dim(all_trips_v4)[1]) / dim(all_trips_v3)[1]
```

    ## [1] 0.1624551

### Renaming

Column renaming for easy life

``` r
(all_trips_v4 <- rename(all_trips_v4,
                  user_type = member_casual))
```

    ## # A tibble: 4,432,377 × 16
    ##    ride_id          rideable_type started_at          ended_at           
    ##    <chr>            <chr>         <dttm>              <dttm>             
    ##  1 BD0A6FF6FFF9B921 electric_bike 2020-11-01 13:36:00 2020-11-01 13:45:40
    ##  2 96A7A7A4BDE4F82D electric_bike 2020-11-01 10:03:26 2020-11-01 10:14:45
    ##  3 C61526D06582BDC5 electric_bike 2020-11-01 00:34:05 2020-11-01 01:03:06
    ##  4 E533E89C32080B9E electric_bike 2020-11-01 00:45:16 2020-11-01 00:54:31
    ##  5 1C9F4EF18C168C60 electric_bike 2020-11-01 15:43:25 2020-11-01 16:16:52
    ##  6 7259585D8276D338 electric_bike 2020-11-14 15:55:17 2020-11-14 16:44:38
    ##  7 91FE5C8F8A676594 electric_bike 2020-11-14 16:47:29 2020-11-14 17:03:03
    ##  8 A5B02C0D41DBCDAF electric_bike 2020-11-14 16:24:09 2020-11-14 16:51:34
    ##  9 8234407C29FE41DC electric_bike 2020-11-14 01:24:22 2020-11-14 01:31:42
    ## 10 3D2F9317211E3350 electric_bike 2020-11-14 12:05:08 2020-11-14 12:09:38
    ## # … with 4,432,367 more rows, and 12 more variables: start_station_name <chr>,
    ## #   start_station_id <chr>, end_station_name <chr>, end_station_id <chr>,
    ## #   user_type <chr>, date <date>, month <chr>, day <chr>, year <chr>,
    ## #   day_of_week <ord>, hour <chr>, ride_length <dbl>

------------------------------------------------------------------------

## Step 4 - Analysis

**Key tasks**

1.  Aggregate your data so it’s useful and accessible.

2.  Organize and format your data.

3.  Perform calculations.

4.  Identify trends and relationships

Initial summary

``` r
summary(all_trips_v4)
```

    ##    ride_id          rideable_type        started_at                 
    ##  Length:4432377     Length:4432377     Min.   :2020-11-01 00:00:08  
    ##  Class :character   Class :character   1st Qu.:2021-05-14 12:11:30  
    ##  Mode  :character   Mode  :character   Median :2021-07-10 15:38:29  
    ##                                        Mean   :2021-06-25 02:52:23  
    ##                                        3rd Qu.:2021-08-30 18:27:32  
    ##                                        Max.   :2021-10-31 23:58:15  
    ##                                                                     
    ##     ended_at                   start_station_name start_station_id  
    ##  Min.   :2020-11-01 00:02:20   Length:4432377     Length:4432377    
    ##  1st Qu.:2021-05-14 12:32:59   Class :character   Class :character  
    ##  Median :2021-07-10 16:03:07   Mode  :character   Mode  :character  
    ##  Mean   :2021-06-25 03:12:58                                        
    ##  3rd Qu.:2021-08-30 18:45:19                                        
    ##  Max.   :2021-11-01 10:58:41                                        
    ##                                                                     
    ##  end_station_name   end_station_id      user_type              date           
    ##  Length:4432377     Length:4432377     Length:4432377     Min.   :2020-11-01  
    ##  Class :character   Class :character   Class :character   1st Qu.:2021-05-14  
    ##  Mode  :character   Mode  :character   Mode  :character   Median :2021-07-10  
    ##                                                           Mean   :2021-06-24  
    ##                                                           3rd Qu.:2021-08-30  
    ##                                                           Max.   :2021-10-31  
    ##                                                                               
    ##     month               day                year              day_of_week    
    ##  Length:4432377     Length:4432377     Length:4432377     Sunday   :704410  
    ##  Class :character   Class :character   Class :character   Monday   :552074  
    ##  Mode  :character   Mode  :character   Mode  :character   Tuesday  :570657  
    ##                                                           Wednesday:584313  
    ##                                                           Thursday :574318  
    ##                                                           Friday   :635269  
    ##                                                           Saturday :811336  
    ##      hour            ride_length   
    ##  Length:4432377     Min.   :   61  
    ##  Class :character   1st Qu.:  438  
    ##  Mode  :character   Median :  761  
    ##                     Mean   : 1235  
    ##                     3rd Qu.: 1372  
    ##                     Max.   :86362  
    ## 

``` r
# Get the first starting date and the last date
mindate <- min(all_trips_v4$started_at)
maxdate <- max(all_trips_v4$started_at)
```

### Ride times

``` r
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
```

![](capstone-notebook_files/figure-gfm/user%20type%20statistic-1.png)<!-- -->

    Observation 1: Casual users ride much longer.

### Weekday

``` r
weekdays_rides <- all_trips_v4 %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(user_type, weekday) %>% 
  summarise(number_of_rides = n() ,average_duration = mean(ride_length)) %>%
  arrange(user_type,weekday)
```

    ## `summarise()` has grouped output by 'user_type'. You can override using the `.groups` argument.

``` r
ggplot(weekdays_rides, aes(x = weekday, y = number_of_rides, fill = user_type)) + 
  geom_col(show.legend = FALSE, position = "dodge") +
  facet_wrap(~user_type) +
  labs(title="Number of rides by rider type",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Weekdays",
       y="Number of Rides") +
  scale_y_continuous(labels = comma)
```

![](capstone-notebook_files/figure-gfm/weekday%20total%20rides-1.png)<!-- -->

    Observation 2: Members tend to ride more continuously around the week, but casual users peak at weekends and much less on working days.

``` r
ggplot(weekdays_rides, aes(x = weekday, y = average_duration / 60, fill = user_type)) + 
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title="Average duration",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Weekdays",
       y="Number of Rides")
```

![](capstone-notebook_files/figure-gfm/weekday%20average%20ride-1.png)<!-- -->

    Observation 3: Casual user tend to make longer trips.

### Months

``` r
# Monthly trips by user: Member vs Casual

monthly_trips <- all_trips_v4 %>%
  group_by(user_type, month) %>% 
  summarise(number_of_rides = n() ,average_duration = mean(ride_length)) %>%
  arrange(month)
```

    ## `summarise()` has grouped output by 'user_type'. You can override using the `.groups` argument.

``` r
ggplot(monthly_trips, aes(x = month, y = number_of_rides, fill= user_type)) +
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title = "Monthly trips, Member vs Casual",
       caption = paste0("Data Source by Motivate Internatiol INC."),
       x="Months",
       y="Number of Rides") + 
  theme(axis.text.x = element_text(angle = 50,hjust = 1)) +
  scale_y_continuous(labels = comma)
```

![](capstone-notebook_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

``` r
ggplot(monthly_trips, aes(x = month, y = average_duration, fill= user_type)) +
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title = "Monthly trips, Member vs Casual",
       caption = "Data Source by Motivate Internatiol INC.",
       x="Months",
       y="Average duration") + 
  theme(axis.text.x = element_text(angle = 50,hjust = 1)) + 
  scale_y_continuous(labels = comma) 
```

![](capstone-notebook_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

    Observation 4: Both members and casual users use this transit more on summer months, with significant drop on winter. Most preferable months of casual riders is July and August.

### Daytime

Preferred daytime for riding

    ## `summarise()` has grouped output by 'user_type'. You can override using the `.groups` argument.

``` r
ggplot(daytime_hours, aes(x = hour, y = number_of_rides, fill = user_type)) + 
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title="Daytime hour preference",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Hour",
       y="Number of Rides") +
  coord_flip() +
  scale_y_continuous(labels = comma)
```

![](capstone-notebook_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

    Observation 5: Casual user peak at evening, after work hours, just like members, who use the bike system to and from work.

``` r
ggplot(daytime_hours, aes(x = hour, y = average_duration / 60, fill = user_type)) + 
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title="Daytime hour preference",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Hour",
       y="Average Duration") +
  coord_flip() +
  scale_y_continuous(labels = comma)
```

![](capstone-notebook_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

    Observation 6: Casual trips mush shorter in the morning (5am-8am), with two peaks right before the dawn and in the afternoon, while members use regularly over the 24-hour period.

### Bike Preference

``` r
bike_type <- all_trips_v4 %>%
  group_by(user_type, rideable_type) %>% 
  summarise(number_of_rides = n() ,average_duration = mean(ride_length))
```

    ## `summarise()` has grouped output by 'user_type'. You can override using the `.groups` argument.

``` r
ggplot(bike_type, aes(x = rideable_type, y = number_of_rides, fill = user_type)) + 
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title="Bike type preference",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Bike type",
       y="Number of Rides") +
  scale_y_continuous(labels = comma)
```

![](capstone-notebook_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

    Observation 7: Classic bike is the most preferable bike for all users.

``` r
ggplot(bike_type, aes(x = rideable_type, y = average_duration / 60, fill = user_type)) + 
  facet_wrap(~user_type) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title="Bike type preference",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Bike type",
       y="Average Duration")
```

![](capstone-notebook_files/figure-gfm/bike%20type%20preference-1.png)<!-- -->

    Observation 8: Again, members use what is available at the station, while casual user prefer the docked bike.

### Popular stations

``` r
popular_start_stations <- all_trips_v4 %>% 
  group_by(user_type, start_station_name) %>% 
  summarize (number_of_rides = n()) %>% 
  arrange(-number_of_rides)
```

    ## `summarise()` has grouped output by 'user_type'. You can override using the `.groups` argument.

``` r
ggplot(popular_start_stations[1:10,], aes(x = start_station_name, y = number_of_rides, fill= user_type)) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title = "Popular Start Stations",
       caption = "Data Source by Motivate Internatiol INC.",
       x="Stations",
       y="Number of Rides") +
  scale_y_continuous(labels = comma) +
  theme(axis.text.x = element_text(angle = 50,hjust = 1))
```

![](capstone-notebook_files/figure-gfm/popular%20stations%20start-1.png)<!-- -->

``` r
popular_end_stations <- all_trips_v4 %>% 
  group_by(user_type, end_station_name) %>% 
  summarize (number_of_rides = n()) %>% 
  arrange(-number_of_rides)
```

    ## `summarise()` has grouped output by 'user_type'. You can override using the `.groups` argument.

``` r
ggplot(popular_end_stations[1:10,], aes(x = end_station_name, y = number_of_rides, fill= user_type)) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title = "Popular End Stations",
       caption = "Data Source by Motivate Internatiol INC.",
       x="Stations",
       y="Number of Rides") +
  scale_y_continuous(labels = comma) +
  theme(axis.text.x = element_text(angle = 50,hjust = 1))
```

![](capstone-notebook_files/figure-gfm/popular%20stations%20end-1.png)<!-- -->

``` r
top_popular_station <- all_trips_v4 %>%
  group_by(start_station_name, user_type) %>%
  summarise(number_of_rides = n()) %>%
  arrange(-number_of_rides)
```

    ## `summarise()` has grouped output by 'start_station_name'. You can override using the `.groups` argument.

``` r
ggplot(top_popular_station[1:20,], aes(x = start_station_name, y = number_of_rides, fill = user_type)) +
  geom_col(show.legend = FALSE, position = "dodge") +
  labs(title = "Top Popular Stations",
       caption = "Data Source by Motivate Internatiol INC.",
       x="Stations",
       y="Number of Rides") +
  scale_y_continuous(labels = comma) +
  theme(axis.text.x = element_text(angle = 50,hjust = 1))
```

![](capstone-notebook_files/figure-gfm/top%20popular%20stations-1.png)<!-- -->

    Observation 9: The top 3 preferred station of the casual users, and the top 3 stations with the most users, are:

    1. Streeter Dr & Grand Ave

    2. Millennium Park

    3. Michigan Ave & Oak St

    While the members top 3 are:

    1. Clark St & Elm St

    2. Wells St & Concord Ln

    3. Kingsbury St & Kinzie St

------------------------------------------------------------------------

## Step 5 - Share

**Key tasks**

1.  Determine the best way to share your findings.

2.  Create effective data visualizations.

3.  Present your findings.

4.  Ensure your work is accessible.

I used RStudio with R language for this case study from step 2 to 5.

This work is accessible on (as of 2021-11-15)

-   Kaggle

-   Medium

-   GitHub

------------------------------------------------------------------------

## Step 6 - Act

### Summary

Based on the business task - **How do annual members and casual riders
use Cyclistic bikes differently?**, and my *key observations*:

    Observation 1: Casual users ride much longer.

    Observation 2: Members tend to ride more continuously around the week, but casual users peak at weekends and much less on working days.

    Observation 3: Casual user tend to make longer trips.

    Observation 4: Both members and casual users use this transit more on summer months, with significant drop on winter. Most preferable months of casual riders is July and August.

    Observation 5: Casual user peak at evening, after work hours, just like members, who use the bike system to and from work.

    Observation 6: Casual trips mush shorter in the morning (5am-8am), with two peaks right before the dawn and in the afternoon, while members use regularly over the 24-hour period.

    Observation 7: Classic bike is the most preferable bike for all users.

    Observation 8: Again, members use what is available at the station, while casual user prefer the docked bike.

    Observation 9: The top 3 preferred station of the casual users, and the top 3 stations with the most users, are:

    1. Streeter Dr & Grand Ave

    2. Millennium Park

    3. Michigan Ave & Oak St

    While the members top 3 are:

    1. Clark St & Elm St

    2. Wells St & Concord Ln

    3. Kingsbury St & Kinzie St

### My top 3 recommendations:

1.  Campaign on discount membership for longer rides during the weekends
    (Observations 1, 2 and 3).

2.  Add more bikes and promotions at the casual users top stations
    (Observation 9).

3.  Afternoon and summer months special offers for member users, as to
    draw the casual users to join in (Observations 4, 5, 6).

### Things to explore more:

1.  Stations which have the least casual users, or even none at all -
    are they in an area full of member users?

2.  Preferred bike - does each station have approximately the same
    amount of different types of bikes? Or the classic bike has a
    monopoly, therefore the observations 7 and 8 are bias?
