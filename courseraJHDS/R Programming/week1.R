
dataf<-read.csv(file="hw1_data.csv")
names(dataf)
dataf[1:2,]
nrow(dataf)
dataf[152:153,]
dataf[47,]
bad<-is.na(dataf$Ozone)
mean(bad)*nrow(dataf)
good<-dataf[!bad,]
mean(good$Ozone)
htho<-good[good$Ozone>31 & good$Temp>90,]
mean(htho$Solar.R)
june<-dataf[dataf$Month==6,]
mean(june$Temp)
may<-dataf[dataf$Month==5,]
max(may$Ozone)
