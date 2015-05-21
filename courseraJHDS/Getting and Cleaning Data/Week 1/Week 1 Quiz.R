#IDAHO housing data questions
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv","./IDhousing.csv")
df<-read.csv("IDhousing.csv")
nrow(df[which(df$VAL=="24" & df$RT=="H"),]) # how many records are properties with value > $1,000,000

#Natural Gas Acquisition
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx ","NGAP.xlsx",mode="wb",cacheOK=FALSE)
require("xlsx")
ri<-18:23
ci<-7:15
df2<-read.xlsx("./NGAP.xlsx",1,rowIndex=ri,colIndex=ci)
sum(df2$Zip*df2$Ext,na.rm=T)

#Baltimore Restaurants
library(XML)
doc<-xmlTreeParse("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",useInternalNodes=TRUE)
rootNode<-xmlRoot(doc)
xmlName(rootNode)
stuff<-xpathSApply(rootNode,"//zipcode",xmlValue)
ans<-stuff=="21231"
sum(ans)

#American Community Survey
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv","./ACS.csv")
library(data.table)
DT<-fread("ACS.csv")
