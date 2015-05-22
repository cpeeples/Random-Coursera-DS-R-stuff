## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#plot3.R
png("plot3.png",width=1920,height=480)
BLT<-NEI[NEI$fips==24510,]
BLT["typeyear"]<-paste(BLT$type,BLT$year," ")
BLTem<-tapply(BLT$Emissions,BLT$typeyear,sum)
newcolumns<-t(data.frame(strsplit(rownames(BLTem)," ")))
BLTem<-cbind(newcolumns[,1:2],data.frame(BLTem)[,1])
BLTem<-data.frame(BLTem)
names(BLTem)<-c("type","date","emissions")
BLTem$date<-as.Date(as.character(BLTem$date),format="%Y")
BLTem$emissions<-as.numeric(as.character(BLTem$emissions))
library(ggplot2)
qplot(date,emissions,data=BLTem,geom=c("point","smooth"),method="lm",color=type,facets=.~type,main="Baltimore emission by source type")
dev.off()
