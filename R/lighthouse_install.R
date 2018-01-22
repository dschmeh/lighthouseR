#' Lighthouse_install Function
#'
#' This function allows you to install Lighthouse on your local machine.
#' @param prefix You can specify where you want Lighthouse to installed on your machine.
#' lighthouse_install()
#' @examples
#' \dontrun{
#' lighthouse_install()
#' }


lighthouse_install <- function(prefix = "") {
  #System Call to install lighthouse on the local machine
  #Check if Lighthouse and correct Version is allready installed
  ver <- system("lighthouse --version", intern = TRUE)
  if (ver[1] < 2.7) {
    choice <-
      utils::menu(c("Y", "N"), title = "Are you sure you want to install Lighthouse on your machine?")
    if (choice == 1) {
      if (prefix == "") {
        system("npm install -g lighthouse")
      } else {
        system(paste0("npm install --prefix ", prefix, "-g lighthouse"))
      }
      install_test <- system("lighthouse --version", intern = TRUE)
      if (install_test[1] < 2.7) {
        return(
          "Something went wrong! Please check if your Computer is able to install Node Modules."
        )
      }
      return("Lighthouse succesfully installed")
    } else {
      return("Installation of Lighthouse aborted")
    }
  }
  return("The correct Lighthouse Version is allready installed")
}
