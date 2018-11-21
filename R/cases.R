#' Get cases for an \code{Oyez} object
#'
#' @param x the Oyez object
#' @param ... other arguments
#'
#' @export
cases <- function(x, ...){
    UseMethod('cases')
}
