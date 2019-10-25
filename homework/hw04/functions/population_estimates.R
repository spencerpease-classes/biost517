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

two_sample_ci <- function(data, test_col = NULL, alpha = .95) {


  # Validate parameters -----------------------------------------------------


  # Split data --------------------------------------------------------------

  split_data <- data %>%
    dplyr::select(dplyr::group_cols(), {{test_col}}) %>%
    dplyr::group_split(keep = FALSE) %>%
    purrr::map(tibble::deframe) %>%
    purrr::map(na.omit)


  # Calculate statistics ----------------------------------------------------

  z_score <- qnorm((alpha + 1) / 2)
  point_est <- mean(split_data[[1]]) - mean(split_data[[2]])

  std_deviation <- split_data %>%
    purrr::map(~(var(.) / length(.))) %>%
    purrr::reduce(`+`) %>%
    sqrt()

  interval <- z_score * std_deviation
  ci_lower <- point_est - interval
  ci_upper <- point_est + interval


  # Organize output ---------------------------------------------------------

  ci_lower_name <- paste0(alpha * 100, "% CI (lower)")
  ci_upper_name <- paste0(alpha * 100, "% CI (upper)")

  tibble::tibble(
    `Point est.` = point_est,
    !!ci_lower_name := ci_lower,
    !!ci_upper_name := ci_upper
  )

}
