Rule_03.csv contains three columns, all with a similar categorical variable
that can take the values in `{"low", "medium", "high"}`

All have to satisfy the rule that `"high"` occurs in less than 10% of the cases.

- the first column (level1) violates the rule.
- the second column (level2) satisfies the rule.
- the third column (level3) contains missing data.

See src/generate_rule_03.R for an Rscript that generates the data reproducibly.


