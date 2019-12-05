
#----------------------------------------------------------
#   Set up
#----------------------------------------------------------

# Load libraries
library(tidyverse)
library(pdftools)

# Sub Functions
source("illustrative_indicators_func.R")

#----------------------------------------------------------
#   Load data
#----------------------------------------------------------

#--- HCI
hci <- haven::read_dta("input/text_for_illustrative_indicators.dta")

#----------------------------------------------------------
#   Create two-pagers
#----------------------------------------------------------

# select version of document

ver <- "wld"

# select countries
countries <- c("COL", "ARG")
countries <- c("IND")

# Select countries based on the word 'the'
# countries <- countries[["wbcode"]]
countries <- hci %>%
  filter(str_detect(wbcountrynameb, "^the ")) %>% # countries that start with the
  pull(wbcode)

countries <- c("LKA", "NPL")



countries <- hci %>%
  filter(str_detect(wbcountryname, "[À-ÿ]")) %>% # find letters and vocal with accents
  pull(wbcode)

# select countries based on number of pages
pages <- 0
if (pages == 1) {
  p <- page_df(ver) # data frame with countries and pages

  countries <- p %>%
    filter(pages == 3) %>%
    pull(country)
}

countries <- NULL # move this one right before condition (length(countries) > 0)
countries <- c("COL")
if (length(countries) > 0) {
  hci <-  hci %>% filter(wbcode  %in% countries)
}

# execute creation of pdf
y <- apply(hci, 1, RunMD, ver = ver)


## Show countries with error
e <- tibble::tibble(code = rep(NA, length(y)), m = rep(NA, length(y)))

for (i in seq_along(y)) {
  e[i,] <- c(y[[i]][[1]], y[[i]][[2]])
}
err <- e[(e$m == "error"),1]
print(err, n = nrow(err))

err  <- as_vector(err)
names(err) <- NULL
err

# Delete and copy files
dc_files(ver)




























