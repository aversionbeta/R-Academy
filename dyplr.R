y <- seq(1,10, length.out=5)
y
install.packages("dplyr")
install.packages("nycflights13")
install.packages("ggplot2")

?flights

(jan1 <- filter(flights, month == 1, day == 1))

filter(flights, month %in% c(11,12))

# Flights that had an arrival delay of two or more hours
filter(flights, arr_delay >= 120)

# All Flights to Houston (IAH or HOU)
filter(flights, dest %in% c("IAH", "HOU"))

# All flights that were operated by United, American, or Delta
filter(flights, carrier %in% c("United", "American", "Delta"))

# All flights that departed in Summer (July, August, September)
filter (flights, month %in% c(7,8,9) )

# All flights that arrived more than two hours late, but didn't leave late 
filter(flights, arr_delay > 120, dep_delay == 0 )

# All flights that were delayed by at least an hour, but made up over 30 minutes flight
filter(flights, dep_delay>60, air_time>30)

# All flights that departed between midnight and 6 am 
filter(flights, between(dep_time, 2400, 6000))

arrange(flights, year, month, day)

arrange(flights, desc(arr_delay))

?flights

# Most delayed flights 

arrange(flights, arr_delay)

# Select variables

select(flights, year, month,day)

#Select columns between dates 

select(flights, year:day)

#Change name variable

rename(flights, tail_num = tailnum)

# Move variables to the beginning 

select(flights, time_hour, day, carrier, everything())

select(flights, day, day)

#Variables that contains variable
select(flights, contains ("TIME"))

#Add more columns with mutate
flights_sml <- select(flights,year:day,ends_with("delay"),distance, air_time) 
mutate(flights_sml, 
       gain = arr_delay - dep_delay,
       speed = distance / air_time*60)

#Adding more variables with mutate
mutate(flights_sml, 
       gain = arr_delay - dep_delay,
       hours = air_time/60,
       gain_per_hour = gain / hours)

#Only showing the new columns with Transmute
transmute(flights_sml, 
       gain = arr_delay - dep_delay,
       hours = air_time/60,
       gain_per_hour = gain / hours)

#Spliting a column into indexes
transmute(flights,
          dep_time,
          dep_time %/%100,
          dep_time %% 100)

#Using lag() and lead()
(x<- 1:10)
lag(x)
lag(x,2)
lead(x)
lead(x,2)

#Using cummulatives and rolling agregates
(x<- 1:10)
cumsum(x)
cummean(x)
cummin(x)
cummax(x)
cumprod(x)

#Using different types of ranks
y<- c(1,2,2,NA,3,4)
min_rank(y)
min_rank(desc(y))
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)

(x<- 1:10 + 1:10)
x

#Summaries 
summarize(flights, delay = mean(dep_delay,na.rm = TRUE)) #summarize from table flights, a variable called delay which will be the mean value removing null values 

by_day<-group_by(flights, year,month,day)
summarize(by_day, delay = mean (dep_delay, na.rm=TRUE))

#Multiple operations with the Pipe

flights %>%
  group_by(dest)%>%
  summarise(
    count = n(),
    dist = mean (distance,na.rm=TRUE),
    delay = mean (arr_delay,na.rm=TRUE)
  )%>%
  filter(count > 20, dest != "HNL")

flights %>%
  group_by(year,month,day)%>%
  summarise(mean = mean(dep_delay, na.rm=TRUE))

not_cancelled <- flights %>%
  filter(!is.na(dep_delay),!is.na (arr_delay))

not_cancelled%>%
  group_by(year,month,day)%>%
  summarise(mean=mean(dep_delay))