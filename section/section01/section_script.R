
# Load libraries ----------------------------------------------------------

library(magrittr)
library(dplyr)
library(readr)

# Load data ---------------------------------------------------------------

mammals <- readr::read_csv("data/mammals.csv")
crab <- readr::read_delim("data/crab.txt", delim = " ")
crab2 <- readr::read_csv("data/othercrab.csv")


# Questions ---------------------------------------------------------------

# a) What is the mean number of satellites among all 173 female crabs?

mean_satellites <- mean(crab$n.satellites)


# b) What is the mean number of satellites among female crabs whose width is
#    <26cm?

mean_sat_small <- crab %>%
  dplyr::filter(width < 26) %>%
  magrittr::extract2("n.satellites") %>%
  mean()


# c) What is the mean number of satellites among female crabs whose width is
#    >= 26 cm?

mean_sat_large <- crab %>%
  dplyr::filter(width >= 26) %>%
  magrittr::extract2("n.satellites") %>%
  mean()


# Provide counts of each of the crab colors for:
#    i.	All the crabs
#   ii.	Those with width < 26cm
#  iii.	Those with width  >=26cm?

color_counts_sep <- crab %>%
  dplyr::mutate(width_under_26 = width < 26) %>%
  dplyr::group_by(width_under_26, color) %>%
  dplyr::summarise(count = n())

color_counts_comb <- color_counts_sep %>%
  dplyr::ungroup() %>%
  dplyr::group_by(color) %>%
  dplyr::summarise(count = sum(count))
