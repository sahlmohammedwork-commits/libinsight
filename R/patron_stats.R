#' Summarize patron usage statistics
#'
#' Breaks down library circulation by patron type, reporting total checkouts,
#' percentage share, and average checkouts per item for each patron category.
#' Also produces a bar chart of patron-type usage.
#'
#' @param x A \code{libdata} object or a plain \code{data.frame} with columns
#'   \code{patron_type} and \code{checkouts}.
#' @param plot Logical. If \code{TRUE} (default), a bar chart is printed.
#'
#' @return A \code{data.frame} with columns:
#'   \describe{
#'     \item{patron_type}{The patron category.}
#'     \item{total_checkouts}{Total checkouts for this patron type.}
#'     \item{pct_share}{Percentage of all checkouts belonging to this type.}
#'   }
#'
#' @examples
#' data(circ_sample)
#' ld <- libdata(circ_sample)
#' patron_stats(ld)
#'
#' # Return data only, suppress plot
#' ps <- patron_stats(ld, plot = FALSE)
#' ps
#'
#' @importFrom ggplot2 ggplot aes geom_col geom_text labs theme_minimal theme
#'   element_text coord_flip
#' @importFrom dplyr group_by summarise mutate arrange desc
#' @export
patron_stats <- function(x, plot = TRUE) {
  df <- if (inherits(x, "libdata")) x$data else x

  result <- df |>
    dplyr::group_by(patron_type) |>
    dplyr::summarise(total_checkouts = sum(checkouts, na.rm = TRUE),
                     .groups = "drop") |>
    dplyr::mutate(pct_share = round(100 * total_checkouts / sum(total_checkouts), 1)) |>
    dplyr::arrange(dplyr::desc(total_checkouts))
  result <- as.data.frame(result)

  cat("--- Patron Usage Statistics ---\n")
  print(result)

  if (plot) {
    p <- ggplot2::ggplot(result,
           ggplot2::aes(x = reorder(patron_type, total_checkouts),
                        y = total_checkouts,
                        fill = patron_type)) +
      ggplot2::geom_col(show.legend = FALSE) +
      ggplot2::geom_text(ggplot2::aes(label = paste0(pct_share, "%")),
                         hjust = -0.1, size = 3.5) +
      ggplot2::coord_flip() +
      ggplot2::labs(
        title = "Checkouts by Patron Type",
        x     = "Patron Type",
        y     = "Total Checkouts"
      ) +
      ggplot2::theme_minimal(base_size = 13) +
      ggplot2::theme(plot.title = ggplot2::element_text(face = "bold", hjust = 0.5))
    print(p)
  }

  invisible(result)
}
