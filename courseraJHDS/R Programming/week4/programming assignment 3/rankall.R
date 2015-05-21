rankall <- function(outcome, num = "best") {
        ## Read outcome data
        data <- read.csv(file="outcome-of-care-measures.csv",colClasses = "character")
        
        ## Check that rank and outcome are valid
        
        states<-unique(data[,7])       
        
        if (outcome=="heart attack"){
                colind<-11
        }else if (outcome=="heart failure"){
                colind<-17
        }else if (outcome=="pneumonia"){
                colind<-23
        }else {stop("invalid outcome")}
        if (num != "best" & num != "worst" & suppressWarnings(as.numeric(num)!=round(as.numeric(num)))) stop("invalid rank")
        
        ## For each state, find the hospital of the given rank
        out<- NULL #initialize data frame for output
        for (i in 1:length(states)){
                state<-states[i]
                good.st<-data[data$State==state,]                                #select only obs for the given State
                good.st[,colind]<-suppressWarnings(as.numeric(good.st[,colind])) #convert mortality rate to numeric, supressing warnings about NA coercion
                bad<-is.na(good.st[,colind]) #identify NAs
                good<-good.st[!bad,]         #remove NAs
                colnames(good)[colind]<-"outcome"  #rename whichever outcome column selected to "outcome"
                good<-good[order(good$outcome,good$Hospital.Name),] #order the rows of state-specific by the selected outcome
                if (num=="best"){
                        st.out<-good[1,2] #return value for num==best
                }else if (num=="worst"){
                        worst<-nrow(good)
                        st.out<-good[as.integer(worst),2] #return value for num==worst
                }else {
                        if (as.integer(num) > as.integer(nrow(good))){
                                st.out<-NA  #return value for num > # reporting hospitals
                        }else {
                                st.out<-good[as.integer(num),2] #return value for specific ranking       
                        }
                        
                }
                out<-rbind(out,data.frame(st.out,state))
        }
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        colnames(out)<-c("hospital", "state")
        out[order(as.character(out$state)),]
        
        
        sum(14.1,20.0,14.4,5,3.5,10,12)
}