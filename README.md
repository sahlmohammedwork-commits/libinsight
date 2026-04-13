# libinsight

**Library Statistics Analysis and Visualization**

libinsight is an R package for analyzing and visualizing academic library circulation data. It provides an S3 class (`libdata`), eight exported functions for analysis and reporting, and a built-in example dataset for demonstration and testing.
---

## Installation

Install from GitHub using devtools:

```r
# install.packages("devtools")
devtools::install_github("sahlmohammedwork-commits/libinsight")
```

---

## Features

| Function | Description |
|---|---|
| `libdata()` | S3 class constructor — wraps & validates a circulation data frame |
| `print.libdata()` | Compact console overview of a `libdata` object |
| `summary.libdata()` | Detailed statistics for a `libdata` object |
| `plot.libdata()` | Bar chart of checkouts by subject (S3 dispatch) |
| `summarize_circulation()` | Total, mean, median, min, max and peak period |
| `plot_circ_trend()` | Monthly or annual circulation line chart |
| `top_items()` | Top-N most circulated items (with optional filters) |
| `patron_stats()` | Checkout breakdown by patron type |
| `collection_age()` | Checkout-weighted histogram of publication years |
| `lib_heatmap()` | Heatmap of checkouts by month × patron type |
| `lib_report()` | Full plain-text statistical report |

---

## Quick Start

```r
library(libinsight)

# Load the built-in sample dataset (480 records, 5 years)
data(circ_sample)

# Create an S3 libdata object
ld <- libdata(circ_sample)
print(ld)
summary(ld)
plot(ld)

# Circulation trend
plot_circ_trend(ld)
plot_circ_trend(ld, by = "year")

# Top 10 items
top_items(ld, n = 10)

# Patron breakdown
patron_stats(ld)

# Collection age
collection_age(ld)

# Heatmap
lib_heatmap(ld)

# Full report
lib_report(ld, title = "My Library Annual Report")
```

---

## Sample Data

The package includes a fictitious dataset named `circ_sample` consisting of
480 circulation records for a fictional university library in 2018-2022.
It contains 20 items across 6 subjects and 4 user categories (Undergraduate,
Graduate, Faculty, Community).

```r
data(circ_sample)
head(circ_sample)
#>   item_id                         title   subject pub_year patron_type
#> 1   IT001 Introduction to Library Science Reference     1995 Undergraduate
#>   checkout_month checkout_year checkouts
#> 1              1          2018         9
```

---

## Package Details

- **Author:** Sahl Mohammed
- **License:** GPL-2
- **Version:** 1.0.0
- **Depends:** R (>= 4.0.0)
- **Imports:** ggplot2, dplyr
- **S3 class:** `libdata` with `print`, `summary`, and `plot` methods

---

## License

This package is released under the [GNU General Public License v2](LICENSE).
