# ============================================================
#  S3 class: libdata
#  Represents a structured library circulation dataset.
# ============================================================

#' Create a libdata object
#'
#' Constructs an S3 object of class \code{libdata} from a data frame that
#' contains library circulation records. The constructor validates that the
#' required columns are present before wrapping the data.
#'
#' @param df A \code{data.frame} with at least the following columns:
#'   \describe{
#'     \item{item_id}{Character. Unique identifier for each library item.}
#'     \item{title}{Character. Title of the item.}
#'     \item{subject}{Character or factor. Subject category.}
#'     \item{pub_year}{Integer. Year the item was published.}
#'     \item{patron_type}{Character or factor. Type of patron (e.g.,
#'       "Undergraduate", "Graduate", "Faculty").}
#'     \item{checkout_month}{Integer (1--12). Month of checkout.}
#'     \item{checkout_year}{Integer. Year of checkout.}
#'     \item{checkouts}{Integer. Number of times the item was checked out
#'       in that month/year combination.}
#'   }
#'
#' @return An object of class \code{libdata} (a list with element \code{data}
#'   holding the data frame).
#'
#' @examples
#' data(circ_sample)
#' ld <- libdata(circ_sample)
#' class(ld)   # "libdata"
#'
#' @export
libdata <- function(df) {
  required <- c("item_id", "title", "subject", "pub_year",
                "patron_type", "checkout_month", "checkout_year", "checkouts")
  missing_cols <- setdiff(required, names(df))
  if (length(missing_cols) > 0) {
    stop(
      "The following required columns are missing from df: ",
      paste(missing_cols, collapse = ", ")
    )
  }
  structure(list(data = df), class = "libdata")
}


#' Print method for libdata
#'
#' Displays a compact overview of a \code{libdata} object, including the
#' number of records, unique items, and the date range covered.
#'
#' @param x An object of class \code{libdata}.
#' @param ... Additional arguments (ignored).
#'
#' @return Invisibly returns \code{x}.
#'
#' @examples
#' data(circ_sample)
#' ld <- libdata(circ_sample)
#' print(ld)
#'
#' @export
print.libdata <- function(x, ...) {
  df <- x$data
  cat("=== libdata object ===\n")
  cat(sprintf("  Records      : %d\n", nrow(df)))
  cat(sprintf("  Unique items : %d\n", length(unique(df$item_id))))
  cat(sprintf("  Subjects     : %s\n",
              paste(unique(df$subject), collapse = ", ")))
  cat(sprintf("  Patron types : %s\n",
              paste(unique(df$patron_type), collapse = ", ")))
  yr_range <- range(df$checkout_year, na.rm = TRUE)
  cat(sprintf("  Years covered: %d -- %d\n", yr_range[1], yr_range[2]))
  cat(sprintf("  Total checkouts: %d\n", sum(df$checkouts, na.rm = TRUE)))
  invisible(x)
}


#' Summary method for libdata
#'
#' Returns a named list of high-level statistics derived from a
#' \code{libdata} object: total checkouts, average monthly checkouts,
#' number of unique items, subject distribution, and patron-type counts.
#'
#' @param object An object of class \code{libdata}.
#' @param ... Additional arguments (ignored).
#'
#' @return A named \code{list} with the following elements:
#'   \describe{
#'     \item{total_checkouts}{Integer. Sum of all checkout counts.}
#'     \item{mean_monthly_checkouts}{Numeric. Average checkouts per month.}
#'     \item{unique_items}{Integer. Number of distinct item IDs.}
#'     \item{subject_counts}{Named integer vector of checkout totals by subject.}
#'     \item{patron_counts}{Named integer vector of checkout totals by patron type.}
#'   }
#'
#' @examples
#' data(circ_sample)
#' ld <- libdata(circ_sample)
#' s <- summary(ld)
#' s$total_checkouts
#'
#' @export
summary.libdata <- function(object, ...) {
  df <- object$data

  # Monthly totals
  monthly <- tapply(df$checkouts,
                    paste(df$checkout_year, sprintf("%02d", df$checkout_month)),
                    sum)
  subj_counts <- sort(tapply(df$checkouts, df$subject, sum), decreasing = TRUE)
  pat_counts  <- sort(tapply(df$checkouts, df$patron_type, sum), decreasing = TRUE)

  result <- list(
    total_checkouts        = sum(df$checkouts, na.rm = TRUE),
    mean_monthly_checkouts = round(mean(monthly, na.rm = TRUE), 1),
    unique_items           = length(unique(df$item_id)),
    subject_counts         = subj_counts,
    patron_counts          = pat_counts
  )

  cat("--- libdata summary ---\n")
  cat(sprintf("Total checkouts         : %d\n", result$total_checkouts))
  cat(sprintf("Mean monthly checkouts  : %.1f\n", result$mean_monthly_checkouts))
  cat(sprintf("Unique items            : %d\n", result$unique_items))
  cat("\nCheckouts by subject:\n")
  print(result$subject_counts)
  cat("\nCheckouts by patron type:\n")
  print(result$patron_counts)

  invisible(result)
}


#' Plot method for libdata
#'
#' Produces a bar chart of total checkouts grouped by subject category,
#' giving a quick visual overview of collection usage across subject areas.
#'
#' @param x An object of class \code{libdata}.
#' @param ... Additional arguments (ignored).
#'
#' @return A \code{ggplot} object (printed as a side effect).
#'
#' @examples
#' data(circ_sample)
#' ld <- libdata(circ_sample)
#' plot(ld)
#'
#' @importFrom ggplot2 ggplot aes geom_col labs theme_minimal theme element_text
#' @importFrom dplyr group_by summarise
#' @export
plot.libdata <- function(x, ...) {
  df <- x$data
  subj_df <- df |>
    dplyr::group_by(subject) |>
    dplyr::summarise(total = sum(checkouts, na.rm = TRUE), .groups = "drop") |>
    dplyr::arrange(dplyr::desc(total))

  p <- ggplot2::ggplot(subj_df, ggplot2::aes(
    x = reorder(subject, total), y = total, fill = subject)) +
    ggplot2::geom_col(show.legend = FALSE) +
    ggplot2::coord_flip() +
    ggplot2::labs(
      title = "Total Checkouts by Subject",
      x     = "Subject",
      y     = "Total Checkouts"
    ) +
    ggplot2::theme_minimal(base_size = 13) +
    ggplot2::theme(plot.title = ggplot2::element_text(face = "bold", hjust = 0.5))

  print(p)
  invisible(p)
}
