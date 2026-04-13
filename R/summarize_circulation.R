#' Summarize circulation statistics
#'
#' Computes descriptive statistics for library circulation data, including
#' total checkouts, mean, median, minimum, maximum, and the peak month for
#' a given year range.
#'
#' @param x A \code{libdata} object or a plain \code{data.frame} with at
#'   least columns \code{checkouts}, \code{checkout_month}, and
#'   \code{checkout_year}.
#' @param year_from Integer. First year to include (default: all years).
#' @param year_to   Integer. Last year to include (default: all years).
#'
#' @return A named \code{list} with elements:
#'   \describe{
#'     \item{total}{Total number of checkouts.}
#'     \item{mean}{Mean monthly checkouts.}
#'     \item{median}{Median monthly checkouts.}
#'     \item{min}{Minimum monthly checkouts.}
#'     \item{max}{Maximum monthly checkouts.}
#'     \item{peak_month}{Month number with the highest aggregate checkouts.}
#'     \item{peak_year}{Year with the highest aggregate checkouts.}
#'   }
#'
#' @examples
#' data(circ_sample)
#' ld <- libdata(circ_sample)
#' summarize_circulation(ld)
#'
#' # Filter to a specific year range
#' summarize_circulation(ld, year_from = 2020, year_to = 2022)
#'
#' @importFrom stats median
#' @export
summarize_circulation <- function(x, year_from = NULL, year_to = NULL) {
  df <- if (inherits(x, "libdata")) x$data else x

  if (!is.null(year_from)) df <- df[df$checkout_year >= year_from, ]
  if (!is.null(year_to))   df <- df[df$checkout_year <= year_to,   ]

  if (nrow(df) == 0) stop("No records remain after filtering by year range.")

  # Monthly aggregates
  monthly <- tapply(
    df$checkouts,
    paste(df$checkout_year, sprintf("%02d", df$checkout_month)),
    sum
  )

  # Peak month (across all years)
  month_totals <- tapply(df$checkouts, df$checkout_month, sum)
  peak_month   <- as.integer(names(which.max(month_totals)))

  # Peak year
  year_totals <- tapply(df$checkouts, df$checkout_year, sum)
  peak_year   <- as.integer(names(which.max(year_totals)))

  result <- list(
    total      = sum(df$checkouts, na.rm = TRUE),
    mean       = round(mean(monthly, na.rm = TRUE), 1),
    median     = stats::median(monthly, na.rm = TRUE),
    min        = min(monthly, na.rm = TRUE),
    max        = max(monthly, na.rm = TRUE),
    peak_month = peak_month,
    peak_year  = peak_year
  )

  cat("--- Circulation Summary ---\n")
  cat(sprintf("  Total checkouts   : %d\n",   result$total))
  cat(sprintf("  Mean  (monthly)   : %.1f\n", result$mean))
  cat(sprintf("  Median (monthly)  : %.1f\n", result$median))
  cat(sprintf("  Min   (monthly)   : %d\n",   result$min))
  cat(sprintf("  Max   (monthly)   : %d\n",   result$max))
  month_names <- c("Jan","Feb","Mar","Apr","May","Jun",
                   "Jul","Aug","Sep","Oct","Nov","Dec")
  cat(sprintf("  Peak month        : %s\n",
              month_names[result$peak_month]))
  cat(sprintf("  Peak year         : %d\n",   result$peak_year))

  invisible(result)
}
