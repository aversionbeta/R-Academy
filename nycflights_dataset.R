install.packages('nycflights13')
data(nycflights13)
?nycflights2

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
      binwidth = 1/4
    )

ggplot(diamonds, aes(price))+
  geom_freqpoly(aes(color=cut), binwidth=500)

ggplot(diamonds, aes(cut,price))+
  geom_boxplot()