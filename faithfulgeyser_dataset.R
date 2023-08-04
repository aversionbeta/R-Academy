install.packages('ggplot2')

library('readr')
library('ggplot2')
data(faithful)
faithful
?faithful

#GGPLOT

ggplot2(data=faithful, mapping=aes(x=eruptions))+
  geom_histogram(binwidth = 0.5)

ggplot(faithful)+
  geom_point(mapping = aes(eruptions,waiting))

#READR 

write_csv(faithful,"faithful.csv")
read_csv("faithful.csv")