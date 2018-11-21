#' Get cases for an \code{Oyez} object
#'
#' @param x the Oyez object
#' @param ... other arguments passed on to methods
#'
#' @return an object of class OyezCaseList
#'
#' @export
cases <- function(x, ...){
    UseMethod('cases')
}

#' @rdname cases
#' @export
cases.OyezAdvocate <- function(x, ...){
    get_advocate_cases_(x)
}


## helper functions
#' @importFrom glue glue
#' @importFrom httr content GET
get_advocate_cases_ <- function(adv){
    adv_name <- adv$advocate$name

    case_endpoint <- glue::glue("{adv$advocate$href}/cases")

    adv_cases <- httr::content(httr::GET(case_endpoint))
    class(adv_cases) <- "OyezCaseList"
    adv_cases
}
