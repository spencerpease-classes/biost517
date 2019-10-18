standard_error <- function(x) {
  x <- na.omit(x)
  sd(x) / sqrt(length(x))
}

confidence_interval <- function(x, alpha = .95) {

  z_score <- qnorm((alpha + 1) / 2)
  point_estimate <- mean(x, na.rm = TRUE)
  sd_error <- standard_error(x)
  interval <- z_score * sd_error

  c("lower" = point_estimate - interval, "upper" = point_estimate + interval)

}
