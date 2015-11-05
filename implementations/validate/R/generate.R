source("./R/utils.R")
# generate rule descriptions from source


# rule 1
rules <- validator(
  rule_01 = hours_worked >= 1 & hours_worked <= 80
)
export_txt(rules, "rule_01.txt")

# rule 2
rules <- validator(
  rule_02 = cost + profit == turnover
)
export_txt(rules, "rule_02.txt")


# rule 3
rules  <- validator( 
  def_03 = counts := table(level),
  rule_03 = counts['high'] < 0.1 * sum(counts) 
)
export_txt(rules, "rule_03.txt")

#rule 4
rules <- validator(
  rule_04 = (price_t - price_tmin1) <= 0.5*price_tmin1 &
            (price_t + price_Ymin1) <= 0.5*price_Ymin1
)
export_txt(rules, file="rule_04.txt")

#rule 5
rules <- validator( def_age_gp = age_gp := age[match(grandchild_of, person_id)]
                  , rule_04 = age_gp - 28 >= age
                  )
export_txt(rules, file="rule_05.txt")

#rule 6
rules <- validator(
  rule_06 = if(season == "out") price_t == price_tmin1 && 
    quantity_t == quantity_tmin1
  )
export_txt(rules, file='rule_06.txt')

# rule 7
rules <- validator(
  def_mean_diff = mean_diff := mean(price_t) - mean(price_tm1),
  def_ratio     = ratio := abs(mean_diff + (price_tm1 - price_t)/length(price_t)/mean_diff),
  rule_07 = ratio >= 0.9 && ratio <= 1.1
)
export_txt(rules, file='rule_07.txt')

# rule 8
rules <- validator(
  rule_08 = person_id == person$person_id
)
export_txt(rules, file='rule_08.txt')

# rule 9
rules <- validator(
  rule_09 = all(age >=0  && age <= 113)
)
export_txt(rules, file='rule_09.txt')


# rule 10
rules <- validator( rule_10 = any ( business_id == 100 & turnover > 1000000 ))
export_txt(rules, file = "rule_10.txt")

# rule 11 
rules <- validator( rule_11 = sum( business_id == 100 & turnover > 1000000 ) == 1)
export_txt(rules, file = "rule_11.txt")

# rule 12
rules <- validator(
  def_rel_4 = rel_4 := person_id[relation_to_head == 4],
  def_rel_3 = spouse_of_rel_3 := spouse[relation_to_head == 3],
  rule_12 = all(rel_4 %in% spouse_of_rel_3)
)
export_txt(rules, file = "rule_12.txt")

# rule 13
rules <- validator( 
  def_counts = counts := table(gender, age_group),
  rule_13 = counts <= 1
)
export_txt(rules, file = "rule_13.txt")


# rule 14
rules <- validator(
  def_counts    = counts := table(gender, age_group),
  rule_gender   = gender %in% c('male','female'),
  rule_ag       = age_group %in% c('child', 'adult', 'senior'),
  rule_complete = counts == 1 && sum(counts) == 6
)
export_txt(rules, file="rule_14.txt")


# rule 15
rules <- validator(
  rule_15 = postcode ~ city
)
export_txt(rules, file="rule_15.txt")


# rule 16
data <- read.csv("../../data/Rule_16_valid.csv")

rules <- validator(
  def_parent    = with_parent := sub("\\.?\\d+$", "", level),
  def_is_parent = is_parent := level %in% with_parent,
  def_par_lev   = parent_levels := level[is_parent],
  def_childsum  = childsum := tapply(weight, with_parent, sum),
  rule_16      = weight[is_parent] == childsum[parent_levels]
)
export_txt(rules, "rule_16.txt")


#rule 17
rules <- validator(
  def_count = person_count := table(person$household_id),
  rule17 = members == person_count[household_id]
)
export_txt(rules, "rule_17.txt")
