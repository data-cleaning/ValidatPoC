library(testthat)
source("utils.R")

context("rule_03")

describe("rule_03", {
  rules <- read_rules('rule_03.txt')
  # transform values
  
  it("should work correctly on rule_03_valid.csv", {
    data <- read_data("Rule_03_valid.csv")
    #View(data)
    values <- confront(data, rules) %>% 
      values %>% 
      to_valid_invalid

    expect_equal(values, "valid") # check against expected
  })
  
  it("should work correctly on Rule_03_invalid.csv", {
    data <- read_data("Rule_03_invalid.csv")
    values <- confront(data, rules) %>% 
      values %>% 
      to_valid_invalid
    
    expect_equal(values, "invalid") # check against expected
  })

  it("should work correctly on Rule_03_invalid_with_missings.csv", {
    data <- read_data("Rule_03_invalid_with_missings.csv")
    values <- confront(data, rules) %>% 
      values %>% 
      to_valid_invalid
    
    expect_equal(values, "invalid") # check against expected
  })
  
})


