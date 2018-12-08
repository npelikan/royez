#' Get cases for an \code{Oyez} object
#'
#' @param x the Oyez object
#' @param ... other arguments passed on to methods
#'
#' @return an object of class OyezCaseList
#'
#' @export
cases <- function(x, ...){
    UseMethod("cases")
}

#' @rdname cases
#' @export
cases.OyezAdvocate <- function(x, ...){
    get_advocate_cases_(x)
}

#' @rdname cases
#' @export
cases.OyezAdvocateList <- function(x, ...){
    out <- purrr::flatten(purrr::map(x, get_advocate_cases_))
    class(out) <- "OyezCaseList"
    out
}


## helper functions
#' @keywords internal
#' @importFrom glue glue
#' @importFrom httr content GET
#' @importFrom purrr map
#' @include oyez_case.R
get_advocate_cases_ <- function(adv){
    adv_name <- adv$advocate$name

    case_endpoint <- glue::glue("{adv$advocate$href}/cases")

    adv_case_endpoints <- purrr::map(
        httr::content(httr::GET(case_endpoint)),
        "href"
        )

    adv_cases <- purrr::map(adv_case_endpoints, get_oyez_case_)

    class(adv_cases) <- "OyezCaseList"
    adv_cases
}
