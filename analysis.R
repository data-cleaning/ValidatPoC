# this script analyzes the line and character count for each implementation.
# 


library(reshape2)
library(RColorBrewer)
library(whisker)
library(stringr)

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

read_txt <- function(file){
  txt <- readLines(file,warn=FALSE)
  paste0(str_wrap(txt,indent=2),collapse="\n")
}


# return a latex one-pager with VTL, eStatistik and validate implementations
texpage <- function(){
"
\\subsubsection*{ {{{nr}}}: Natural language}
\\begin{quote}
{{{NL}}}
\\end{quote}
\\subsubsection*{The VTL implementation}
\\begin{verbatim}
{{{VTL}}}
\\end{verbatim}
\\subsubsection*{The eStatistik implementation}
\\begin{verbatim}
{{{eStatistik}}}
\\end{verbatim}
\\subsubsection*{The validate implementation.}
\\begin{verbatim}
{{{validate}}}
\\end{verbatim}
"
}



###############################################################################
# Read in the implementation data and do character counts

L <- list(
   eStatistik = dir("implementations/eStatistik/rules/",pattern = "Rule_[0-9]{2}.txt",full.names=TRUE)
  , VTL = dir("implementations/VTL/", pattern = "Rule_[0-9]{2}.txt",full.names=TRUE)
  , validate = dir("implementations/validate/",pattern="rule_[0-9]{2}.txt",full.names=TRUE)
)

# count characters, lines
M <- lapply(names(L), function(lang){
      files <- L[[lang]]
      A <- sapply(files, code_count , lang=lang)
      colnames(A) <- gsub("\\.txt","",tolower(basename(colnames(A))))
      t(A)
})
names(M) <- names(L)

# gather results in a list of data.frames
M <- lapply(names(M), function(lang){
  d <- as.data.frame(M[[lang]])
  d$lang <- lang
  d$rule <- sprintf("%02d",1:nrow(d))
  d
})

# order counts into a single result
out <- do.call(rbind,M)
out <- out[c(4,3,1,2)]
out <- out[order(out$rule),]
out$lang <- factor(out$lang,levels=c("VTL","eStatistik","validate"))

# write result to file.
write.csv(out,file="code_counts.csv")

###############################################################################
# Plot character counts


A <- reshape2::acast(data=out, formula = rule ~ lang, value.var="characters")

pal <- brewer.pal(n=3,"Dark2")

#pdf(file="barplot.pdf",width=8.5,height=5.5)
# barplot(t(prop.table(A[,c(3,1,2)],1)),horiz=TRUE,las=1
#         ,col=pal,ylab="rule no.",cex.axis=1.2,cex.lab=1.2
#         ,main="Relative nr of characters")
# par(xpd=TRUE)
# legend(x=0.3,y=24,legend=c("VTL","eStatistik","Validate"),fill=pal,horiz=TRUE,bty="n",cex=1.2)
#dev.off()


#pdf(file="boxplot.pdf",width=8.5,height=5.5)
# boxplot(characters ~ lang, data=out,las=1
#         , main="Number of characters"
#         ,cex.main=1.2,cex.lab=1.2,cex.axis=1.2)
#dev.off()

###############################################################################
# Get nat. lang descriptions and create TeX onepagers.

lines <- readLines("README.md")
I <- grep("```",lines)

beginverb <- I[c(TRUE,FALSE)]
endverb <- I[c(FALSE,TRUE)]
lines[beginverb] <- "\\begin{verbatim}"
lines[endverb] <- "\\end{verbatim}"

iverb <- unlist(lapply(seq_len(length(beginverb)),function(i) (beginverb[i]:endverb[i]) ))
verb <- logical(length(lines))
verb[iverb] <- TRUE

txt <- paste0(lines,collapse="\n")
txt <- strsplit(txt,"#####",fixed=TRUE)[[1]][-1]
rules <- str_extract(txt,".*?[0-9]{1,2}") 
txt[!verb] %<>% str_replace(".*?[0-9]{1,2}","") %>%     # remove rule number prefix
   str_replace_all("_(.*?)_","\\\\emph{\\1}") %>%       # emphasis
   str_replace_all("_","\\\\_") %>%                     # escape underscores
   str_replace_all("`(.*?)`","\\\\code{\\1}") %>%       # inline code
   str_replace_all("%","\\\\%")                         # percent 
  


txt <- gsub("\\[(.*?)\\]","\\1 ",txt)


tex <- vector(mode="character",length=18)
for ( i in 1:18 ){
  lng <-  list(
    nr = rules[i], 
    NL = txt[i]
    , VTL = read_txt(L$VTL[i])
    , eStatistik = read_txt(L$eStatistik[i])
    , validate = read_txt(L$validate[i])
  )
  tex[i] <- whisker.render(texpage(),data=lng)
  tex[i] <- gsub("\\n[[:blank:]]*?,","\n",tex[i])
}

texpages <- paste0(tex,collapse="\n\n\\newpage\n")
write(texpages,file="report/appendix.tex")





