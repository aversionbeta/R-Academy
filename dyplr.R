y <- seq(1,10, length.out=5)
y

install.packages("nycflights13")

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