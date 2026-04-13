\name{patron_stats}
\alias{patron_stats}
\title{Summarize patron usage statistics}
\description{
Breaks down library circulation by patron type, reporting total checkouts
and percentage share for each patron category. Optionally produces a
horizontal bar chart.
}
\usage{
patron_stats(x, plot = TRUE)
}
\arguments{
  \item{x}{A \code{libdata} object or a plain \code{data.frame} with columns
    \code{patron_type} and \code{checkouts}.}
  \item{plot}{Logical. If \code{TRUE} (default), a bar chart is printed.}
}
\value{
Invisibly returns a \code{data.frame} with columns \code{patron_type},
\code{total_checkouts}, and \code{pct_share}.
}
\examples{
data(circ_sample)
ld <- libdata(circ_sample)
patron_stats(ld)

ps <- patron_stats(ld, plot = FALSE)
ps
}
\seealso{
\code{\link{top_items}}, \code{\link{lib_heatmap}}
}
