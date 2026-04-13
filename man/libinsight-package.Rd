\name{libinsight-package}
\alias{libinsight-package}
\alias{libinsight}
\docType{package}
\title{libinsight: Library Statistics Analysis and Visualization}
\description{
Tools for analyzing and visualizing academic library statistics.
Provides functions for summarizing circulation data, identifying top
circulated items, profiling patron usage, examining collection age, and
generating heatmaps and trend plots. Includes an S3 class \code{libdata}
for structured library datasets.
}
\section{Core S3 class}{
The package introduces the \code{libdata} S3 class, which wraps a
structured library data frame and exposes \code{print}, \code{summary},
and \code{plot} methods. Use \code{\link{libdata}} to construct an object.
}
\section{Key functions}{
\describe{
  \item{\code{\link{summarize_circulation}}}{Compute circulation summary statistics.}
  \item{\code{\link{plot_circ_trend}}}{Line chart of monthly circulation trends.}
  \item{\code{\link{top_items}}}{Identify top-N most circulated items.}
  \item{\code{\link{patron_stats}}}{Patron-type usage breakdown.}
  \item{\code{\link{collection_age}}}{Histogram of collection publication years.}
  \item{\code{\link{lib_heatmap}}}{Heatmap of checkouts by month and patron type.}
  \item{\code{\link{lib_report}}}{Print a plain-text statistical report.}
}
}
\author{
Sahl Mohammed \email{sahlmohammedwork@gmail.com}

Maintainer: Sahl Mohammed \email{sahlmohammedwork@gmail.com}
}
\keyword{package}
