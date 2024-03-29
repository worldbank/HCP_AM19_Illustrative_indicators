
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

RunMD <- function(x, ver) {

  if (!(ver  %in% c("afr", "wld"))) {
    stop("option `ver` should be either 'wld' or 'afr'")
  }

  countrynamet <- x[["wbcountryname"]]

  if (ver  == "afr") {
    base_name <- "AFR_HC_scorecard"
    input <- "scorecard_Africa.Rmd"

  } else {
    base_name <- "HC_indicators"
    input <- "illustrative_indicators.Rmd"
  }

  file_name <- paste0(base_name, "_", x[["wbcode"]], ".pdf")

  result <-  tryCatch({
    rmarkdown::render(
      input = input,
      output_format = "pdf_document",
      output_file = file_name,
      #output_dir = base_name,
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

dc_files <- function(ver) {


  if (!(ver  %in% c("afr", "wld"))) {
    stop("option `ver` should be either 'wld' or 'afr'")
  }

  if (ver  == "afr") {
    base_name <- "AFR_HC_scorecard"
  } else {
    base_name <- "HC_indicators"
  }

  # check if region folder exists
  reg_dir <- hci %>%
    count(wbregion) %>%
    transmute(dir = paste0(base_name, "/", wbregion),
              dir_e = dir.exists(dir))

  lapply(reg_dir$dir[!reg_dir$dir_e], dir.create, showWarnings = FALSE)

  # copy PDFs
  x <- hci %>%
    transmute(file = paste0(base_name, "_", wbcode ,".pdf"),
              dir = paste0(base_name, "/", wbregion))


  walk2(x$file, x$dir, ~file.copy(from = .x,
                                to = .y,
                                overwrite = TRUE))

  file.remove(x$file)

  #--------- copy failed log files

  aux_log <- list.files(pattern = "\\.log$")
  file.copy(from = aux_log, to = "failed_log", overwrite = TRUE)

  #--------- remove aux files

  aux_files <- list.files(pattern = "\\.(log|aux|out)$")
  file.remove(aux_files)


  #--------- move one-pager for whole world pdfs to another folder

  if (ver  == "wld") {
    p <- page_df(ver) # data frame with countries and pages

    f <- p %>%
      filter(pages == 1) %>%
      pull(country) %>%
      paste(collapse =  "|")

    one_page <- list.files(path = base_name,
                           pattern = paste0( base_name, "_(", f,")\\.pdf$"),
                       include.dirs = TRUE,
                       recursive = TRUE)
    one_page <- paste0(base_name,"/",one_page)

    if (length(one_page)) {
      s <- map_lgl(one_page, ~file.copy(from = .x,
                                to = "one_page",
                                overwrite = TRUE))
      one_page <- one_page[s]
      file.remove(one_page)
    }

  }
}




# beautify output of numbers in table ------------------------------------------

chg_fmt <- function(x, digits = 2, fmt = "f", b = ",") {

  if (typeof(x) == "character") {
    x <- as.numeric(gsub(",", "", x))
  }

  ifelse(is.na(x), ".",
         formatC(x, digits = digits, format = fmt,  big.mark = b))
}



#--------- identify number of pages in pdf


c_page <- function(x) {
  t <- tibble(
    pages = pdf_info(x)[[2]],
    country = str_replace( x, ".*([A-Z]{3})\\.pdf", "\\1")
  )
  return(t)
}

page_df <- function(ver) {

  if (ver  == "afr") {
    pattern = "AFR_HC_scorecard_.*pdf$"
  } else {
    pattern = "HC_indicators_.*pdf$"
  }


  file <- list.files(pattern = pattern,
                     include.dirs = TRUE,
                     recursive = TRUE)
  p <- map_dfr(file, c_page)
  return(p)
}

