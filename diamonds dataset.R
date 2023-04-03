install.packages('ggplot2')
data(diamonds)
?diamonds

ggplot(data=diamonds)+
  geom_bar(mapping=aes(x= cut))

diamonds %>% 
  count(cut)

ggplot(data=diamonds)+
  geom_histogram(mapping=aes(x=carat), binwidth = 0.5)

diamonds%>%
  count(cut_width(carat, 0.5))

smaller <- diamonds %>%
  filter(carat<3)

ggplot(data=smaller)+
  geom_histogram(mapping = aes(x=carat), binwidth = 0.1)

ggplot(data=smaller, mapping=aes(x=carat, color = cut))+
  geom_freqpoly(binwidth = 0.1)

ggplot(data=smaller, mapping = aes(x=carat))+
  geom_histogram( binwidth = 0.01)

ggplot(data=diamonds, mapping=aes(x=y))+
  geom_histogram(binwidth = 0.5)

ggplot(data=diamonds, mapping = aes(x=y))+
  geom_histogram(binwidth = 0.5)+
  coord_cartesian(ylim = c(0,50))

unusual<- diamonds %>% 
  filter(y<3|y>20)%>%
  arrange(y)
unusual

diamonds%>%
  arrange((price))

ggplot(diamonds, aes(price,carat))+
  geom_point(aes(colour=cut, size=depth))

ggplot(diamonds, aes(price,carat))+
  geom_point(aes(colour=cut, size=depth))+
  coord_cartesian(xlim = c(5000,7500))

diamonds%>%
  filter(between(y,3,20))

diamonds2<-diamonds%>%
  mutate(y=ifelse(y<3|y>20,NA,y))

ggplot(diamonds2,aes(x,y))+
  geom_point(na.rm = TRUE)

diamonds %>%
  count(cut,color) %>%
  ggplot(aes(cut,color))+
    geom_tile(aes(fill=n))

ggplot(diamonds)+
  geom_point(aes(carat, price))

ggplot(diamonds)+
  geom_point(aes(carat, price),alpha=1/100)
