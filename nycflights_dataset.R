install.packages("dplyr")

library("ggplot2")
library("dplyr")
library("dbplyr")
library('nycflights13')
library('tidyverse')
library('stringr')
library('tidyr')
library('lubridate')

data(flights)
?flights

nycflights13::flights %>%
  print(n=10,width=Inf)

nycflights13::flights %>%
  View()

#DYPLR

y <- seq(1,10, length.out=5)
y

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

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarise(delay = mean (arr_delay, na.rm = TRUE),
            n=n())

ggplot(data=delays, mapping = aes(x=n,y=delay)) + 
  geom_point(alpha=1/10)

delays %>%
  filter(n>25)%>%
  ggplot(mapping = aes(x=n, y=delay))+
  geom_point(alpha=1/10)

install.packages("Lahman")

batting <- as_tibble(Lahman::Batting)

batters<- batting %>%
  group_by(playerID)%>%
  summarise(
    ba= sum(H, na.rm = TRUE) / sum (AB, na.rm = TRUE),
    ab = sum (AB, na.rm = TRUE)
  )

batters%>% 
  filter(ab>100)%>%
  ggplot(mapping = aes(x=ab,y=ba))+
  geom_point()+
  geom_smooth(se=FALSE)

batters%>%
  arrange(desc(ba))

not_cancelled%>%
  group_by(year,month,day)%>%
  summarise(
    avg_delay = mean(arr_delay),
    avg_delay2 = mean (arr_delay[arr_delay>0])
  )

not_cancelled%>%
  group_by(dest)%>%
  summarise(distance_sd=sd(distance))%>%
  arrange(desc(distance_sd))

#When do the first and last flights leave each day? 

not_cancelled%>%
  group_by(year, month, day)%>%
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

not_cancelled%>%
  group_by(year, month, day)%>%
  summarise(
    first = first(dep_time),
    last = last(dep_time)
  )

not_cancelled %>%
  group_by(dest)%>%
  summarise(carriers=n_distinct(carrier))%>%
  arrange(desc(carriers))

not_cancelled%>%
  count(dest)

#How many flights left before 5 am? 

not_cancelled%>%
  group_by(year,month,day)%>%
  summarise(
    n_early= sum(dep_time<500)
  )


#GGPLOT

nycflights13::flights%>%
  mutate(
    cancelled=is.na(dep_time),
    sched_hour=sched_dep_time %/% 100,
    sched_min=sched_dep_time %% 100,
    sched_dep_time=sched_hour + sched_min / 60
  )%>%
  ggplot(aes(sched_dep_time))+
    geom_freqpoly(
      aes(color=cancelled),
      binwidth = 1/2
    )

flights%>%
  avg_delay=mean(arr_delay)%>%
  ggplot(aes(month,destination))+
    geom_tile(aes(fill=avg_delay))

#TIDYR

flights%>%
  gather('year',key="year", value="cases")

#MUTATE JOINS
flights2 <- flights %>%
  select(year:day,hour,origin,dest,tailnum,carrier)
flights2

flights2 %>%
  select(-origin,-dest)%>%
  left_join(airlines,by="carrier")
flights2

flights2 %>%
  select(-origin,-dest)%>%
  mutate(name= airlines$name[match(carrier, airlines$carrier)])
flights2

top_dest<-flights %>%
  count(dest,sort = TRUE)%>%
  head(10)
top_dest

flights%>%
  filter(dest %in% top_dest$dest)

#Filtering Joins

top_dest <- flights %>%
    count(dest, sort = TRUE)%>%
    head(10)
top_dest

flights %>%
  filter(dest %in% top_dest$dest)

flights%>%
  semi_join(top_dest)

flights%>%
  anti_join(planes, by="tailnum")%>%
  count(tailnum, sort=TRUE)

x<-c("apple","banana")
str_view(x,"an.")

flights%>%
  select(year,month,day,hour,minute)%>%
  mutate(
    departure=make_datetime(year,month,day,hour,minute)
  )
