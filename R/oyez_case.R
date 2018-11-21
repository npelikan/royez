#' Get a single Oyez Case
#'
#' @param term the term
#' @param docket_number the docket number
#'
#' @return
#'
#' @examples
#' \dontrun{oyez_case(term = 2014, docket_number='13-1175')}
#'
#' @importFrom glue glue
#' @importFrom httr content GET
#'
#' @export
oyez_case <- function(term, docket_number){

    res <- httr::content(httr::GET(glue::glue("https://api.oyez.org/cases/{term}/{docket_number}")))

    ## stops if unnamed
    if(!'ID' %in% names(res)){
        stop("No case found with that identifier.", call. = FALSE)
    }

    class(res) <- "OyezCase"
    res
}




#' Get multiple oyez cases
#'
#'
#'
#' @param x a data.frame or list
#' @param ...
#'
#' @return an OyezCaseList object
#' @export
oyez_cases <- function(x, ...){
    UseMethod('oyez_cases')
}


#' @rdname oyez_cases
#' @importFrom purrr pmap modify_if
#' @export
oyez_cases.data.frame <- function(x, ...){
    if (any(!c("term", "docket_number") %in% names(x))) {
        stop('data.frame inputs to `oyez_cases()` must contain columns term and docket_number',
             call. = F)
    }
    # turns factors to characters
    x <- purrr::modify_if(x, is.factor, as.character)
    out <- purrr::pmap(x, oyez_case)
    class(out) <- "OyezCaseList"
    out
}


#' @rdname oyez_cases
#' @importFrom purrr map
#' @export
oyez_cases.list <- function(x, ...){

    get_cases_ <- function(i){
        if (any(!c("term", "docket_number") %in% names(i))) {
            stop('list inputs to `oyez_cases()` must be a list of lists \n
                 with all sublists containing fields term and docket_number',
                 call. = F)
        }

        oyez_case(term = i$term, docket_number = i$docket_number)
    }

    out <- purrr::map(x, get_cases_)
    class(out) <- "OyezCaseList"
    out
}
