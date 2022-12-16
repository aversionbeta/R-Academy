
ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy, color=manufacturer))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy, color=manufacturer))+
  facet_grid(drv ~ cyl)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy, color=manufacturer))+
  facet_wrap(~class, nrow=3, ncol = 4)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy, size=cty))+
  facet_wrap(~class, nrow=3, ncol = 4)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x=displ, y=hwy, linetype=drv, color=drv),
  show.legend=FALSE)
  
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x=displ, y=hwy, group=drv))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy, color=class))+
  geom_smooth(mapping = aes(x=displ, y=hwy))

ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point()+
  geom_smooth()

ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point(mapping = aes(color=class))+
  geom_smooth(mapping = aes(linetype=drv))


ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point(mapping = aes(color=class))+
  geom_smooth(
    data = filter(mpg, class=="subcompact"),
    se=FALSE
  )

ggplot(data = mpg, mapping = aes(x=displ, y=hwy, color=drv)) + 
  geom_point()+
  geom_smooth(se=FALSE)

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=cut))

?geom_bar

demo <- tribble(
  ~a, ~b, 
  "bar1",20,
  "bar2",30,
  "bar3",40
)
ggplot(data = demo)+
  geom_bar(mapping = aes(x=a, y=b), stat="identity")
  
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

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy, color=manufacturer), position="jitter")

ggplot(data = mpg)+
  geom_jitter(mapping = aes(x=displ, y=hwy))

ggplot(data = mpg, mapping = aes(x=class, y=hwy))+
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x=class, y=hwy))+
  geom_boxplot()+
  coord_flip()

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

ggplot(data = mpg, mapping = aes(x=cty, y=hwy))+
  geom_point()+
  geom_abline()+
  coord_fixed()

