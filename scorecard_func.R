
#----------------------------------------------------------
#   Subfunctions
#----------------------------------------------------------



# labels of table rows ---------------------------------------------------------

rows_lab <- function(){
  x <- c(
    "\\textbf{World Bank Investments in HD} & \\textbf{} & \\textbf{} & \\textbf{} & \\textbf{}",
    "\\textbf{Indicator} & \\textbf{HD} & \\textbf{Edu} & \\textbf{HNP} & \\textbf{SPJ}",
    "\\cellcolor{iceberg}HD Portfolio & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg}",
    "USD (million)",
    "\\textbf{\\% of total}",
    "Diff. from regional average \\%",
    "Diff. from income group avg \\%",
    "\\cellcolor{iceberg}HD FY 20 Lending Program & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg}",
    "USD (million)",
    "\\textbf{\\% of total}",
    "Diff. from regional average \\%",
    "Diff. from income group avg \\%",
    "\\cellcolor{iceberg}HD Performance & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg}",
    "\\textbf{Average Development Outcome}",
    "Diff. from regional average \\%",
    "Diff. from income group avg \\%",
    "\\% Satisfactory DO",
    "\\textbf{Average Implementation Progress}",
    "Diff. from regional average \\%",
    "Diff. from income group avg \\%",
    "\\% Satisfactory IP",
    "\\textbf{Disbursement ratio}",
    "Diff. from regional average \\%",
    "Diff. from income group avg \\%",
    "\\cellcolor{iceberg}Other indicators & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg} & \\cellcolor{iceberg}",
    "\\textbf{Average project size (USD mill.)}",
    "Diff. from regional average \\%",
    "Diff. from income group avg \\%",
    "\\textbf{\\% of portfolio that is co-TTL'd}",
    "Diff. from regional average \\%",
    "Diff. from income group avg \\%"
  )
  return(x)
}



# Color assignment -------------------------------------------------------------

color_cell <-  function(f, df) {
  z <- f[[1]]
  y <- f[[2]]

  x <- dplyr::case_when(
    df[[y]] == 1 ~ paste("\\cellcolor{blush}", df[[z]]),
    df[[y]] == 2 ~ paste("\\cellcolor{arylideyellow}", df[[z]]),
    df[[y]] == 3 ~ paste("\\cellcolor{asparagus}", df[[z]]),
    is.na(df[[y]])   ~ paste(df[[z]]),
    is.null(df[[y]]) ~ paste(df[[z]]),
    TRUE             ~ paste(df[[z]])
  )

  return(x)
}


# Run rmarkdown ----------------------------------------------------------------

RunMD <- function(x) {
  file_name <- paste0("scorecard_", x[["wbcode"]])
  countrynamet <- x[["wbcountryname"]]

  if (x[["adminregion"]] == "SSA") {
    input <- "scorecard_Africa.Rmd"
  } else {
    input <- "scorecard_row.Rmd"
  }

  result <-  tryCatch({
    rmarkdown::render(
      #input = "scorecard.Rmd",
      input = input,
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


# Delete and copy files --------------------------------------------------------

dc_files <- function() {
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
}




# beautify output of numbers in table ------------------------------------------

chg_fmt <- function(x, digits = 2, fmt = "f", b = ",") {

  if (typeof(x) == "character") {
    x <- as.numeric(gsub(",", "", x))
  }

  ifelse(is.na(x), ".",
         formatC(x, digits = digits, format = fmt,  big.mark = b))
}

