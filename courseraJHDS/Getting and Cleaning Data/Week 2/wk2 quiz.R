#Register with githup API
library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "afa1fe51197fb5ae7572",
                   secret = "0adb0955fd180c0473e00daea762117cb5db1553")
# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
# 4. Use API
gtoken <- config(token = github_token)
#req <- GET("https://api.github.com/rate_limit", gtoken)
#stop_for_status(req)
#content(req)
# OR:
#req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
#stop_for_status(req)
#content(req)

req <-with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
stuff<-content(req)

hm<-data.frame(t(sapply(stuff,c)))
names(hm)
hm[which(hm$name=="datasharing"),"created_at"]


#Question 2

#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv","./ACS.csv")
acs<-read.csv("../Week 1/ACS.csv")
library(sqldf)
sqldf("select pwgtp1 from acs where AGEP < 50")

#question 3
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")

#question 4
#library(httr)
con=url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode<-readLines(con)
nchar(htmlCode[c(10,20,30,100)])

#question 5

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for","./q5ds.dat")

df<-read.fwf("q5ds.dat",widths=c(11,-4,4,-1,3,-5,4,-1,3,-5,4,-1,3,-5,4,-1,3),header=F,skip=4)
sum(dv$V4)
