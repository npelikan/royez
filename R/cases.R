#' Get cases for an \code{oyez} object
#'
#' @param x the oyez object
#' @param ... other arguments
#'
#' @export
cases <- function(x, ...){
    UseMethod('cases')
}
