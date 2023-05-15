# environment setup
install.packages("tidyverse")
install.packages("tidycensus")
install.packages("dplyr")
install.packages("purrr")
install.packages("stringr")
library(tidyverse)
library(tidycensus)
library(dplyr)
library(purrr)
library(stringr)
options(tigris_use_cache = TRUE)

# load clean datasets
counties_pfas <- read_csv("data/census/known_sites_counties_w_pop.csv")
states_pfas <- read_csv("data/census/known_sites_states_w_pop.csv")
zctas_pfas <- read_csv("data/census/known_sites_zctas_w_pop.csv")

# number of pfas sites by county, state, and zip
num_pfas_co <- counties_pfas %>%
  group_by(county) %>%
  summarize(num_sites = n()) %>%
  arrange(desc(num_sites))

num_pfas_st <- states_pfas %>%
  group_by(state_abv) %>%
  summarize(num_sites = n()) %>%
  arrange(desc(num_sites))

num_pfas_zip <- zctas_pfas %>%
  group_by(zip) %>%
  summarize(num_sites = n()) %>%
  arrange(desc(num_sites))

# view tables
num_pfas_co
num_pfas_st
num_pfas_zip

# median total pfas levels by county, state, and zip
median_pfas_co <- counties_pfas %>%
  group_by(county) %>%
  summarize(median_pfas_level = median(total_pfas, na.rm = TRUE)) %>%
  arrange(desc(median_pfas_level))

median_pfas_st <- states_pfas %>%
  group_by(state_abv) %>%
  summarize(median_pfas_level = median(total_pfas, na.rm = TRUE)) %>%
  arrange(desc(median_pfas_level))

median_pfas_zip <- zctas_pfas %>%
  group_by(zip) %>%
  summarize(median_pfas_level = median(total_pfas, na.rm = TRUE)) %>%
  arrange(desc(median_pfas_level))

# view tables
median_pfas_co
median_pfas_st
median_pfas_zip

# calculate the pct of each racial/ethnic group (zip)
zctas_pfas_w_pcts <- zctas_pfas %>%
  mutate(white_pct = whiteE / populationE * 100,
         black_pct = blackE / populationE * 100,
         asian_pct = asianE / populationE * 100,
         ai_an_pct = ai_anE / populationE * 100,
         nh_pi_pct = nh_piE / populationE * 100,
         hisp_latino_pct = hisp_latinoE / populationE * 100,
         other_pct = otherE / populationE * 100,
         two_or_more_pct = two_or_moreE / populationE * 100) %>%
  mutate(majority_race = if_else(white_pct >= 50, "Majority white", "Majority non-white"))

# counts (non-white, white)
zctas_race_summary <- zctas_pfas_w_pcts %>%
  group_by(majority_race) %>%
  summarize(num_zipcodes = n())

zctas_race_summary

# median household income
zctas_pfas <- zctas_pfas %>%
  mutate(hh_income_category = case_when(
    median_hh_incomeE < 50000 ~ "Less than $50,000",
    median_hh_incomeE >= 50000 & median_hh_incomeE < 100000 ~ "Between $50,000 and $100,000",
    median_hh_incomeE >= 100000 ~ "More than $100,000",
    TRUE ~ NA_character_
  ))

zctas_income_summary <- zctas_pfas %>%
  group_by(hh_income_category) %>%
  summarize(num_zipcodes = n())

zctas_income_summary