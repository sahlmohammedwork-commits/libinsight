\name{collection_age}
\alias{collection_age}
\title{Visualize collection age distribution}
\description{
Draws a checkout-weighted histogram of publication years, helping to
assess whether a library's most-used materials are current or aging.
A dashed vertical line marks the median publication year.
}
\usage{
collection_age(x, binwidth = 5, fill = "#4DAF4A")
}
\arguments{
  \item{x}{A \code{libdata} object or a plain \code{data.frame} with columns
    \code{pub_year} and \code{checkouts}.}
  \item{binwidth}{Integer. Width of histogram bins in years (default: 5).}
  \item{fill}{Character. Bar fill color (default: \code{"#4DAF4A"}).}
}
\value{
Invisibly returns the \code{ggplot} object. The plot is also printed.
}
\details{
Each checkout record contributes to the histogram proportionally to its
\code{checkouts} count, so heavily circulated items have more visual weight
than rarely checked-out ones.
}
\examples{
data(circ_sample)
ld <- libdata(circ_sample)
collection_age(ld)
collection_age(ld, binwidth = 10, fill = "#984EA3")
}
\seealso{
\code{\link{lib_report}}, \code{\link{summarize_circulation}}
}
