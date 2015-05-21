library(datasets)
data(iris)

tapply(iris$Sepal.Length,iris$Species,mean) #Q1

apply(iris[,1:4],2,mean) #Q2

data(mtcars)

tapply(mtcars$mpg,mtcars$cyl,mean)

tapply(mtcars$hp,mtcars$cyl,mean)
