#Question 2
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)


#question 7
library(datasets)
data(airquality)
require(ggplot2)
#qplot(Wind, Ozone, data = airquality)
#qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))
airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)
#qplot(Wind, Ozone, data = airquality, geom = "smooth")

#question 10
qplot(votes, rating, data = movies)
qplot(votes, rating, data = movies) + geom_smooth()
#qplot(votes, rating, data = movies) + stats_smooth("loess")
#qplot(votes, rating, data = movies, panel = panel.loess)
#qplot(votes, rating, data = movies, smooth = "loess")
