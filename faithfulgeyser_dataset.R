install.packages('ggplot2')
data(faithful)
?faithful

ggplot2(data=faithful, mapping=aes(x=eruptions))+
  geom_histogram(binwidth = 0.5)

