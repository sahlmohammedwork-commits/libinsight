\name{top_items}
\alias{top_items}
\title{Identify top-circulated library items}
\description{
Returns a data frame of the \code{n} most frequently checked-out items,
sorted in descending order of total checkouts. Supports optional filtering
by subject category or patron type.
}
\usage{
top_items(x, n = 10, subject = NULL, patron_type = NULL)
}
\arguments{
  \item{x}{A \code{libdata} object or a plain \code{data.frame} with columns
    \code{item_id}, \code{title}, \code{subject}, \code{patron_type},
    and \code{checkouts}.}
  \item{n}{Integer. Number of top items to return (default: 10).}
  \item{subject}{Character. Restrict results to this subject only.}
  \item{patron_type}{Character. Restrict results to this patron type only.}
}
\value{
A \code{data.frame} with columns \code{item_id}, \code{title},
\code{subject}, and \code{total_checkouts}.
}
\examples{
data(circ_sample)
ld <- libdata(circ_sample)
top_items(ld)
top_items(ld, n = 5, subject = "Technology")
top_items(ld, patron_type = "Graduate")
}
\seealso{
\code{\link{patron_stats}}, \code{\link{lib_report}}
}
