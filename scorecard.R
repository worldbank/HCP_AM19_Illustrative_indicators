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
    "\\cellcolor{iceberg}HD FY 20 Lending Program",
    "USD (million)",
    "Percentage of total",
    "Diff. with perc. for regional average",
    "Diff. with perc. for income group avg",
    "\\cellcolor{iceberg}HD Performance",
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
    "\\cellcolor{iceberg}Other indicators",
    "Average project size (PS) (USD mill.)",
    "Difference with PS for region",
    "Difference with PS for income group",
    "Perc. of portfolio that is co-TTL'd (CTT)",
    "Diff. with CTT for region (perc. points)",
    "Diff. with CTT income group (perc. points)"
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
rl <- rows_lab()   # rows labels

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

