# eurostat 1.2.13.9000

* The `get_eurostat()` can now get data also from the Eurostat JSON API via
  `get_eurostat_json()`. It also have a new argument `type` to select labels
  for vaiable values instead of codes.
* Fix an error after update to `tidyr 0.4.0` (#47).


# eurostat 1.2.13

* New `select_time` argument for `get_eurostat()` to select a time frequency 
  in case of multi-frequency datasets. Now the `get_eurostat()` also gives an
  error if you try to get multi-frequency with other time formats
  than `time_format = "raw"`. (#30) `time` column is also now in ascending
  order.
* `get_eurostat()` gets a new argument `compress_file` to control compression 
  of the cache file. Also cache filenames includes now all relevant arguments. (#28)
* For `search_eurostat()` a new type option `type = "all"` to search all types.
* For `label_eurostat()` new arguments. A `code` to retain also codes 
  for spesified colums. A `eu_order` to order facor levels in Eurostat order, 
  which uses the new function `dic_order()`. 
* Now `label_eurostat_vars(x)` gives labels for names, if x is other than
  a character or a factor and `label_eurostat_tables(x)` does not accept other
  than a character or a factor.
* For `get_eurostat()` a new argument `stringsAsFactors` to control the
  factor conversion of variables.
* `eurotime2date` (and `get_eurostat`) convers now also daily data. 

# eurostat 1.0.16

* Fixed vignette error

# eurostat 1.0.14 (2015-03-19)

* Package largely rewritten
* Vignette added
* Changed the value column to values in the get_eurostat output

# eurostat 0.9.1 (2014-04-24)

* Package collected from statfi and smarterpoland
