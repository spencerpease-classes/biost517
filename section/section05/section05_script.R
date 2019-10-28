

# Load libraries ----------------------------------------------------------

library(dplyr)

# Prep data ---------------------------------------------------------------

inflam <- read.table("inflamm.txt", header = TRUE) %>%
  as_tibble() %>%
  select(smoker, death) %>%
  filter(!is.na(smoker))


# Get frequencies ---------------------------------------------------------

xtabs(~smoker+death, data = inflam)

freq_tbl <- inflam %>%
  group_by(smoker, death) %>%
  summarise(count = n(), prop = n() / nrow(inflam))


# Population estimates ----------------------------------------------------

p_hat <- freq_tbl[[4, 4]]

moe <- qnorm(.975) * sqrt(p_hat * (1 - p_hat) / nrow(inflam))
ci <- c("lower" = p_hat - moe, "upper" = p_hat + moe)


# Diff in proportion ------------------------------------------------------

p_smoke_death <- freq_tbl[[4, 4]]
p_non_death <- freq_tbl[[2, 4]]

n_smoke_death <- freq_tbl[[4, 3]]
n_non_death <- freq_tbl[[2, 3]]
