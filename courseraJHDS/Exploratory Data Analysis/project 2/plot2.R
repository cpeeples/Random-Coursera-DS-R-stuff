## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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