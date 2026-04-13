# Internal helper used only when the package is loaded without the compiled
# .rda (e.g. devtools::load_all()).  Users should call data(circ_sample).

.load_circ_sample <- function() {
  csv_path <- system.file("extdata", "circ_sample.csv", package = "libinsight")
  if (nzchar(csv_path)) {
    df <- utils::read.csv(csv_path, stringsAsFactors = FALSE)
    df$subject     <- as.factor(df$subject)
    df$patron_type <- as.factor(df$patron_type)
    df
  } else {
    NULL
  }
}
