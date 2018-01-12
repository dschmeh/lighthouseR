#' Lighthouse_install Function
#'
#' This function allows you to install Lighthouse on your lovcal machine.
#' lighthouse_install()
#' @examples{
#' lighthouse_install()
#' }


lighthouse_install <- function() {
  #System Call to install lighthouse on the local machine
  system("npm install -g lighthouse")
}
