#' Plot monthly circulation trends
#'
#' Produces a line chart showing total checkouts aggregated by month and year,
#' making it easy to spot seasonal patterns and year-over-year growth.
#'
#' @param x A \code{libdata} object or a plain \code{data.frame} with columns
#'   \code{checkouts}, \code{checkout_month}, and \code{checkout_year}.
#' @param by Character. Aggregation level: \code{"month"} (default) plots one
#'   point per month-year combination; \code{"year"} collapses to annual totals.
#' @param color Character. Line color. Default is \code{"#2C7BB6"}.
#'
#' @return A \code{ggplot} object (also printed as a side effect).
#'
#' @examples
#' data(circ_sample)
#' ld <- libdata(circ_sample)
#'
#' # Monthly trend
#' plot_circ_trend(ld)
#'
#' # Annual trend
#' plot_circ_trend(ld, by = "year")
#'
#' @importFrom ggplot2 ggplot aes geom_line geom_point labs theme_minimal
#'   theme element_text scale_x_continuous
#' @importFrom dplyr group_by summarise
#' @export
plot_circ_trend <- function(x, by = "month", color = "#2C7BB6") {
  df <- if (inherits(x, "libdata")) x$data else x

  by <- match.arg(by, c("month", "year"))

  if (by == "month") {
    trend <- df |>
      dplyr::group_by(checkout_year, checkout_month) |>
      dplyr::summarise(total = sum(checkouts, na.rm = TRUE), .groups = "drop")
    trend$period <- trend$checkout_year + (trend$checkout_month - 1) / 12

    p <- ggplot2::ggplot(trend, ggplot2::aes(x = period, y = total)) +
      ggplot2::geom_line(color = color, linewidth = 1.1) +
      ggplot2::geom_point(color = color, size = 2) +
      ggplot2::scale_x_continuous(
        breaks = unique(trend$checkout_year),
        labels = unique(trend$checkout_year)
      ) +
      ggplot2::labs(
        title = "Monthly Circulation Trend",
        x     = "Year",
        y     = "Total Checkouts"
      ) +
      ggplot2::theme_minimal(base_size = 13) +
      ggplot2::theme(plot.title = ggplot2::element_text(face = "bold", hjust = 0.5))

  } else {
    trend <- df |>
      dplyr::group_by(checkout_year) |>
      dplyr::summarise(total = sum(checkouts, na.rm = TRUE), .groups = "drop")

    p <- ggplot2::ggplot(trend, ggplot2::aes(x = checkout_year, y = total)) +
      ggplot2::geom_line(color = color, linewidth = 1.3) +
      ggplot2::geom_point(color = color, size = 3) +
      ggplot2::scale_x_continuous(breaks = trend$checkout_year) +
      ggplot2::labs(
        title = "Annual Circulation Trend",
        x     = "Year",
        y     = "Total Checkouts"
      ) +
      ggplot2::theme_minimal(base_size = 13) +
      ggplot2::theme(plot.title = ggplot2::element_text(face = "bold", hjust = 0.5))
  }

  print(p)
  invisible(p)
}
