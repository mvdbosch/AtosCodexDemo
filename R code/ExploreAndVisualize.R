##################################################################
# Description: Analyze CBS Dataset, Predict and visualize - Property and money crimes. Export model to PMML
# Date: 20-feb-2017
# Author: Marcel van den Bosch <marcel.vandenbosch@atos.net>
##################################################################


# Include libraries
library(data.table)
library(ggplot2)
library(ggmap)
library(grid)
library(gridExtra);
library(stringr)
library(XML)
library(pmml)

#Set workdir
setwd('~/Documents/AtosCodexDemo');

# Load combined dataset we created earlier with Talend ETL
data <- read.csv('Dataset/combined_data.csv',header=T,stringsAsFactors = FALSE);

# Load GIS polygon shape data
shapeInfo <- read.csv('Dataset/CBS_DATA_NL_2010-2015/shapeInfoAll.csv',stringsAsFactors = FALSE);

data_groningen <- data[data$Gemeentenaam=="Groningen" & data$YEAR == '2015',];
shapeGroningen <- shapeInfo[shapeInfo$BU_CODE %in% data_groningen$Regiocode,];

data_groningen$Vermogensmisdrijven_rel <- as.numeric(data_groningen$Vermogensmisdrijven_rel);
data_groningen$A_BED_GI <- as.numeric(data_groningen$A_BED_GI);
data_groningen$AV1_CAFTAR <- as.numeric(data_groningen$AV1_CAFTAR);
data_groningen$AF_TREINST <- as.numeric(data_groningen$AF_TREINST);
data_groningen$AF_ZIEK_E <- as.numeric(data_groningen$AF_ZIEK_E);


data_groningen_combined <- merge(x=shapeGroningen,y=data_groningen,by.y='Regiocode',by.x='BU_CODE');

# Plot a map
mapCenter <- geocode("Groningen") 
Groningen <- get_map(c(lon=mapCenter$lon, lat=mapCenter$lat),zoom = 12)#, maptype = "terrain", source="google") 
GroningenMap <- ggmap(Groningen) 

GroningenMap <- GroningenMap + 
geom_polygon(aes(x=long, y=lat, group=group, fill=Vermogensmisdrijven_rel), 
size=.2 ,color='black', data=data_groningen_combined, alpha=0.8) + 
scale_fill_gradient(low = "green", high = "red") 
GroningenMap 

## Make a linear model to predict
train_groningen <- subset(data_groningen,select=c('Vermogensmisdrijven_rel','A_BED_GI','AV1_CAFTAR','AF_TREINST','AF_ZIEK_E'));
train_groningen <- train_groningen[complete.cases(train_groningen),]

fit <- glm(Vermogensmisdrijven_rel ~ A_BED_GI + AV1_CAFTAR + AF_TREINST + AF_ZIEK_E, data=train_groningen, family=poisson());

summary(fit);
anova(fit,test="Chisq")
plot(fit,which=1)

# Plot our predictions
predGroningen <- predict(fit,newdata=train_groningen,type="response");

GroningenTotaal <- train_groningen;
GroningenTotaal$Prediction <- predGroningen;
plot(GroningenTotaal$Vermogensmisdrijven_rel,GroningenTotaal$Prediction,ylim=c(0,500),xlim=c(0,500));
abline(1,1)

## Test our prediction on another city - Arnhem!
data_arnhem <- data[data$Gemeentenaam=="Arnhem" & data$YEAR == '2015',];

data_arnhem$Vermogensmisdrijven_rel <- as.numeric(data_arnhem$Vermogensmisdrijven_rel);
data_arnhem$A_BED_GI <- as.numeric(data_arnhem$A_BED_GI);
data_arnhem$AV1_CAFTAR <- as.numeric(data_arnhem$AV1_CAFTAR);
data_arnhem$AF_TREINST <- as.numeric(data_arnhem$AF_TREINST);
data_arnhem$AF_ZIEK_E <- as.numeric(data_arnhem$AF_ZIEK_E);

test_arnhem <- subset(data_arnhem,select=c('Regiocode','Vermogensmisdrijven_rel','A_BED_GI','AV1_CAFTAR','AF_TREINST','AF_ZIEK_E'));
test_arnhem <- test_arnhem[complete.cases(test_arnhem),]
predArnhem <- predict(fit,newdata=test_arnhem,type="response");

ArnhemTotaal <- test_arnhem;
ArnhemTotaal$Prediction <- predArnhem;
plot(ArnhemTotaal$Vermogensmisdrijven_rel,ArnhemTotaal$Prediction);
abline(1,1)

## Let's visualize
shapeArnhem <- shapeInfo[shapeInfo$BU_CODE %in% ArnhemTotaal$Regiocode,];

data_arnhem_combined <- merge(x=shapeArnhem,y=ArnhemTotaal,by.y='Regiocode',by.x='BU_CODE');

# Plot a map - Actuals
mapCenter <- geocode("Arnhem") 
Arnhem <- get_map(c(lon=mapCenter$lon, lat=mapCenter$lat),zoom = 12)#, maptype = "terrain", source="google") 
ArnhemMap <- ggmap(Arnhem) 

ArnhemMap <- ArnhemMap + 
  geom_polygon(aes(x=long, y=lat, group=group, fill=Vermogensmisdrijven_rel), 
               size=.2 ,color='black', data=data_arnhem_combined, alpha=0.8) + 
  scale_fill_gradient(low = "green", high = "red")  + labs(fill="Actual")
#ArnhemMap 

## Now a map with our predictions
ArnhemMapPred <- ggmap(Arnhem) 

ArnhemMapPred <- ArnhemMapPred + 
  geom_polygon(aes(x=long, y=lat, group=group, fill=Prediction), 
               size=.2 ,color='black', data=data_arnhem_combined, alpha=0.8) + 
  scale_fill_gradient(low = "green", high = "red")   + labs(fill="Predict")
#ArnhemMapPred 

## Compare our actual vs. predict.
grid.arrange(ArnhemMap, ArnhemMapPred, ncol=2, top=textGrob("Actual vs. Prediction",gp=gpar(fontsize=20,font=3)))

## Output our model as a PMML and save it to a file
export_pmml <- pmml(fit,model.name="Generalized Linear Regression Model",app.name="R");
pmml_plain_text <- toString.XMLNode(export_pmml)
writeLines(text=pmml_plain_text,con=file('~/Documents/AtosCodexDemo/Dataset/PredModel.PMML'));
View(pmml_plain_text)


