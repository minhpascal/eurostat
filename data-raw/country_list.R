
# Code to get countries and their codes for selected country groups.

library(rvest)
library(dplyr)

country_html <- html("http://ec.europa.eu/eurostat/statistics-explained/index.php/Tutorial:Country_codes_and_protocol_order")
c_tables<- country_html %>%
  html_table()

# Country data.tables with code and name
eu_countries <- c_tables[[2]] %>% 
  select(code = Code, name = English)

efta_countries <- c_tables[[3]] %>% 
  select(code = Code, name = English)

candidate_countries <- c_tables[[4]] %>% 
  select(code = Code, name = English)

# Euro area countries
ea_country_html <- html("http://ec.europa.eu/eurostat/statistics-explained/index.php/Glossary:Euro_area")

ea_countries <- ea_country_html %>%
  html_table(fill = TRUE) %>% 
  unlist() %>% 
  {data_frame(name = grep("^[[:alpha:]]", ., value = TRUE))} %>% 
  inner_join(eu_countries, .)                    # Get eu order and codes
  

# save 

devtools::use_data(eu_countries, ea_countries, efta_countries, candidate_countries)
