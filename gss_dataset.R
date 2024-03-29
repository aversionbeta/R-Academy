library(tibble)
library(forcats)
library(dyplr)
library(ggplot2)

forcats::gss_cat

#Watching categoies immediately -dyplr needed

gss_cat%>%
  count(race)

ggplot(gss_cat, aes(race))+
  geom_bar()

ggplot(gss_cat, aes(race))+
  geom_bar()+
  scale_x_discrete(drop=FALSE)

gss_cat%>%
  count(rincome)

ggplot(gss_cat, aes(rincome))+
  geom_bar()

#Average number of hours spent watching TV per day per religion: 

relig<-gss_cat%>%
  group_by(relig)%>%
  summarize(
    age=mean(age,na.rm = TRUE),
    tvhours = mean(tvhours,na.rm = TRUE),
    n=n()
  )

ggplot(relig,aes(tvhours,relig))+
  geom_point()

relig%>%
  mutate(relig=fct_reorder(relig,tvhours))%>%
  ggplot(aes(tvhours,relig))+
    geom_point()


rincome<-gss_cat%>%
  group_by(rincome)%>%
  summarize(
    age=mean(age,na.rm = TRUE),
    tvhours = mean(tvhours,na.rm = TRUE),
    n=n()
  )

rincome%>%
  mutate(rincome=fct_relevel(rincome,"Not applicable"))%>%
  ggplot(aes(age,rincome))+
  geom_point()

by_age<-gss_cat%>%
  filter(!is.na(age))%>%
  group_by(age,marital)%>%
  count()%>%
  mutate(prop=n/sum(n))

ggplot(
  by_age,
  aes(age,prop,color=fct_reorder2(marital,age,prop)))+
  geom_line()+
  labs(color="marital")

gss_cat%>%
  mutate(marital=marital%>%fct_infreq()%>%fct_rev())%>%
  ggplot(aes(marital))+
    geom_bar()

gss_cat%>%count(partyid)

gss_cat%>%
  mutate(partyid=fct_recode(partyid,
    "Republican, strong" = "Strong republican",
    "Republican,weak"= "Not str republican",
    "Independent, near rep"= "Ind,near rep",
    "Independen, near dem" = "Ind,near dem",
    "Democrat, weak" = "Not str democrat",
    "Democrat, strong" = "Strong democrat"
    ))%>%
  count(partyid)

gss_cat%>%
  mutate(partyid=fct_collapse(partyid,
    other = c("No answer", "Don't know", "Other party"),
    rep = c("Strong republican", "Not str republican"),
    ind = c("Ind,near rep", "Independent", "Ind,near dem"),
    dem = c("Not str democrat","Strong democrat")
    ))%>%
      count(partyid)

gss_cat%>%
  mutate(relig=fct_lump(relig,n=10))%>%
  count(relig,sort=TRUE)%>%
  print(n=Inf)