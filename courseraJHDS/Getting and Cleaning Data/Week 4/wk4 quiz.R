#question 1
df<-read.csv("../Week 1/IDhousing.csv")
ans<-strsplit(names(df),"wgtp")

#question 2
df1<-read.csv(file="../Week 3/GDP.csv",skip=3,header=TRUE,as.is=TRUE,strip.white=TRUE)


uncommaed<-gsub(",","",df1$US.dollars.)

df1$US.dollars.<-uncommaed
mean(as.integer(df1$US.dollars.[2:191]),rm.na=T)


#question 3
grep("^United",df1$Economy[2:191])

#question 4
df2<-read.csv(file="../Week 3/FEDSTATS.csv",as.is=TRUE,strip.white=TRUE)
dfx<-df1[df1$Ranking!="",]
df3<-merge(df2,dfx,by.x="CountryCode",by.y="X")
fys<-grepl("*Fiscal year end: June*",df3$Special.Notes)
sum(fys)

#question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
names(amzn)
names(sampleTimes)
twytwvs<-grepl("^2012",sampleTimes)
sum(twytwvs)
twytwvdays<-weekdays(sampleTimes[twytwvs])
sum(grepl("Monday",twytwvdays))
