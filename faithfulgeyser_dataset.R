install.packages('ggplot2')
data(faithful)
?faithful

#GGPLOT

ggplot2(data=faithful, mapping=aes(x=eruptions))+
  geom_histogram(binwidth = 0.5)

ggplot(faithful)+
  geom_point(mapping = aes(eruptions,waiting))