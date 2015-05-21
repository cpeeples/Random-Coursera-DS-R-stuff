best <- function(state,outcome){
        ##read outcome data
        data <- read.csv(file="outcome-of-care-measures.csv",colClasses = "character")
        
        ##check that state and outcome are valid
        iv.state <- state == data[,7]  ##compare to the states in col 7 of the data frame
        if (sum(iv.state)==0) {stop("invalid state")}
        if (outcome=="heart attack"){
                colind<-11
        }else if (outcome=="heart failure"){
                colind<-17
        }else if (outcome=="pneumonia"){
                colind<-23
        }else {stop("invalid outcome")}
        
        ##Return hospital name in that state with lowest 30-day death rate
        good.st<-data[data$State==state,]                                #select only obs for the given State
        good.st[,colind]<-suppressWarnings(as.numeric(good.st[,colind])) #convert mortality rate to numeric, supressing warnings about NA coercion
        bad<-is.na(good.st[,colind]) #identify NAs
        good<-good.st[!bad,]         #remove NAs
        lowest<-min(good[,colind])   #get the minimum mortality rate
        ans<-good[,colind]==lowest   #identify observations with minimum mort. rate
        min(good[ans,2])                  #return name of hospitals with minimum mort. rate, ties broken alphabetically by min() function

}

if outcome==heartattack
column<-data[data$State==state & !is.na(data$heartattack),data$heartattack]
else if outcome==pneumonia
data$Hospital.Name
data[,"Hospital.Name"]