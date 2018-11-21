#' Gets transcripts for OyezCase objects or OyezCaseLists
#'
#' @param x an OyezCase or OyezCaseList object
#' @param ... other arguments passed on to methods
#'
#' @return an OyezTranscript or OyezTranscriptList object
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
    transcript_(x)
}

#' @rdname transcript
#' @importFrom purrr map
#' @export
transcript.OyezCaseList <- function(x, ...){
    out <- purrr::map(x, transcript_)
    class(out) <- "OyezTranscriptList"
    out
}


# TRANSCRIPT GETTERS

#' @importFrom httr GET content
#' @importFrom purrr map_chr map flatten
transcript_ <- function(case){
    case_name <- case[['name']]
    t_locs <- purrr::map_chr(case[['oral_argument_audio']], 'href')

    t_raw <- purrr::map(t_locs, function(x){
        httr::content(httr::GET(x))
    })

    t_names <- purrr::map_chr(t_raw, 'title')
    t_turns <- purrr::map(t_raw, function(x){
        purrr::flatten(purrr::map(x[['transcript']][['sections']], "turns"))
    })
    names(t_turns) <- t_names

    out <- list(sections = t_turns,
                case_name = case_name)
    class(out) <- 'OyezTranscript'

    out
}
