path<-'/Users/guogeyang/Desktop/STA/DS比赛/visualization/PopulationStates.csv'
df<-read.csv(path)

library(maps)
library(ggplot2)
library(plotly)

#df<-data.frame(States=tolower(df$States),Population=df$Population)
df<-df[,c(2,3)]

# states_map<-map_data("state")
# USA_map<-ggplot(df,aes(map_id=States))+
#   geom_map(aes(fill=Population),map=states_map)+
#   scale_fill_distiller(palette='RdPu',direction=1)+
#   expand_limits(x=states_map$long,y=states_map$lat)+
#   theme_minimal()
# USA_map
# ggplotly(USA_map)


df$hover<-with(df,Population)
fig<-plot_geo(df,locationmode='USA-states')
fig<-fig%>%add_trace(
  locations=~Code,
  z=~Population,
  text=~hover,
  colorscale='Reds'
)
fig

