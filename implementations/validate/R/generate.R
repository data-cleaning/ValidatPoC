source("./R/utils.R")

# generate rule descriptions from source

# rule 3

data <- read.csv("../../data/Rule_03_valid.csv")
rules  <- validator( 
  def_03 = counts := table(level),
  rule_03 = counts['high'] < 0.1 * sum(counts) 
)

export_txt(rules, "rule_03.txt")

# rule 10

data <- read.csv("../../data/Rule_10_valid.csv", check.names = F) %>% 
  fix_names
rules <- validator( rule_10 = any ( business_id == 100 & turnover > 1000000 ))

export_txt(rules, file = "rule_10.txt")


# rule 12

rules <- validator(
  def_person_rel_4 = person_rel_4 := person_id[relation_to_head == 4],
  def_spouse_3     = spouse_3 := subset(person, relation_to_head == 3),
  rule_12 = all(person_rel_4 %in% spouse_3$spouse_id)
)

export_txt(rules, file = "rule_12.txt")

