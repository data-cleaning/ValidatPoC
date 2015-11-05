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

- a bit verbose

validate:

- used R stock function `any` testing for existence.


### rule 12

VTL:

- verbose and not very readable.


validate:

- Made the following interpretation: all persons with rel_to_head equal to 4
must be avaiable as a spouse for persons with rel_to_head equal to 3.
- implemented it with plain R
- alternative and more modern implemention could use:

     * `merge`
     * `dplyr::semi_join`, `dplyr::anti_join` or `dplyr::left_join`