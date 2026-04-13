\name{circ_sample}
\alias{circ_sample}
\docType{data}
\title{Sample library circulation dataset}
\description{
A fabricated dataset representing five years of circulation records from a
fictional academic library. Intended for demonstrating all
\pkg{libinsight} functions without requiring real library data.
}
\usage{
data(circ_sample)
}
\format{
A \code{data.frame} with 1,200 rows and 8 variables:
\describe{
  \item{item_id}{Character. Unique item identifier (e.g., \code{"IT001"}).}
  \item{title}{Character. Title of the library item.}
  \item{subject}{Factor. Subject category: \code{"Reference"},
    \code{"Technology"}, \code{"History"}, \code{"Science"},
    \code{"Literature"}, or \code{"Social Sciences"}.}
  \item{pub_year}{Integer. Year published (1985--2022).}
  \item{patron_type}{Factor. Patron category: \code{"Undergraduate"},
    \code{"Graduate"}, \code{"Faculty"}, or \code{"Community"}.}
  \item{checkout_month}{Integer. Month of checkout (1--12).}
  \item{checkout_year}{Integer. Year of checkout (2018--2022).}
  \item{checkouts}{Integer. Checkouts for this item-patron-month combination.}
}
}
\source{Fabricated for the \pkg{libinsight} package.}
\examples{
data(circ_sample)
head(circ_sample)
nrow(circ_sample)
}
\keyword{datasets}
