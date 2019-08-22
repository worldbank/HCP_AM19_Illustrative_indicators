
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

countries <- NULL
countries <- c("ETH")
countries <- c("ETH", "COL")
if (length(countries) > 0) {
  hci <-  hci[hci[["wbcode"]]  %in% countries,]
}

y <- apply(hci, 1, RunMD)

# Delete and copy files
dc_files()
