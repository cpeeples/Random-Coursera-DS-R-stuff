## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#plot1.R
totalem<-tapply(NEI$Emissions,NEI$year,sum)
year<-as.Date(names(totalem),format="%Y")
fit1<-lm(totalem~year)
summary(fit1)

png("plot1.png")
plot(year,totalem, ylab="USA Total PM-2.5 Emissions [tons]",main="trend of USA total pm-2.5 emissions")
abline(fit1,col="red")
text(x= as.Date("2005",format="%Y") ,y= 6.5E6 ,labels="R2 = 0.924\nP = 0.04",col="red")
dev.off()

#plot 2.R
BLT<-NEI[NEI$fips==24510,]
BLTem<-tapply(BLT$Emissions,BLT$year,sum)
year<-as.Date(names(BLTem),format="%Y")
fit2<-lm(BLTem~year)
summary(fit)

png("plot2.png")
plot(year,BLTem, ylab="Baltimore PM-2.5 Emissions [tons]",main="trend of Baltimore pm-2.5 emissions")
abline(fit2,col="blue")
text(x= as.Date("2005",format="%Y") ,y= 2.85E3 ,labels="R2 = 0.521\nP = 0.28",col="blue")
dev.off()

#plot3.R
png("plot3.png")
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
qplot(date,emissions,data=BLTem,geom=c("point","smooth"),method="lm",facets=.~type)
dev.off()

#plot4.R
#matches<-grepl("F",SCC$EI.Sector)
coalcodes<-SCC[SCC$EI.Sector=="Fuel Comb - Electric Generation - Coal","SCC"]
coal<-NEI[NEI$SCC %in% coalcodes,]
coalem<-tapply(coal$Emissions,coal$year,sum)
year<-as.Date(names(coalem),format="%Y")
fit3<-lm(coalem~year)
summary(fit3)

png("plot4.png")
plot(year,coalem, ylab="USA coal-related PM-2.5 Emissions [tons]",main="trend of USA coal-related pm-2.5 emissions")
abline(fit3,col="green")
text(x= as.Date("2005",format="%Y") ,y= 5.2E5 ,labels="R2 = 0.72\nP = 0.10",col="green")
dev.off()
#qplot(year,coalem,geom=c("point","smooth"),method="lm",main="pm2.5 emissions from coal combustion across US",ylab="pm2.5 emissions [tons]")


#plot5.R
mobilecodes<-SCC[grepl("Mobile",SCC$EI.Sector),"SCC"]
mobile<-NEI[NEI$SCC %in% mobilecodes & NEI$fips==24510,]
mobileem<-tapply(mobile$Emissions,mobile$year,sum)
year<-as.Date(names(mobileem),format="%Y")
fit4<-lm(mobileem~year)
summary(fit4)

png("plot5.png")
plot(year,mobileem, ylab="Baltimore mobile PM-2.5 Emissions [tons]",main="trend of Baltimore mobile pm-2.5 emissions")
abline(fit4,col="orange")
text(x= as.Date("2005",format="%Y") ,y= 700 ,labels="R2 = 0.34\nP = 0.42",col="orange")
dev.off()

#plot6.R
mobilecodes<-SCC[grepl("Mobile",SCC$EI.Sector),"SCC"]
mobile<-NEI[NEI$SCC %in% mobilecodes & NEI$fips==24510,]
mobileem<-tapply(mobile$Emissions,mobile$year,sum)
year<-as.Date(names(mobileem),format="%Y")
fit4<-lm(mobileem~year)
summary(fit4)

LAmobilecodes<-SCC[grepl("Mobile",SCC$EI.Sector),"SCC"]
LAmobile<-NEI[NEI$SCC %in% LAmobilecodes & NEI$fips=="06037",]
LAmobileem<-tapply(LAmobile$Emissions,LAmobile$year,sum)
LAyear<-as.Date(names(LAmobileem),format="%Y")
fit5<-lm(LAmobileem~year)
summary(fit5)

png("plot6.png",width=960,height=480)
par(mfrow=c(1,2))
plot(LAyear,LAmobileem, ylab="LA mobile PM-2.5 Emissions [tons]",main="trend of LA mobile pm-2.5 emissions", col="blue")
abline(fit5,col="blue")
text(x= as.Date("2005",format="%Y") ,y= 8500 ,labels="R2 = 0.09\nP = 0.70",col="blue")
plot(year, mobileem, ylab="BLT mobile PM-2.5 Emissions [tons]",main="trend of BLT mobile pm-2.5 emissions",col="orange")
abline(fit4,col="orange")
text(x= as.Date("2005",format="%Y") ,y= 700 ,labels="R2 = 0.34\nP = 0.42",col="orange")
dev.off()
