\name{libdata}
\alias{libdata}
\alias{print.libdata}
\alias{summary.libdata}
\alias{plot.libdata}
\title{Create and work with a libdata S3 object}
\description{
\code{libdata} constructs an S3 object of class \code{libdata} from a
data frame of library circulation records, after validating that all
required columns are present.

The class provides \code{print}, \code{summary}, and \code{plot} methods
for exploring the dataset quickly.
}
\usage{
libdata(df)

\method{print}{libdata}(x, ...)

\method{summary}{libdata}(object, ...)

\method{plot}{libdata}(x, ...)
}
\arguments{
  \item{df}{A \code{data.frame} containing at least the columns
    \code{item_id}, \code{title}, \code{subject}, \code{pub_year},
    \code{patron_type}, \code{checkout_month}, \code{checkout_year},
    and \code{checkouts}.}
  \item{x}{An object of class \code{libdata}.}
  \item{object}{An object of class \code{libdata} (used by \code{summary}).}
  \item{...}{Additional arguments (currently ignored).}
}
\value{
\code{libdata} returns a list of class \code{libdata} with a single
element \code{data} holding the validated data frame.

\code{print.libdata} invisibly returns \code{x}.

\code{summary.libdata} invisibly returns a named list of statistics
(see Details).

\code{plot.libdata} invisibly returns a \code{ggplot} object.
}
\details{
\code{summary.libdata} returns a list with:
\describe{
  \item{total_checkouts}{Total checkout count.}
  \item{mean_monthly_checkouts}{Mean checkouts per month.}
  \item{unique_items}{Number of distinct items.}
  \item{subject_counts}{Named vector of totals per subject.}
  \item{patron_counts}{Named vector of totals per patron type.}
}

\code{plot.libdata} produces a bar chart of total checkouts by subject.
}
\examples{
data(circ_sample)
ld <- libdata(circ_sample)

# S3 dispatch
print(ld)
summary(ld)
plot(ld)
}
\seealso{
\code{\link{summarize_circulation}}, \code{\link{lib_report}}
}
