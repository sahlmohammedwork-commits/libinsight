\name{summarize_circulation}
\alias{summarize_circulation}
\title{Summarize circulation statistics}
\description{
Computes descriptive statistics for library circulation data, including
total checkouts, mean, median, minimum, maximum, and the peak month and
year across the selected date range.
}
\usage{
summarize_circulation(x, year_from = NULL, year_to = NULL)
}
\arguments{
  \item{x}{A \code{libdata} object or a plain \code{data.frame} with columns
    \code{checkouts}, \code{checkout_month}, and \code{checkout_year}.}
  \item{year_from}{Integer. First year to include. If \code{NULL} (default),
    all years are included.}
  \item{year_to}{Integer. Last year to include. If \code{NULL} (default),
    all years are included.}
}
\value{
Invisibly returns a named \code{list} with elements \code{total},
\code{mean}, \code{median}, \code{min}, \code{max}, \code{peak_month},
and \code{peak_year}.  Statistics are printed to the console as a side effect.
}
\examples{
data(circ_sample)
ld <- libdata(circ_sample)
summarize_circulation(ld)

# Restrict to 2020-2022
summarize_circulation(ld, year_from = 2020, year_to = 2022)
}
\seealso{
\code{\link{lib_report}}, \code{\link{plot_circ_trend}}
}
