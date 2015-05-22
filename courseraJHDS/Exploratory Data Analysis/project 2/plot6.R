## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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
plot(LAyear,LAmobileem, xlab="year",ylab="LA mobile PM-2.5 Emissions [tons]",main="trend of LA mobile pm-2.5 emissions", col="blue")
abline(fit5,col="blue")
text(x= as.Date("2005",format="%Y") ,y= 8500 ,labels="R2 = 0.09\nP = 0.70",col="blue")
plot(year, mobileem, ylab="BLT mobile PM-2.5 Emissions [tons]",main="trend of BLT mobile pm-2.5 emissions",col="orange")
abline(fit4,col="orange")
text(x= as.Date("2005",format="%Y") ,y= 700 ,labels="R2 = 0.34\nP = 0.42",col="orange")
dev.off()
