#' Gets transcripts for OyezCase objects, or OyezCaseLists
#'
#' @param x an OyezCase or OyezCaseList object
#' @param ... other arguments passed on to methods
#'
#' @return a Transcript or TranscriptList object
#' @export
#'
#' @examples
#' \dontrun{
#' a <- oyez_case(term = 2014, docket_number='13-1175')
#' transcript(a)
#' }
transcript <- function(x, ...){
    UseMethod('transcript')
}

#' @rdname transcript
#' @export
transcript.OyezCase <- function(x, ...){

}



# TRANSCRIPT GETTERS

#' @importFrom httr GET content
#' @importFrom purrr map_chr map
transcript_ <- function(case){
    t_locs <- purrr::map_chr(case[['oral_argument_audio']], 'href')

    t_raw <- purrr::map(t_locs, function(x){
        httr::content(httr::GET(x))
    })
}
