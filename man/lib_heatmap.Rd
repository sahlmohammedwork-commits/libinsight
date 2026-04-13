\name{lib_heatmap}
\alias{lib_heatmap}
\title{Circulation heatmap by month and patron type}
\description{
Produces a tile heatmap with calendar months on the x-axis and patron
types on the y-axis. Cell color encodes total checkouts, making it easy
to identify which patron groups drive demand in particular months.
}
\usage{
lib_heatmap(x, low = "#FFFFCC", high = "#D73027")
}
\arguments{
  \item{x}{A \code{libdata} object or a plain \code{data.frame} with columns
    \code{checkout_month}, \code{patron_type}, and \code{checkouts}.}
  \item{low}{Character. Color for low checkout cells (default: \code{"#FFFFCC"}).}
  \item{high}{Character. Color for high checkout cells (default: \code{"#D73027"}).}
}
\value{
Invisibly returns the \code{ggplot} object. The plot is also printed.
}
\examples{
data(circ_sample)
ld <- libdata(circ_sample)
lib_heatmap(ld)
lib_heatmap(ld, low = "#f7fbff", high = "#08306b")
}
\seealso{
\code{\link{plot_circ_trend}}, \code{\link{patron_stats}}
}
