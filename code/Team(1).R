path<-'D:/GloablStudyProgram/visualization/team.csv'
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

fig <- fig %>% colorbar(title = "Team Number")
fig <- fig %>% layout(
  title = 'Professional Sport Team Numbers by State',
  geo = g
)
fig


fig

