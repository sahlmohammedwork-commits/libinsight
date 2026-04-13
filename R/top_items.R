#' Identify top-circulated items
#'
#' Returns a data frame of the \code{n} most frequently checked-out items,
#' sorted in descending order of total checkouts.  Optionally filters by
#' subject or patron type before ranking.
#'
#' @param x A \code{libdata} object or a plain \code{data.frame} with at
#'   least columns \code{item_id}, \code{title}, \code{subject},
#'   \code{patron_type}, and \code{checkouts}.
#' @param n Integer. Number of top items to return (default: \code{10}).
#' @param subject Character. If supplied, restricts results to this subject
#'   category only.
#' @param patron_type Character. If supplied, restricts results to this
#'   patron type only.
#'
#' @return A \code{data.frame} with columns \code{item_id}, \code{title},
#'   \code{subject}, and \code{total_checkouts}, containing the top \code{n}
#'   items sorted by \code{total_checkouts} descending.
#'
#' @examples
#' data(circ_sample)
#' ld <- libdata(circ_sample)
#'
#' # Top 10 overall
#' top_items(ld)
#'
#' # Top 5 in the Technology subject
#' top_items(ld, n = 5, subject = "Technology")
#'
#' # Top 10 for Graduate patrons
#' top_items(ld, patron_type = "Graduate")
#'
#' @importFrom dplyr group_by summarise arrange desc
#' @importFrom utils head
#' @export
top_items <- function(x, n = 10, subject = NULL, patron_type = NULL) {
  df <- if (inherits(x, "libdata")) x$data else x

  if (!is.null(subject))      df <- df[df$subject == subject, ]
  if (!is.null(patron_type))  df <- df[df$patron_type == patron_type, ]

  if (nrow(df) == 0) {
    warning("No records match the supplied filters. Returning empty data frame.")
    return(data.frame(item_id = character(), title = character(),
                      subject = character(), total_checkouts = integer()))
  }

  ranked <- df |>
    dplyr::group_by(item_id, title, subject) |>
    dplyr::summarise(total_checkouts = sum(checkouts, na.rm = TRUE),
                     .groups = "drop") |>
    dplyr::arrange(dplyr::desc(total_checkouts))

  result <- as.data.frame(utils::head(ranked, n))

  cat(sprintf("--- Top %d items", n))
  if (!is.null(subject))     cat(sprintf(" | subject: %s",     subject))
  if (!is.null(patron_type)) cat(sprintf(" | patron type: %s", patron_type))
  cat(" ---\n")
  print(result)

  invisible(result)
}
