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
    if(!hasName(res, 'ID')){
        stop("No case found with that identifier.", call. = FALSE)
    }

    class(res) <- "OyezCase"
    res
}
