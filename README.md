# ValidatPoC
Rules and data for the PoC of the [ESSnet on Validation](http://www.cros-portal.eu/content/validat-foundation)



## The Rules
Below are descriptions of rules considered in the PoC. For implementation in the validation language of choice, translation is probably necessary. For each rule, there are one or more data sets in the `data` directory.

##### Rule 1

Number of hours per week usually worked should be between 1 and 80


##### Rule 2

cost + profit = turnover

##### Rule 3

Check whether the relative occurrence of the category `high` in a column containing values `low`, `high`, `medium` does not exceed 10%.

##### Rule 4

Price change between the current month and the previous month should not exceed 50% (taking the previous value as 100%). The same must hold for the price change between the current month and the same month last year.

##### Rule 5

Age of grandparents – 28 >= age of their grandchildren

##### Rule 6

If a product is out of season, the price and quantity must be the same as last month's values.

##### Rule 7

The price change of a single item may not influence the change in the mean prices by more than 10\%, upwards or downwards.

Explanation in detail. Let `m(t)` denote the mean price at time `t` and `m(t-1)` the mean time at time `t-1`.
The change in mean prices is given by `d(t,t-1) = abs(m(t) - m(t-1))`. Also define `m(t,i)`, which is the
mean price at time `t`, but the price of the `i`th item is set equal to the price at time `t-1`. Accordingly, we write `d(t,t-1,i) = abs(m(t,i)-m(t-1))`. The rule now states that
```
0.9 <= d(t,t-1,i)/d(t,t-1) <= 1.1
```



##### Rule 8

Year of birth in household questionnaire must equal year of birth in individual questionnaire

##### Rule 9

The `forall` quantifyer signifies that the rule is satisfied for a data set when _all_ records satisfy the rule.

```
forall x: x.age >= 0 AND x.age <= 113
```

##### Rule 10

```
exists x: x.business-id = 100 AND x.turnover > 1.000.000
```

##### Rule 11

The `exists!` quantifier signifies 'there exists exactly one'.

```
exists! x: x.business-id = 100 AND x.turnover > 1.000.000
```

##### Rule 12

```
forall x: 
  IF x.relation_to_head = 4 
  THEN exists y:
    x.spouse-id = y.person-id AND y.relation_to_head = 3
```

##### Rule 13

The combination of sex and age group in the data set is unique, i.e., there do not exist two distinct records in
the data set with an identical combination of values for sex and age group.

- sex groups: `male`, `female`
- age groups: `child`, `adult`, `senior` 


##### Rule 14

Every combination of sex and age group occurs at least once in the data set.

- sex groups: `male`, `female`
- age groups: `child`, `adult`, `senior` 

##### Rule 15

If two records have the same postal code, they must have the same value for `city`. Below, this is expressed
as a [functional dependency](https://en.wikipedia.org/wiki/Functional_dependency)

```
postal_code --> city
```
##### Rule 16

The following is a check on hierarchical aggreggation.

```
forall k >= 1: w(x1. ... .xk) equals the sum of
w(x1. ... .xk.i) forall i >= 0
```

##### Rule 17

The value for no_of_household_members must equal the number of records for each household

##### Rule 18
This last one is a bit complicated. It involves two files, one with households (`x`) and one with persons data (`y`). In the household file, it is registered how many members there are, say 3. It is then expected that
there are persons with `person-id` 1,2,3 in the file `y`. The rule is satisfied if for all households, all person-id's can be found, and the id's have the correct values.

```
forall x: forall n:
  IF 1 <= n <= x.no_of_household_members
  THEN exists y: 
    x.household-id = y.household-id AND y.person-id = n
```
