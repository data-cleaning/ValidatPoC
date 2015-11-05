source("./R/utils.R")

# rule 3

data <- read.csv("../../data/Rule_03_valid.csv")
rules  <- validator( 
  def_03 = counts := table(level),
  rule_03 = counts['high'] < 0.1 * sum(counts) 
)

export_txt(rules, "rule_03.txt")

# rule 10

data <- read.csv("../../data/Rule_10_valid.csv")
rules <- validator( rule_10 = any ( business_id == 100 & turnover > 1000000 ))

export_txt(rules, file = "rule_10.txt")
