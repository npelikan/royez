#' Converts an OyezTranscript object into a data.frame
#'
#' @param x an OyezTranscript object
#' @param ... other arguments passed on to methods
#'
#' @return a data.frame object
#'
#' @examples
#' \dontrun{
#' a <- oyez_case(term = 2014, docket_number='13-1175')
#' t <- transcript(a)
#' as.data.frame(t)
#' }
#' @export
as.data.frame.OyezTranscript <- function(x, ...){

   unpack_sections_(x)
}

#' @importFrom purrr map2_dfr
unpack_sections_ <- function(x){
    pt <- purrr::map2_dfr(x[["sections"]], names(x[["sections"]]),
                          function(sec, secnm){

                              td <- purrr::map2_dfr(sec, 1:length(sec),
                                                    unpack_turns_)
                              td$section <- secnm
                              td
                          })
}

#' @importFrom purrr map_chr
unpack_turns_ <- function(t, n){
    sn <- t[["speaker"]][["name"]]

    tx <- paste(purrr::map_chr(t[["text_blocks"]], "text"),
                collapse = " ")

    data.frame(sequence = n,
               speaker_name = sn,
               text = tx,
               stringsAsFactors = F)
}
