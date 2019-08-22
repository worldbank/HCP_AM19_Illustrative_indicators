#----------------------------------------------------------
#   libraries
#----------------------------------------------------------

library(tidyverse)



#----------------------------------------------------------
#   Sub Functions
#----------------------------------------------------------

rows_lab <- function(){
  x <- c(
    "\\textbf{World Bank Investments in HD} & \\textbf{} & \\textbf{} & \\textbf{} & \\textbf{}",
    "\\textbf{Indicator} & \\textbf{HD} & \\textbf{Edu} & \\textbf{HNP} & \\textbf{SPJ}",
    "\\cellcolor{iceberg}HD Portfolio & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg}",
    "USD (million)",
    "Percentage of total",
    "Diff. with perc. for regional average",
    "Diff. with perc. for income group avg",
    "\\cellcolor{iceberg}HD FY 20 Lending Program & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg}",
    "USD (million)",
    "Percentage of total",
    "Diff. with perc. for regional average",
    "Diff. with perc. for income group avg",
    "\\cellcolor{iceberg}HD Performance & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg}",
    "Average Development Outcome (DO)",
    "Difference with DO for region",
    "Difference with DO for income group",
    "Perc. Satisfactory DO",
    "Average Implementation Progress (IP)",
    "Difference with IP for region",
    "Difference with IP for income group",
    "Perc. Satisfactory IP",
    "Disbursement ratio (DR)",
    "Difference with DR for region",
    "Difference with DR for income group",
    "\\cellcolor{iceberg}Other indicators & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg}",
    "Average project size (PS) (USD mill.)",
    "Difference with PS for region",
    "Difference with PS for income group",
    "Perc. of portfolio that is co-TTL'd (CTT)",
    "Diff. with CTT for region (perc. points)",
    "Diff. with CTT income group (perc. points)"
  )
  return(x)
}

color_con <-  function(f, df) {
  z <- f[[1]]
  y <- f[[2]]
  df[[z]] <- signif(df[[z]], digits = 3)  # rounding

  x <- dplyr::case_when(
    df[[y]] == 1 ~ paste("\\cellcolor{blush}", df[[z]]),
    df[[y]] == 2 ~ paste("\\cellcolor{arylideyellow}", df[[z]]),
    df[[y]] == 3 ~ paste("\\cellcolor{asparagus}", df[[z]]),
    is.na(y) ~ "",
    is.null(y) ~ "",
    TRUE ~ ""
  )

  return(x)
}




RunMD <- function(x) {
  file_name <- paste0("scorecard_", x[["wbcode"]])

  result <-  tryCatch({
    rmarkdown::render(
      input = "scorecard.Rmd",
      #input = "test/test.Rmd",
      output_format = "pdf_document",
      output_file = paste0(file_name, ".pdf"),
      output_dir = "output/",
      intermediates_dir = "failed_log"
    )

    r <- c(x[["wbcode"]], "OK")

  }, warning = function(w) {
    r <- c(x[["wbcode"]], "warning", w)
    return(r)

  }, error = function(e) {
    r <- c(x[["wbcode"]], "error", e)
    return(r)
  }, finally = {
    print(paste(x[["wbcode"]], x[['wbcountrynameb']], "- Done.", sep = " "))
  })

  return(result)

}

#----------------------------------------------------------
#   Initional parameters
#----------------------------------------------------------

hci <- haven::read_dta("input/textforscorecard.dta")


#---- Row labels of table
rl <- rows_lab()   # rows labels

#---- colors of table (Table Values )
f <- read_csv("static/table_conditions.csv")
f$cond <- paste0("terc_", f$ori)


tv <- apply(f, 1, color_con, df = hci)
colnames(tv) <- f$ori
tv <- as_tibble(tv)
s <- hci[-names(tv)]
s <- cbind(tv, hci[["wbcode"]])

countries <- NULL
countries <- c("ETH", "COL")
countries <- c("ETH")
if (length(countries) > 0) {
  hci <-  hci[hci[["wbcode"]]  %in% countries,]
}

y <- apply(hci, 1, RunMD)


#----------------------------------------------------------
#   Delete and copy files aux files
#----------------------------------------------------------


#--------- copy pdf files and delete them from root

pdf_file <- list.files(pattern = "scorecard_.+\\.pdf$")
x <- file.copy(from = pdf_file, to = "output", overwrite = TRUE)

pdf_file <- pdf_file[x]
file.remove(pdf_file)

#--------- copy failed log files

aux_log <- list.files(pattern = "\\.log$")
file.copy(from = aux_log, to = "failed_log", overwrite = TRUE)

#--------- remove aux files

aux_files <- list.files(pattern = "\\.(log|aux|out)$")
file.remove(aux_files)

