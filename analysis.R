# this script analyzes the line and character count for each implementation.
# 


## Define some utility functions ----

remove_comments <- function(x,lang=c("VTL","eStatistik","validate")){
  lang = match.arg(lang) 
  rx <- switch(lang
    , "VTL" = "/\\*.*\\*/" 
    , "eStatistik" = '".*"'
    , "validate" = "#.*$"
  )  
  gsub(rx,"",x)
}

remove_empty_lines <- function(x){
  y <- gsub("[[:blank:]]+","",x)
  x[nchar(y) > 0]
}

remove_trailing_white <- function(x){
  gsub("[[:blank:]]+$","",x)
}

# Count number of lines and number of characters
code_count <- function(file,lang){
  require(magrittr)
  lines <- readLines(file,warn=FALSE)
  # clean up
  lines %<>% 
    remove_comments(lang) %>%
    remove_trailing_white() %>%
    remove_empty_lines()
  # return line- and character count
  c(lines=length(lines), characters=sum(nchar(lines)))
}







## ----

# RESULTS 

L <- list(
   eStatistik = dir("implementations/eStatistik/rules/",pattern = "Rule_[0-9]{2}.txt",full.names=TRUE)
  , VTL = dir("implementations/VTL/", pattern = "Rule_[0-9]{2}.txt",full.names=TRUE)
  , validate = dir("implementations/validate/",pattern="rule_[0-9]{2}.txt",full.names=TRUE)
)

M <- lapply(names(L), function(lang){
      files <- L[[lang]]
      A <- sapply(files, code_count , lang=lang)
      colnames(A) <- gsub("\\.txt","",tolower(basename(colnames(A))))
      t(A)
})
names(M) <- names(L)

M <- lapply(names(M), function(lang){
  d <- as.data.frame(M[[lang]])
  d$lang <- lang
  d$rule <- sprintf("%02d",1:nrow(d))
  d
})

out <- do.call(rbind,M)
out <- out[c(4,3,1,2)]
out <- out[order(out$rule),]

# write result to file.
write.csv(out,file="code_counts.csv")

library(ggplot2)
qplot(data=out, x=rule,y=characters, geom="bar",stat="identity",facets=~lang)


library(reshape2)
pdf(file="barplot.pdf",width=8.5,height=5.5)
A <- reshape2::acast(data=out, formula = rule ~ lang, value.var="characters")
barplot(t(prop.table(A,1)),horiz=TRUE,las=1,legend.text=TRUE)
dev.off()

plot(A[,1],type='step')
lines(A[,2],col='red',type='step')
lines(A[,3],col='green',type='step')

  pdf(file="boxplot.pdf",width=8.5,height=5.5)
  boxplot(characters ~ lang, data=dat,las=1
          , main="Number of characters"
          ,cex.main=1.2,cex.lab=1.2,cex.axis=1.2)
  dev.off()




