install.packages('mpg')
data(mpg)
?mpg

ggplot(mpg, aes(class,hwy))+
  geom_boxplot()

ggplot(mpg)+
  geom_boxplot(
    aes(
      x=reorder(class,hwy, FUN = median),
      y=hwy
  )
)+
coord_flip()

ggplot(mpg)+
  geom_violin(
    aes(
      x=reorder(class,hwy, FUN = median),
      y=hwy
    )
  )+
  coord_flip()

ggplot(mpg)+
  geom_jitter(
    aes(
      x=reorder(class,hwy, FUN = median),
      y=hwy
    )
  )+
  coord_flip()