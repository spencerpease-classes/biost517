gen_ppv <- function(sens, spec, prev) {
  (sens * prev) / ((sens * prev) + ((1 - spec) * (1 - prev)))
}

gen_npv <- function(sens, spec, prev) {
  (spec * (1 - prev)) / ((spec * (1 - prev)) + ((1 - sens) * prev))
}
