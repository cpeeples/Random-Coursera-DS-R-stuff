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