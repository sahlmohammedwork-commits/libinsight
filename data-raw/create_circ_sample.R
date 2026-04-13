# Script to generate the circ_sample dataset bundled with libinsight.
# Run this script once from the package root with:
#   source("data-raw/create_circ_sample.R")

set.seed(4317)

titles <- c(
  "Introduction to Library Science",
  "Digital Information Management",
  "Research Methods in LIS",
  "Cataloging and Classification",
  "Information Architecture",
  "Data Science for Librarians",
  "Knowledge Organization",
  "Academic Library Services",
  "Special Collections Management",
  "Metadata Standards and Practice",
  "Information Retrieval Systems",
  "Open Access and Scholarly Communication",
  "Library Leadership and Management",
  "Archives and Records Management",
  "User Experience in Libraries",
  "History of Books and Libraries",
  "Social Sciences Research",
  "Scientific Communication",
  "Literature and Information",
  "Community Information Services"
)

subjects <- c(
  rep("Reference",       4),
  rep("Technology",      4),
  rep("History",         3),
  rep("Science",         3),
  rep("Literature",      3),
  rep("Social Sciences", 3)
)

pub_years <- c(
  1995, 2010, 2005, 2018,   # Reference
  2015, 2019, 2021, 2022,   # Technology
  1990, 2000, 2008,          # History
  2012, 2017, 2020,          # Science
  1985, 1998, 2003,          # Literature
  2007, 2014, 2016           # Social Sciences
)

item_ids <- sprintf("IT%03d", seq_along(titles))

patron_types  <- c("Undergraduate", "Graduate", "Faculty", "Community")
checkout_years  <- 2018:2022
checkout_months <- 1:12

rows <- list()
for (i in seq_along(titles)) {
  for (yr in checkout_years) {
    for (mo in checkout_months) {
      # Generate plausible checkout counts with seasonality
      base_count <- sample(1:8, 1)
      # Boost Sep-Dec (academic semester) and Jan-May
      season_mult <- if (mo %in% c(1:5, 9:12)) 1.5 else 0.8
      n_checkouts <- max(0L, round(base_count * season_mult) +
                           sample(-1:2, 1))

      patron <- sample(patron_types, 1,
                       prob = c(0.45, 0.30, 0.15, 0.10))
      rows[[length(rows) + 1]] <- data.frame(
        item_id        = item_ids[i],
        title          = titles[i],
        subject        = subjects[i],
        pub_year       = pub_years[i],
        patron_type    = patron,
        checkout_month = mo,
        checkout_year  = yr,
        checkouts      = as.integer(n_checkouts),
        stringsAsFactors = FALSE
      )
    }
  }
}

circ_sample <- do.call(rbind, rows)
circ_sample$subject     <- as.factor(circ_sample$subject)
circ_sample$patron_type <- as.factor(circ_sample$patron_type)

# Save to data/ directory
usethis::use_data(circ_sample, overwrite = TRUE)
message("circ_sample dataset saved to data/circ_sample.rda")
