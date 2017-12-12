#' Lighthouse Function
#'
#' This function allows you to retrive Lighthouse Data.
#' Lighthouse will analyze the Page you specific in the request. Lighthouse will open a new Chrome Window and run various tests.
#' The output you will get consists of 4 numeric values: Progressive Web App, Performance, Accessibility, Best Practices. Each a number between 0 (very bad) and 100 (perfect).
#' Additional to this you will get a HTML-file in your Workspace containing all results of the Lighthouse test. So you can have a deeper look in various parts.
#' @page The Page you want to get analyzed by Lighthouse
#' lighthouse()



lighthouse <- function(page) {
  #Check the Page input if the URL is correct and includes scheme
  if (isTRUE(grepl("http", page))) {

  } else {
    warning("Scheme (http/https) in the URL is missing")
  }

#TODO: Add more Error Monitoring

  #Call the lighthouse module

  sys_call <- paste0("lighthouse ", page)
  s <- system(sys_call, intern = TRUE)

  #Find the file where we can see the ouptut

  output <- s[grep("GMT Printer domhtml output written to", s)]
  output <-
    gsub(".* GMT Printer domhtml output written to ", "", output)
  doc <- stringr::str_split(output, "\\\\")
  doc <- doc[[1]][nrow(as.data.frame(unlist(doc)))]

  #Load the file with the Lighthouse Output

  rawHTML <- paste(readLines(doc), collapse = "\n")

  #Get the Scores out of the HTML-File
  scores <-
    t(as.data.frame(
      stringr::str_extract_all(rawHTML, '.score.\\:[0-9]{1,2}\\.[0-9]{0,2}')
    ))
  scores <- as.data.frame(gsub('"score":', '', scores))
  if (ncol(scores) > 4) {
    scores <- subset(scores, select = -c(V1))
  }
  scores$Page <- as.data.frame(page)
  scores$fullReport <- as.data.frame(output)
  colnames(scores) <-
    c(
      "Progressive_Web_App",
      "Performance",
      "Accessibility",
      "Best_Practices",
      "Page",
      "fullReport"
    )
  rownames(scores) <- "1"
  return(scores)
}
