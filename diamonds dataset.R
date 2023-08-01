install.packages('ggplot2')
data(diamonds)
?diamonds

#GGPLOT
ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut))

ggplot(data=diamonds)+
  geom_bar(mapping=aes(x= cut))

diamonds %>% 
  count(cut)

ggplot(data = diamonds)+
  stat_summary(
    mapping = aes(x=cut, y=depth),
    fun.ymax = max,
    fun.ymin = min,
    fun.y = median
  )

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut, color= cut))

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut, fill= cut))

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut, fill= clarity))

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut, fill= clarity), position = "fill")

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut, fill= clarity), position = "dodge")

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

ggplot(diamonds, aes(price))+
  geom_freqpoly(aes(color=cut), binwidth=500)

ggplot(diamonds, aes(cut,price))+
  geom_boxplot()

ggplot(smaller)+
  geom_bin2d(mapping=aes(carat,price))

ggplot(smaller)+
  geom_hex(mapping=aes(carat,price))

ggplot(smaller, mapping=aes(carat,price))+
  geom_boxplot(mapping = aes(group=cut_width(carat,0.1)))

bar<- ggplot(data=diamonds)+
  geom_bar(
    mapping = aes(x=cut, fill=cut),
    show.legend = FALSE,
    width = 1
  )+
  theme(aspect.ratio = 1)+
  labs(x=NULL,y=NULL)

bar+coord_flip()
bar+coord_polar()

library(modelr)
mod <- lm(log(price)~log(carat),diamonds)
diamonds2<-diamonds%>%
  add_residuals(mod)%>%
  mutate(resid=exp(resid))
ggplot(diamonds2)+
  geom_point(mapping = aes(carat,resid))
