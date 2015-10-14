
set.seed(1)
out <- data.frame(
   level = sample(c("high","medium","low"), size=1000, replace=TRUE, prob=c(0.33,0.33,0.33))
)

write.csv(out,file="data/Rule_03_invalid.csv",row.names=FALSE)


out <- data.frame(
   level = sample(c("high","medium","low"), size=1000, replace=TRUE, prob=c(0.05,0.9,0.05))
)

write.csv(out,file="data/Rule_03_valid.csv",row.names=FALSE)

out <- data.frame(
  level = sample(c("high","medium","low",NA), size=1000, replace=TRUE, prob=rep(0.25,4))
)

write.csv(out,file="data/Rule_03_invalid_with_missings.csv",row.names=FALSE)

