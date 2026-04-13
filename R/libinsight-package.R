#' libinsight: Library Statistics Analysis and Visualization
#'
#' The \pkg{libinsight} package provides a suite of tools for analyzing and
#' visualizing academic library statistics. It is designed for library
#' professionals and LIS (Library and Information Science) researchers who
#' need reproducible, data-driven workflows in R.
#'
#' @section Core S3 class:
#' The package introduces the \code{libdata} S3 class, which wraps a
#' structured library data frame and exposes \code{print}, \code{summary},
#' and \code{plot} methods. Use \code{\link{libdata}} to construct an object.
#'
#' @section Key functions:
#' \describe{
#'   \item{\code{\link{summarize_circulation}}}{Compute circulation summary statistics.}
#'   \item{\code{\link{plot_circ_trend}}}{Line chart of monthly circulation trends.}
#'   \item{\code{\link{top_items}}}{Identify top-N most circulated items.}
#'   \item{\code{\link{patron_stats}}}{Patron-type usage breakdown.}
#'   \item{\code{\link{collection_age}}}{Histogram of collection publication years.}
#'   \item{\code{\link{lib_heatmap}}}{Heatmap of checkouts by weekday and month.}
#'   \item{\code{\link{lib_report}}}{Print a plain-text statistical report to the console.}
#' }
#'
#' @section Sample data:
#' A built-in example dataset \code{\link{circ_sample}} is included so you
#' can try all functions immediately after installing the package.
#'
#' @docType package
#' @name libinsight
"_PACKAGE"
