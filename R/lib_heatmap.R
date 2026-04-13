#' Circulation heatmap by month and patron type
#'
#' Produces a tile heatmap with months on the x-axis and patron types on the
#' y-axis.  Cell color encodes total checkouts, making it easy to spot which
#' patron groups drive demand in particular months.
#'
#' @param x A \code{libdata} object or a plain \code{data.frame} with columns
#'   \code{checkout_month}, \code{patron_type}, and \code{checkouts}.
#' @param low  Character. Color for low checkout counts (default: \code{"#FFFFCC"}).
#' @param high Character. Color for high checkout counts (default: \code{"#D73027"}).
#'
#' @return A \code{ggplot} object (also printed as a side effect).
#'
#' @examples
#' data(circ_sample)
#' ld <- libdata(circ_sample)
#' lib_heatmap(ld)
#'
#' # Custom color scale
#' lib_heatmap(ld, low = "#f7fbff", high = "#08306b")
#'
#' @importFrom ggplot2 ggplot aes geom_tile scale_fill_gradient labs
#'   theme_minimal theme element_text scale_x_continuous
#' @importFrom dplyr group_by summarise
#' @export
lib_heatmap <- function(x, low = "#FFFFCC", high = "#D73027") {
  df <- if (inherits(x, "libdata")) x$data else x

  heat <- df |>
    dplyr::group_by(checkout_month, patron_type) |>
    dplyr::summarise(total = sum(checkouts, na.rm = TRUE), .groups = "drop")

  month_labels <- c("Jan","Feb","Mar","Apr","May","Jun",
                    "Jul","Aug","Sep","Oct","Nov","Dec")

  p <- ggplot2::ggplot(heat,
         ggplot2::aes(x = checkout_month, y = patron_type, fill = total)) +
    ggplot2::geom_tile(color = "white", linewidth = 0.5) +
    ggplot2::scale_fill_gradient(low = low, high = high,
                                 name = "Checkouts") +
    ggplot2::scale_x_continuous(breaks = 1:12, labels = month_labels) +
    ggplot2::labs(
      title = "Circulation Heatmap: Month vs Patron Type",
      x     = "Month",
      y     = "Patron Type"
    ) +
    ggplot2::theme_minimal(base_size = 13) +
    ggplot2::theme(
      plot.title  = ggplot2::element_text(face = "bold", hjust = 0.5),
      axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)
    )

  print(p)
  invisible(p)
}
