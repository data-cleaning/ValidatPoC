# Notes

Notes and comments on translating `VTL` rules to `validate`

### rule 3

VTL:

- not sure why temp_id is needed in VTL statement
- it is rather indirect to add a measure with value 1 and sum that to count the number of rows

validate:

- used a tempory variable `counts` for readability. Substitution of `counts` in rule_03 gives same result.

### rule 10

VTL: 

- verbose

validate:

- used R stock function `any` testing for existence.


### rule 12

