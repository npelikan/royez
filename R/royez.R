#' royez
#'
#' royez allows for interaction with the Oyez API in R
#'
#' @docType package
#' @name royez
NULL

#' @importFrom utils packageVersion
.onLoad <- function(lib, pkgname = "royez"){
    dev_warning_(utils::packageVersion(pkgname))
}

dev_warning_ <- function(version){
    if (version == '0.0.0.9000'){
        message("The version of royez you are using is a pre-release, development version.\n",
                "Functionality may be removed, function names may change, and outputs may differ in future releases.\n",
                "Use at your own risk.\n")
    }
}
