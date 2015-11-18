library(dplyr)
library(validate)

DATADIR <- "../../../data"
RULEDIR <- ".."

read_data <- function(file_name, ...){
  data <- read.csv(file.path(DATADIR, file_name), ..., stringsAsFactors = FALSE, check.names = F)
  names(data) <- gsub("[ .-]", "_", names(data))
  data
}

read_rules <- function(file_name){
  validator(.file=file.path(RULEDIR, file_name))
}

to_valid_invalid <- function(values){
  values <- 
    values %>% 
    ifelse("valid", "invalid") %>% 
    as.character
  values[is.na(values)] <- "undecided"
  values
}