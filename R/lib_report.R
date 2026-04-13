#' Generate a plain-text library statistics report
#'
#' Prints a formatted, human-readable statistical report to the console
#' summarising circulation totals, patron usage, collection currency, and
#' top-performing items. Useful for quick reporting and as a starting point
#' for formal library annual reports.
#'
#' @param x A \code{libdata} object or a plain \code{data.frame} containing
#'   the required columns (see \code{\link{libdata}}).
#' @param title Character. Title line printed at the top of the report
#'   (default: \code{"Library Statistics Report"}).
#' @param top_n Integer. Number of top items to list in the report
#'   (default: \code{5}).
#'
#' @return Invisibly returns a named \code{list} with elements:
#'   \code{circulation_summary}, \code{patron_table}, and \code{top_items_table}.
#'
#' @examples
#' data(circ_sample)
#' ld <- libdata(circ_sample)
#' lib_report(ld)
#'
#' # Custom title and top-10 items
#' lib_report(ld, title = "Annual Report 2022", top_n = 10)
#'
#' @export
lib_report <- function(x, title = "Library Statistics Report", top_n = 5) {
  df <- if (inherits(x, "libdata")) x$data else x

  sep <- paste(rep("=", 50), collapse = "")
  cat(sep, "\n")
  cat(" ", title, "\n")
  cat(" Generated:", format(Sys.time(), "%Y-%m-%d %H:%M"), "\n")
  cat(sep, "\n\n")

  # --- Circulation Summary ---
  cat("CIRCULATION SUMMARY\n")
  cat(paste(rep("-", 30), collapse = ""), "\n")
  circ <- summarize_circulation(x)
  cat("\n")

  # --- Patron Breakdown ---
  cat("PATRON BREAKDOWN\n")
  cat(paste(rep("-", 30), collapse = ""), "\n")
  pat_tbl <- patron_stats(x, plot = FALSE)
  cat("\n")

  # --- Collection Overview ---
  cat("COLLECTION OVERVIEW\n")
  cat(paste(rep("-", 30), collapse = ""), "\n")
  cat(sprintf("  Unique items in dataset : %d\n", length(unique(df$item_id))))
  cat(sprintf("  Subjects covered        : %s\n",
              paste(sort(unique(df$subject)), collapse = ", ")))
  yr_range <- range(df$pub_year, na.rm = TRUE)
  cat(sprintf("  Publication years       : %d -- %d\n",
              yr_range[1], yr_range[2]))
  cat(sprintf("  Median pub. year        : %d\n",
              as.integer(stats::median(df$pub_year, na.rm = TRUE))))
  cat("\n")

  # --- Top Items ---
  cat(sprintf("TOP %d ITEMS BY TOTAL CHECKOUTS\n", top_n))
  cat(paste(rep("-", 30), collapse = ""), "\n")
  top_tbl <- top_items(x, n = top_n)
  cat("\n")

  cat(sep, "\n")
  cat(" END OF REPORT\n")
  cat(sep, "\n")

  invisible(list(
    circulation_summary = circ,
    patron_table        = pat_tbl,
    top_items_table     = top_tbl
  ))
}
