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
#' Gets multiple oyez cases for analysis. The input, x, can be either a data.frame with columns
#' \code {term} and \code{docket_number}, or a list of lists, with each sublist containing fields
#' named \code {term} and \code{docket_number}
#'
#'
#' @param x a data.frame or list
#' @param ... other arguments passed on to methods
#'
#' @return an OyezCaseList object
#'
#' @examples
#' \dontrun{
#'  df <- data.frame(
#'      term = c("2014", "2014", "2000"),
#'      docket_number = c("13-1175", "13-1499", "00-949")
#'  )
#'  oyez_cases(df)
#'
#'  lst <- list(
#'        list(
#'            term = "2014",
#'            docket_number = "13-1175"
#'        ),
#'        list(
#'            term = "2014",
#'            docket_number = "13-1499"
#'        ),
#'        list(
#'            term = "2000",
#'            docket_number = "00-949"
#'        )
#'    )
#'  oyez_cases(lst)
#' }
#'
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
    # turns inevitable factors to characters
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
