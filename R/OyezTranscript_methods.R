
#' @importFrom purrr map map_dfr pmap_dfr
as.data.frame.OyezTranscript <- function(x){
    pt <- purrr::map_dfr(x[['sections']], function(sec){

        purrr::map2_dfr(sec, names(sec),
                        unpack_turns_)
    })
    pt
}

#' @importFrom map2_dfr map_chr
unpack_turns_ <- function(turns, nm){
    td <- purrr::map2_dfr(turns, 1:length(turns), function(t, n){
        sn <- t[['speaker']][['name']]

        tx <- purrr::map_chr(t[['text_blocks']], 'text')

        data.frame(sequence = n,
                   speaker_name = sn,
                   text = tx,
                   stringsAsFactors = F)
    })

    td$section <- nm
    td
}
