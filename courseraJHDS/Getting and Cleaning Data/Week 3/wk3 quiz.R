#question 1 using one of the data files from wk 1 quiz.
df<-read.csv("../Week 1/IDhousing.csv")
logical_answer<-df$ACR==3 & df$AGS==6
head(which(logical_answer))

#question 2 
library(jpeg)
library(RCurl)
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))) #enables SSL
jeff<-readJPEG(getBinaryURL("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"),TRUE) 
quantile(jeff,probs=c(0.3,0.8))

#question 3

download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv","./GDP.csv")
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv","./FEDSTATS.csv")
df1<-read.csv(file="GDP.csv",skip=3,header=TRUE,as.is=TRUE,strip.white=TRUE)
df2<-read.csv(file="FEDSTATS.csv",as.is=TRUE,strip.white=TRUE)
library(plyr)
dfx<-df1[df1$Ranking!="",]
df3<-merge(df2,dfx,by.x="CountryCode",by.y="X")
dfs<-df3[order(as.integer(df3$Ranking),decreasing=TRUE),]
dfs[13,]

#question 4
tapply(as.integer(dfs$Ranking),dfs$Income.Group,mean)

#question 5
dfsm<-mutate(dfs,IncQ=cut(as.integer(dfs$Ranking),quantile(as.integer(dfs$Ranking),probs=c(0.0,0.2,0.4,0.6,0.8,1.0)),include.lowest=T,right=F,labels=FALSE))
table(dfsm[,41])
table(dfsm[,41],dfsm$Income.Group)
