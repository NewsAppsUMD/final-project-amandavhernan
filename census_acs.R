# environment setup
install.packages("tidyverse")
install.packages("tidycensus")
install.packages("dplyr")
install.packages("purrr")
library(tidyverse)
library(tidycensus)
library(dplyr)
library(purrr)
options(tigris_use_cache = TRUE)

# api key
census_api_key("8b69f2765f65670c2183febdffce6afc73c72101", install=TRUE, overwrite=TRUE)
readRenviron("~/.Renviron")

# load acs data profiles
acs_dp_variables <- load_variables(2020, dataset = "acs5/profile", cache = TRUE)

# variables
censusvariables = c(population = "DP05_0001",
                    us_born = "DP02_0090",
                    foreign_born = "DP02_0094",
                    white = "DP05_0077",
                    black = "DP05_0078",
                    asian = "DP05_0080",
                    ai_an = "DP05_0079",
                    nh_pi = "DP05_0081",
                    hisp_latino = "DP05_0071",
                    other = "DP05_0082",
                    two_or_more = "DP05_0083",
                    median_age = "DP05_0018",
                    median_hh_income = "DP03_0062",
                    housing_units = "DP04_0001",
                    ho_occupied = "DP04_0080",
                    renter_occupied = "DP04_0047")

zctas <- get_acs(geography = "zcta",
                 output = 'wide',
                 year = 2020,
                 variables = censusvariables) %>% 
  select(GEOID, NAME, populationE, us_bornE, foreign_bornE, whiteE, blackE, asianE, ai_anE, nh_piE, hisp_latinoE, 
         otherE, two_or_moreE, median_ageE, median_hh_incomeE, housing_unitsE, ho_occupiedE, renter_occupiedE)

counties <- get_acs(geography = "county",
                 output = 'wide',
                 year = 2020,
                 variables = censusvariables) %>% 
  select(GEOID, NAME, populationE, us_bornE, foreign_bornE, whiteE, blackE, asianE, ai_anE, nh_piE, hisp_latinoE, 
         otherE, two_or_moreE, median_ageE, median_hh_incomeE, housing_unitsE, ho_occupiedE, renter_occupiedE)

states <- get_acs(geography = "state",
                 output = 'wide',
                 year = 2020,
                 variables = censusvariables) %>% 
  select(GEOID, NAME, populationE, us_bornE, foreign_bornE, whiteE, blackE, asianE, ai_anE, nh_piE, hisp_latinoE, 
         otherE, two_or_moreE, median_ageE, median_hh_incomeE, housing_unitsE, ho_occupiedE, renter_occupiedE)
