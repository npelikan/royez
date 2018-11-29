context("test-OyezTranscript_methods.R")

with_mock_api({
    test_that("data.frame of correct names is generated", {
        a <- oyez_case(term = 2014, docket_number = "13-1175")
        t <- transcript(a)
        df <- as.data.frame(t)
        expect_is(df, "data.frame")
        expect_named(df, c("sequence", "speaker_name", "text", "section"),
                     ignore.order = T)
        expect_equal(nrow(df), 348)
    })
})

