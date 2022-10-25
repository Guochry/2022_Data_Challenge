homeless<-read.csv('/Users/guogeyang/Desktop/STA/DS比赛/visualization/homeless.csv')
homeless<-melt(homeless,id.vars = 'year')
homeless$year<-as.character(homeless$year)
ggplot(homeless,aes(year,value,fill=variable))+
  geom_bar(stat='identity',position = 'stack')+
  scale_fill_manual(values = c('green','blue'))+
  labs(x="Year",y='Population')+
  scale_y_continuous(expand = c(0,0))
