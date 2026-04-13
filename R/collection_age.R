#' Visualize collection age distribution
#'
#' Draws a histogram of publication years for items in the collection,
#' weighted by total checkouts so that heavily used items count more.
#' This helps identify whether a library's most-used materials are current
#' or aging.
#'
#' @param x A \code{libdata} object or a plain \code{data.frame} with columns
#'   \code{pub_year} and \code{checkouts}.
#' @param binwidth Integer. Width of histogram bins in years (default: \code{5}).
#' @param fill Character. Bar fill color (default: \code{"#4DAF4A"}).
#'
#' @return A \code{ggplot} object (also printed as a side effect).
#'
#' @details
#' The histogram is weighted by \code{checkouts}, so each publication year
#' contributes proportionally to how much that year's items are actually used,
#' rather than merely how many titles from that year are held.
#'
#' @examples
#' data(circ_sample)
#' ld <- libdata(circ_sample)
#' collection_age(ld)
#'
#' # Wider bins and custom color
#' collection_age(ld, binwidth = 10, fill = "#984EA3")
#'
#' @importFrom ggplot2 ggplot aes geom_histogram labs theme_minimal theme
#'   element_text
#' @export
collection_age <- function(x, binwidth = 5, fill = "#4DAF4A") {
  df <- if (inherits(x, "libdata")) x$data else x

  # Expand rows by checkout count so the histogram is checkout-weighted
  expanded <- df[rep(seq_len(nrow(df)), df$checkouts), ]

  median_year <- stats::median(expanded$pub_year, na.rm = TRUE)

  p <- ggplot2::ggplot(expanded, ggplot2::aes(x = pub_year)) +
    ggplot2::geom_histogram(binwidth = binwidth, fill = fill,
                            color = "white", alpha = 0.85) +
    ggplot2::geom_vline(xintercept = median_year,
                        linetype = "dashed", color = "gray40", linewidth = 0.9) +
    ggplot2::labs(
      title    = "Collection Age Distribution (checkout-weighted)",
      subtitle = paste0("Median publication year: ", median_year),
      x        = "Publication Year",
      y        = "Checkout Count"
    ) +
    ggplot2::theme_minimal(base_size = 13) +
    ggplot2::theme(
      plot.title    = ggplot2::element_text(face = "bold", hjust = 0.5),
      plot.subtitle = ggplot2::element_text(hjust = 0.5, color = "gray50")
    )

  print(p)
  invisible(p)
}
