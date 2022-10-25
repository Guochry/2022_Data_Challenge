path<-'D:/GloablStudyProgram/visualization/income.csv'
library(reshape2)
library(ggbump)
library(ggplot2)
library(maps)
library(dplyr)
library(gganimate)
library(gifski)
library(magick)
library(sf)
df<-read.csv(path)
df
df<-t(df)
df
df<-df[,1:51]
df[is.na(df)]<-0
rownames(df)<-tolower(rownames(df))
colnames(df)<-df[1,]
df<-df[-1,]
df
rownames(df)[c(1,6,7,9,12,15,20)]<-c('new jersy','rhode island','west virginia',
                                     'new york','new hampshire','washington dc','south dakota')
df<-cbind(df,region=rownames(df))
df
state_map<-map_data("state")
state_map
attach(state_map)
xx<-numeric(nrow(df))
yy<-numeric(nrow(df))
df
for (i in 1:nrow(df)){
  xx[i]<-mean(long[region==df[i,ncol(df)]])
  yy[i]<-mean(lat[region==df[i,ncol(df)]])
}
df<-cbind(df,xx)
df<-cbind(df,yy)
df
mytheme= theme(
  plot.title = element_text(face = "bold", hjust = 0.5, color = "black"),
  plot.subtitle = element_text(face = "bold", hjust = 0.5, size = 20, color = "red"),
  plot.caption = element_text(face = "bold", hjust = 1, color = "black"),
  legend.title = element_text(face = "bold", color = "black"),
  legend.text = element_text(face = "bold",color = "black"),
  legend.background = element_rect(colour = "black"),
  legend.key = element_rect(fill = NA),
  legend.position = c(0.85, 0.2),
  axis.ticks = element_blank(),
  axis.text = element_blank(),
  panel.background = element_blank(),
  panel.border = element_rect(color = "black", linetype = "solid", size = 1, fill = NA)
)
image<-numeric(51)
for (i in 1:51){
  income<-data.frame(df[,c(i,52,53,54)])
  income[,1]<-as.integer(income[,1])
  income$latitude<-as.numeric(income$xx)
  income$longitude<-as.numeric(income$yy)
  income<-income[c(-1,-15),]
  image[i]<-colnames(income)[1]
  colnames(income)[1]<-c('Tax')
  p<-qplot(latitude, longitude, data = income,size=Tax,color=2)+ 
    borders("state", size= 0.5)+
    labs(title = "monthly income by states",
         subtitle=image[i])+
    mytheme+
    guides(color='none')
  p
  ggsave(filename = paste0(image[i],".png"),
         plot = p, path = "D:/GloablStudyProgram/visualization",
         width = 20, height = 20, units = "cm")
}
image
income.gif<-image_animate(image=image_read(path=paste0("D:/GloablStudyProgram/visualization","/",image,".png")))
income.gif
anim_save(filename = "income.gif",animation = income.gif,path="D:/GloablStudyProgram/visualization")