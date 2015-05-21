rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        data <- read.csv(file="outcome-of-care-measures.csv",colClasses = "character")
        
        ## Check that state and outcome are valid
        iv.state <- state == data[,7]  ##compare to the states in col 7 of the data frame
        if (sum(iv.state)==0) {stop("invalid state")}
        if (outcome=="heart attack"){
                colind<-11
        }else if (outcome=="heart failure"){
                colind<-17
        }else if (outcome=="pneumonia"){
                colind<-23
        }else {stop("invalid outcome")}
        if (num != "best" & num != "worst" & suppressWarnings(as.numeric(num)!=round(as.numeric(num)))) stop("invalid rank")
        
        ## Return hospital name in that state with the given rank
        good.st<-data[data$State==state,]                                #select only obs for the given State
        good.st[,colind]<-suppressWarnings(as.numeric(good.st[,colind])) #convert mortality rate to numeric, supressing warnings about NA coercion
        bad<-is.na(good.st[,colind]) #identify NAs
        good<-good.st[!bad,]         #remove NAs
        colnames(good)[colind]<-"outcome"  #rename whichever outcome column selected to "outcome"
        good<-good[order(good$outcome,good$Hospital.Name),] #order the rows of state-specific by the selected outcome
        if (num=="best"){
                good[1,2] #return value for num==best
        }else if (num=="worst"){
                worst<-nrow(good)
                good[as.integer(worst),2] #return value for num==worst
        }else {
                if (as.integer(num) > as.integer(nrow(good))){
                        NA  #return value for num > # reporting hospitals
                }else {
                        good[as.integer(num),2] #return value for specific ranking       
                }
                        
        }
        
        ## 30-day death rate
}