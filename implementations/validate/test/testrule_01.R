library(testthat)
source("utils.R")

context("rule_01")

describe("rule_01", {
  rules <- read_rules('rule_01.txt')
  # transform values
  
  it("should work correctly on rule_01.csv", {
    data <- read_data("Rule_01.csv")
    
    values <- confront(data, rules) %>% 
      values %>% 
      to_valid_invalid
    
    expect_equal(values, data$expected) # check against expected
  })
})


