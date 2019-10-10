
#----------------------------------------------------------
#   Set up
#----------------------------------------------------------

# Load libraries
library(tidyverse)

# Sub Functions
source("scorecard_func.R")

#----------------------------------------------------------
#   Load data
#----------------------------------------------------------

#--- HCI
hci <- haven::read_dta("input/textforscorecard.dta")

#---- Row labels of table
rl <- rows_lab()   # rows labels

#---- colors of table (Table Values)
f <- read_csv("static/table_conditions.csv")
f$cond <- paste0("terc_", f$ori)

#--- variables that go in the table
tvars <- read_csv("static/table_vars.csv")


#----------------------------------------------------------
#   Modify data
#----------------------------------------------------------

# Fix formatting

two_dig <- grep("^.*performance.*diffm", tvars$name)
zero_dig <- tvars$name[-two_dig]

diff_vars <- grep("diff", tvars$name, value = TRUE)

hci <- hci %>%
  mutate_at(tvars$name, chg_fmt, digits = 2) %>%
  mutate_at(zero_dig, chg_fmt, digits = 0) %>%
  mutate_at(diff_vars, ~ifelse(grepl("^(\\-|\\.)",.), .,
                               paste0("+", .)))


# Colors of cells in Table
tv <- apply(f, 1, color_cell, df = hci)
colnames(tv) <- f$ori
tv <- as_tibble(tv)

# remove old variables and add the new ones
hci <- hci[ , !(names(hci)  %in% f[["ori"]])]
hci <- cbind(hci, tv)


#----------------------------------------------------------
#   Create two-pagers
#----------------------------------------------------------

# select version of document
ver <- "afr"
ver <- "wld"
if (ver == "afr") {
  hci <-  hci %>% filter(wbregion == "Sub-Saharan Africa")
}


# select countries
countries <- c("COL", "ARG")
countries <- c("IND")


countries <- c("ETH")
countries <- NULL
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




























