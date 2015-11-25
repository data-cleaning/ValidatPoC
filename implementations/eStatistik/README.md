In this folder, implementations and results for the eStatistik software will be collected. Rules are provided
in the original version and in an English version to improve their accessibility to a wider community. For more
details please consult the respective sub-folder.

For a better understanding of the implementation, please consider the following specifics of the eSTATISTIK
data validation and editing tools and infrastructure:

* Elements of the specification language roughly fall into the four categories described below. This distinction
  is very important since the categories correspond to named programmatic objects that are edited and managed
  separately but have some interdependencies.
  
  The four categories are:
  
  1. *Controls* serve to control the execution path of validation rules and automated edits, or in other words,
     to create and execute validation flows. Controls can use the full instruction set of the specification language.
     Controls can invoke controls conditionally as well as unconditionally, so that validation flows can be scoped and
     designed as building blocks, allowing for modularisation and composition of data validation flows.
  2. *Checks* (a.k.a. *validation rules*) contain instructions for validating one or more columns/fields of the
     (hierarchical set of) record(s) currently in scope. Checks can only be invoked from controls and have a very
     limited instruction set. They return `TRUE` if, and only if they encounter an error, otherwise `FALSE`. Only
     checks are evaluated for compiling validation statistics or metrics.
  3. *Edits* are only invoked implicitly by checks that encounter an error (hard check). There is no instruction
     for invoking edits explicitly. An edit rule is therefore always bound to exactly one check and also has a very
     limited instruction set.
  4. *Functions* provide a way for creating re-usable units of code. Functions dispose of the full instructions set
     expect that checks cannot be invoked from functions. Functions can be invoked everywhere and recursively.

* In the execution environment *Data Edit Runtime* (DER), validation rules and other programmatic objects, reference
  data and other *resources* are bound to a *survey* node. Different versions of one resource can exist. A survey is
  associated with one or more *reference periods*. Reference periods serve to associate the data to be validated with
  (a version of) the resources used to perform the validation that are in turn associated with the parent survey.
  For a given reference period, exactly one data set under validation can exist.
  
* During execution of a validation flow, only the current record or the current set of hierarchical records (such
  as household and associated person records) of the data set under validation is visible and can be read and write
  accessed. Iterating over a complete data set is only possible in controls and functions and if the data set
  is defined as reference data.

  