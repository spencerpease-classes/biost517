output_mri_table <- function(mri_table, caption_text = NULL, digits = 3) {

  mri_table %>%
    addmargins() %>%
    magrittr::set_rownames(c("Surv. <5 years", "Surv. 5+ years", "Total")) %>%
    magrittr::set_colnames(c("Low CRT", "High CRT", "Total")) %>%
    knitr::kable(
      booktabs = TRUE,
      caption = caption_text,
      digits = digits
    ) %>%
    kableExtra::column_spec(4, border_left = TRUE, bold = TRUE) %>%
    kableExtra::row_spec(2, hline_after = TRUE) %>%
    kableExtra::row_spec(3, bold = TRUE)

}
