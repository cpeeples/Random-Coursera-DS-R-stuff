## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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