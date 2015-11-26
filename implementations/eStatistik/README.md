In this folder, implementations and results for the eStatistik software will be collected. Rules are provided
in the original version and in an English version to improve their accessibility to a wider community. For more
details please consult the respective sub-folder.

For a better understanding of the implementation, please consider the following specifics of the eSTATISTIK
data validation and editing tools and infrastructure:

* Elements of the specification language roughly fall into the four categories described below. This distinction
  is very important since the categories correspond to named programmatic objects that are edited and managed
  separately but have some coding an runtime interdependencies.
  
  The four categories are:
  
  1. *Procedures* serve to control the execution path of validation rules and automated edits, or in other words,
     to create and execute validation flows. Procedures can use the full instruction set of the specification
     language. Procedures can invoke *other* procedures conditionally as well as unconditionally, so that validation
     flows can be scoped and designed as building blocks, providing a means for modularisation and composition of
     data validation flows.
  2. *Checks* (a.k.a. *validation rules*) contain instructions for validating one or more columns/fields of the
     (hierarchical set of) record(s) currently in scope. Checks can only be invoked from procedures and have a very
     limited instruction set. They return `TRUE` if, and only if they encounter an error, otherwise `FALSE`. Only
     checks are evaluated for compiling validation statistics or metrics.
  3. *Edits* are only invoked implicitly by checks that encounter an error (hard check). There is no instruction
     for invoking edits explicitly. An edit rule is therefore always bound to exactly one check and also has a very
     limited instruction set.
  4. *Functions* provide a way for creating re-usable units of code. Functions dispose of the full instructions set
     expect that checks cannot be invoked from functions. Functions can be invoked everywhere and recursively.
  
  Files that serve as procedures have `control`` in their file name, while all other `.txt` files represent simple
  validation rules.
  
* In the execution environment *Data Edit Runtime* (DER), programmatic objects such as validation rules, reference
  data and other *resources* are bound to a *survey* node. Different versions of one resource can exist. A survey is
  associated with one or more *reference periods*. Reference periods serve to associate the data to be validated with
  (a version of) the resources used to perform the validation. For a given reference period, exactly one data set
  under validation can exist.
  
* During execution of a validation flow, only the current record or the current set of hierarchical records (such
  as household and associated person records) of the data set under validation is visible and can be read and write
  accessed. Iterating over a complete data set is only possible in procedures and functions and if the data set
  is defined as reference data.
  
* The data used in the PoC provide some cases in which validation cannot be performed due to missing data. Those
  cases are recognisable by the value `undecided` in the column `expected` or in the data set name (where the full
  data set is validated), respectively. The idea behind this is to find out how systems differ in handling missing
  values. In eSTATISTIK, after executing a validation rule, the associated data are always considered validated,
  because validation rules only return `TRUE` or `FALSE`. Any precondition that may lead to a validation rule not
  being executed must be checked outside the rule, that is, in a procedure.
  
  Rule_01 exemplifies this restriction. `Rule_01.txt` contains the rule for validating the column `hours_worked`
  and is configured as a hard check (this configuration takes place in the rule editor). `Rule_01.undecided.txt`
  only checks if `hours_worked` is empty and represents a soft check. The procedure `Rule_01_control.txt` combines
  these checks, invoking `Rule_01.txt` only if `Rule_01.undecided.txt` returns `FALSE`, in which case `hours_worked`
  is not empty. In this way, a soft error will be registered and displayed is the value is missing, and a hard error
  ist a value is present but not within the valid range.
  