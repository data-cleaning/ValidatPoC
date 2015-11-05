# Notes

Notes and comments on translating `VTL` rules to `validate`

### rule 1

VTL:

- not sure why person-id is necessary

validate:

- Implemented as 1 rule to mimic the behavior of VTL a better implementation would
be to split the rule in two

```

```

### rule 3

VTL:

- not sure why temp_id is needed in VTL statement
- it is rather indirect to add a measure with value 1 and sum that to count the number of rows

validate:

- used a tempory variable `counts` for readability. Substitution of `counts` in rule_03 gives same result.

### rule 4

VTL: 

- I suspect that the `DS#price_t + DS#priceY-1 <= DS$priceY-1 * 0.5` contains an error. The `+` should be `-`
- it is not immediately clear what the second part mean, but suspect year - 1

validate: 

- It is better to split this rule into two rules. However I followed the VTL implementation of combining them into one rule.


### rule 5

VTL:

- Not sure why VTL needs to do a setdiff. I assume we need to detect which grandchild grand parent combination is invalid.

validate:

- Implemented join with R `match` function, could also have been done with `merge`, `dplyr::inner_join` etc.

### rule 7

VTL: 

- calculating means and counts is rather verbose
- statement can be somewhat simplified

validate:

- It is better two split rule into two parts, but kept for
- Used `length` for determining count/nrow

### rule 8

validate:

- is a bit unfair for VTL. In validate we specify during checking which columns 
are the identifying columns.

```R
confront(data, rule_08, list(person=person), key="person_id")
```

### rule 9

validate:

- the intention of the rule is to check if all ages are proper/allowed ages, so
used the R function `all`. An alternative implementation would have checked the `length` of allowed ages and all ages.

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