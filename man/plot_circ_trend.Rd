\name{plot_circ_trend}
\alias{plot_circ_trend}
\title{Plot monthly or annual circulation trends}
\description{
Produces a line chart showing total checkouts aggregated over time,
making it easy to identify seasonal patterns and year-over-year growth.
}
\usage{
plot_circ_trend(x, by = "month", color = "#2C7BB6")
}
\arguments{
  \item{x}{A \code{libdata} object or a plain \code{data.frame} with columns
    \code{checkouts}, \code{checkout_month}, and \code{checkout_year}.}
  \item{by}{Character. Aggregation level: \code{"month"} (default) or
    \code{"year"}.}
  \item{color}{Character. Line and point color. Default is \code{"#2C7BB6"}.}
}
\value{
Invisibly returns the \code{ggplot} object. The plot is also printed.
}
\examples{
data(circ_sample)
ld <- libdata(circ_sample)

plot_circ_trend(ld)              # monthly
plot_circ_trend(ld, by = "year") # annual
}
\seealso{
\code{\link{lib_heatmap}}, \code{\link{summarize_circulation}}
}
