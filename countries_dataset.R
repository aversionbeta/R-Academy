df <- read_csv("C:/Users/juand/Dropbox/Profesional/7. Delphus Lab/5. Delphus Lab Academy/R-Academy/data.csv", na = "")
df

library('ggplot2')
ggplot(df)+
  geom_bar(mapping=aes(CCA3))
