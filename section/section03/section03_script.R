
# Load libraries ----------------------------------------------------------

library(dplyr)
library(readr)
library(ggplot2)


# Load data ---------------------------------------------------------------

crab <- read_delim("data/crab.txt", delim = " ")
salary <- read_delim("data/salary.txt", delim = " ")


# Look at crabs -----------------------------------------------------------

sat_v_width <- crab %>%
  ggplot(aes(x = width, y = n.satellites, color = width > 26)) +
  geom_point()

sat_v_width

width_dist <- crab %>%
  ggplot(aes(x = width, color = color, fill = color)) +
  geom_density(alpha = .3)

width_dist


# Look at salary ----------------------------------------------------------

salary_by_gender <- salary %>%
  ggplot(aes(x = gender, y = salary)) +
  geom_boxplot()

salary_by_gender

salary_by_rank <- salary %>%
  filter(!is.na(rank)) %>%
  ggplot(aes(x = rank, y = salary)) +
  geom_boxplot()

salary_by_rank

salary_by_gender_rank <- salary %>%
  filter(!is.na(rank)) %>%
  ggplot(aes(x = gender, y = salary)) +
  geom_boxplot(varwidth = TRUE) +
  facet_wrap(vars(rank))

salary_by_gender_rank
