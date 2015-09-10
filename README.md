# ValidatPoC
Rules and data for the PoC of the [ESSnet on Validation](http://www.cros-portal.eu/content/validat-foundation)

Below are descriptions of rules considered in the PoC. For implementation in the validation language of choice, translation is probably necessary. For each rule, there is one or more data sets in the `data` directory.

##### Rule 1

Number of hours per week usually worked should be between 1 and 80

```
hours_worked >= 1
hours_worked <= 80
```

##### Rule 2

```
cost + profit == turnover
```

##### Rule 3

Check whether the relative occurrence of the category `high` in a column containing values `low`, `high`, `medium` does not exceed 10%.

##### Rule 4

Price change between current month and the same month last year does not exceed 50% (taking the previous value as 100%)

##### Rule 5

Age of grandparents – 28 >= age of their grandchildren

##### Rule 6
_If product is out of season (=0), then variable F = 1 and then entry of the current month (prices, quantity) has to be equal to the entry of last month (no change is allowed)_

Symbolic:
```
if ( in_season == 0 ) price_t == price_tm1
```

##### Rule 7

The price change of a single item may not influence the change in the mean prices by more than 10\%, upwards or downwards.

















