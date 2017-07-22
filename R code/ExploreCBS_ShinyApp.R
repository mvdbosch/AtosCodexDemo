########################################################################
# File: ExporeCBS_ShinyApp.R
# Author: Marcel van den Bosch <marcel.vandenbosch@atos.net>
#
# Description: Explores the CBS dataset using Shiny
########################################################################

library(shiny)
library(data.table)
library(ggplot2)
library(ggmap)

#Set workdir
setwd('~/Documents/AtosCodexDemo/');

# First: Make the CBS data available

# Load combined dataset we created earlier with Talend ETL
if (exists('data') == FALSE)
{
data <- read.csv('Dataset/combined_data.csv',header=T,stringsAsFactors = FALSE);
}
# Load GIS polygon shape data
if (exists('shapeInfo') == FALSE )
{
shapeInfo <- read.csv('Dataset/CBS_DATA_NL_2010-2015/shapeInfoAll.csv',stringsAsFactors = FALSE);
}
varList <- names(data);
varList <- varList[!(varList %in% c('Regiocode','Regionaam','Wijkcode','Buurtnaam','Gemeentecode','Gemeentenaam','POSTCODE','id'))]


# Define UI for application that plots random distributions 
ui <- shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Explore CBS Crime and Demographics 2015"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    selectInput("selectYear", "Year:", choices = sort(unique(data$YEAR)), selected = NULL, multiple = FALSE,
                selectize = TRUE),   
    selectInput("selectCity", "City/Municipality:", choices = sort(unique(data$Gemeentenaam)), selected = NULL, multiple = FALSE,
                selectize = TRUE),
    selectInput("selectVariable", "Variable:", choices = sort(varList), selected = NULL, multiple = FALSE,
                selectize = TRUE),
    plotOutput("histoPlot",width='500px',height = '250px')
    
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("mapPlot",width='800px',height = '600px')
  )
))


# Define server logic required to generate and plot a random distribution
serv <- shinyServer(function(input, output) {
  
  output$mapPlot <- renderPlot({
    
    # generate an rnorm distribution and plot it
    # Plot a map
    dataCity <- data[data$Gemeentenaam==input$selectCity & data$YEAR == input$selectYear,];
    shapeCity <- shapeInfo[shapeInfo$BU_CODE %in% dataCity$Regiocode,];  
    
    dataCity <- subset(dataCity,select=c('Regiocode',input$selectVariable));
    names(dataCity) <- c('Regiocode','Value');
    dataCity$Value <- as.numeric(dataCity$Value);
    
    data_city_combined <- merge(x=shapeCity,y=dataCity,by.y='Regiocode',by.x='BU_CODE');

    mapCenter <- geocode(input$selectCity) 
    City <- get_map(c(lon=mapCenter$lon, lat=mapCenter$lat),zoom = 12)#, maptype = "terrain", source="google") 
    CityMap <- ggmap(City) 
    
    CityMap <- CityMap + 
      geom_polygon(aes(x=long, y=lat, group=group, fill=Value), 
                   size=.2 ,color='black', data=data_city_combined, alpha=0.6) + 
      scale_fill_gradient(low = "green", high = "red") + labs(fill=input$selectVariable)
    CityMap 
    
  })
  
  
  output$histoPlot <- renderPlot({
    
    dataAll <- subset(data,select=c('Regiocode',input$selectVariable));
    names(dataAll) <- c('Regiocode','Value');
    dataAll$Value <- as.numeric(dataAll$Value);
    
    hist(dataAll$Value,main=paste('Histogram of',input$selectVariable,'in NL for all years'),xlab=input$selectVariable,breaks = 20)
    
  })
})



runApp(shinyApp(ui = ui, server = serv))

