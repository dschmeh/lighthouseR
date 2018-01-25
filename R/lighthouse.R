#' Lighthouse Function
#'
#' This function allows you to retrive Lighthouse Data.
#' Lighthouse will analyze the Page you specific in the request. Lighthouse will open a new Chrome Window and run various tests.
#' The output you will get consists of 5 numeric values: Progressive Web App, Performance, Accessibility, Best Practices, SEO. Each a number between 0 (very bad) and 100 (perfect).
#' Additional to this you will get a HTML-file in your Workspace containing all results of the Lighthouse test. So you can have a deeper look in various parts.
#' @param page The Page you want to get analyzed by Lighthouse
#' @param view Logical. Do you want to open the HTML-File after the run? Default is FALSE.
#' @param keepFile Logical. Lighthouse generates a HTML-File with the results and saves it in your Workspace every Time you run it. If you don´t want this set keepFile to FALSE. Default is TRUE.
#' lighthouse()
#' @examples
#' \dontrun{
#' lighthouse("https://www.r-project.org/")
#' }



lighthouse <- function(page,
                       view = FALSE,
                       keepFile = TRUE) {
  #Check the Page input if the URL is correct and includes scheme
  if (!isTRUE(grepl("http", page))) {
    warning("Scheme (http/https) in the URL is missing")
  }
  #Check for the correct Lighthouse-Versions
  ver <- system("lighthouse --version", intern = TRUE)
  if (ver[1] < 2.7) {
    warning("Please Update your Lighthouse Version to 2.7 or higher")
  }
  if (!is.logical(view)) {
    stop("The view should be a logical input")
  }
  #TODO: Add more Error Monitoring

  #Call the lighthouse module
  page_path <- gsub("http(s)?\\:\\/\\/", "", page)
  path <-
    paste0(
      "./",
      gsub("\\/$","",page_path),
      "_",
      Sys.Date(),
      "_",
      format(Sys.time(), "%H_%M_%S"),
      ".report.html"
    )

  sys_call <-
    paste0("lighthouse ",
           page ,
           " --output-path ",
           path,
           " --chrome-flags='--headless'",
           if (view == TRUE) {
             " --view"
           })
  s <- system(sys_call, intern = TRUE)

  rawHTML <- paste(readLines(path), collapse = "\n")

  #Get the Scores out of the HTML-File
  scores <-
    t(as.data.frame(
      stringr::str_extract_all(
        rawHTML,
        '.(accessibility|best-practices|pwa|performance|seo).,.score.\\:[0-9]{1,3}\\.?[0-9]{0,2}'
      )
    ))
  scores <-
    as.data.frame(
      gsub(
        '"(accessibility|best-practices|pwa|performance|seo)","score":',
        '',
        scores
      )
    )
  scores$Page <- as.character(page)
  output <- paste0(getwd(), gsub("\\.\\/", "\\/", path))
  if (isTRUE(keepFile)) {
    scores$fullReport <- as.character(output)
  }
  colnames(scores) <-
    c(
      "Progressive_Web_App",
      "Performance",
      "Accessibility",
      "Best_Practices",
      "SEO",
      "Page",
      if (isTRUE(keepFile)) {
        "fullReport"
      }
    )
  rownames(scores) <- "1"

  if (!isTRUE(keepFile)) {
    file.remove(output)
  }

  return(scores)
}
