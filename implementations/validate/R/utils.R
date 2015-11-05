# utility functions to be included in validate

library(validate)
library(dplyr)

as.character.validator <- function(x, ...){
  expr <- sapply(x$rules, function(r){
    r@expr
  })
  
  names(expr) <- labels(x)
  ch <- sapply(expr, deparse)
  ch <- gsub("`:=`\\(([^,]+),(.+)\\)", "\\1 := \\2", ch)
  ch
}

as_txt <- function(x, ...){
  txt <- as.character(x)
  if (!is.null(nms <- names(x))){
    txt <- paste0("# ", nms, ":\n", txt)
  }
  paste0(txt, collapse = "\n\n")
}

# export rules to a free format
export_txt <- function(x, file, ...){
  txt <- as_txt(x)
  writeLines(txt, con = file, ...)
}

fix_names <- function(data){
  names(data) <- gsub("-", "_", names(data))
  data
}


# test 1,2,3
# v <- validator(x < 1, r2 = y == 2)
# v
# as_txt(v)
