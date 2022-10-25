path<-'/Users/guogeyang/Desktop/STA/DS比赛/visualization/stadium.csv'
df<-read.csv(path)

library(maps)
library(ggplot2)
library(plotly)

df

df$hover<-with(df,X0)

l <- list(color = toRGB("white"), width = 2)
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

fig<-plot_geo(df,locationmode='USA-states')
fig<-fig%>%add_trace(
  locations=~X,
  z=~X0,
  text=~hover,
  colorscale='Reds'
)

fig <- fig %>% colorbar(title = "Total Capacity")
fig <- fig %>% layout(
  title = 'Stadium Capacity by State',
  geo = g
)
fig
