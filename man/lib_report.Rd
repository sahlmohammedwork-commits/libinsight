\name{lib_report}
\alias{lib_report}
\title{Generate a plain-text library statistics report}
\description{
Prints a formatted statistical report to the console covering circulation
totals, patron usage, collection overview, and top items. Useful for
quick reporting and as a starting point for formal library annual reports.
}
\usage{
lib_report(x, title = "Library Statistics Report", top_n = 5)
}
\arguments{
  \item{x}{A \code{libdata} object or a plain \code{data.frame}.}
  \item{title}{Character. Title printed at the top of the report
    (default: \code{"Library Statistics Report"}).}
  \item{top_n}{Integer. Number of top items to list (default: 5).}
}
\value{
Invisibly returns a named \code{list} with elements
\code{circulation_summary}, \code{patron_table}, and \code{top_items_table}.
}
\examples{
data(circ_sample)
ld <- libdata(circ_sample)
lib_report(ld)
lib_report(ld, title = "Annual Report 2022", top_n = 10)
}
\seealso{
\code{\link{summarize_circulation}}, \code{\link{top_items}},
\code{\link{patron_stats}}
}
