library(testthat)
source("utils.R")

context("rule_02")

describe("rule_02", {
  rules <- read_rules('rule_02.txt')
  # transform values
  
  it("should work correctly on rule_02.csv", {
    data <- read_data("Rule_02.csv")
    #View(data)
    values <- confront(data, rules) %>% 
      values %>% 
      to_valid_invalid

    expect_equal(values, data$expected) # check against expected
  })
})


