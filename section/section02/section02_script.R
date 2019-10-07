
# Load libraries ----------------------------------------------------------

library(dplyr)
library(magrittr)
library(readr)


# Load data ---------------------------------------------------------------

salary_all <- readr::read_delim("data/salary.txt", delim = " ")

# Subset for na data and complete data
salary_na <- salary_all %>% dplyr::filter(is.na(salary))
salary <- salary_all %>% dplyr::filter(!is.na(salary))


# Salary statistics -------------------------------------------------------

# Find the mean salary
mean_salary <- mean(salary$salary)

# What proportion of entries have a salary greater than the mean
greater_than_mean <- salary %>%
  dplyr::mutate(high_salary = dplyr::if_else(salary > mean(salary), 1, 0)) %>%
  dplyr::pull(high_salary) %>%
  sum() %>%
  magrittr::divide_by(nrow(salary))

# Find the earliest start year
min_start <- salary %>% dplyr::filter(startyr == min(startyr))
min_start_id <- unique(min_start$id)

# Salaries by rank
rank_salary <- salary %>%
  dplyr::filter(!is.na(rank)) %>%
  dplyr::group_by(rank) %>%
  dplyr::summarise(mean_salary = mean(salary)) %>%
  dplyr::arrange(mean_salary)

# Difference between ranks
rank_diff <- max(rank_salary$mean_salary) - min(rank_salary$mean_salary)
