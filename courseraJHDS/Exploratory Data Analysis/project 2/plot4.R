## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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
