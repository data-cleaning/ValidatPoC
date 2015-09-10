
set.seed(1)
out <- data.frame(
   level1 = sample(c("high","medium","low"), size=1000, replace=TRUE, prob=c(0.33,0.33,0.33))
 , level2 = sample(c("high","medium","low"), size=1000, replace=TRUE, prob=c(0.05,0.9,0.05))
 , level3 = sample(c("high","medium","low",NA), size=1000, replace=TRUE, prob=rep(0.25,4))
)

write.csv(out,file="data/Rule_03.csv",row.names=FALSE)

