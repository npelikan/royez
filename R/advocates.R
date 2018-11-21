#' Get advocates for an \code{Oyez} object
#'
#' @param x the Oyez object
#' @param ... other arguments passed on to methods
#'
#' @return an object of class OyezAdvocateList
#'
#' @export
advocates <- function(x, ...){
    UseMethod('advocates')
}

#' @rdname advocates
#' @export
advocates.OyezCase <- function(x, ...){
    get_advocates_(x)
}


#' @rdname advocates
#' @importFrom purrr map flatten
#' @export
advocates.OyezCaseList <- function(x, ...){
    out <- purrr::flatten(purrr::map(x, get_advocates_))
    class(out) <- "OyezAdvocateList"
    out
}


## helper functions
#' @importFrom purrr map
get_advocates_ <- function(case){
    case_ads <- case$advocates

    ## saves case name/term/docket # to advocates for later use
    out <- purrr::map(case_ads, function(z){
        z$case_name <- case$name
        z$term <- case$term
        z$docket_number <- case$docket_number
        class(z) <- "OyezAdvocate"
        z
    })

    class(out) <- "OyezAdvocateList"
    out
}
