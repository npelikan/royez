context("test-transcript.R")


with_mock_api({

    ## single case
    c <- oyez_case(term = 2014, docket_number='13-1175')
    trans <- transcript(c)

    test_that("correct class passed", {
        expect_s3_class(trans, "OyezTranscript")
    })

    test_that("correct length and names", {
        expect_length(trans, 2)
        expect_named(trans, c("sections", "case_name"))
    })

    test_that("correct case name and argument name", {
        expect_named(trans$sections, "Oral Argument - March 03, 2015")
        expect_equal(trans$case_name, "City of Los Angeles v. Patel")
    })

    test_that("correct number of turns parsed", {
        expect_length(trans$sections[[1]], 348)
    })

    ## multiple cases
    good_df <- data.frame(
        term = c("2014", "2000"),
        docket_number = c("13-1175", "00-949")
    )
    cl <- oyez_cases(good_df)
    tl <- transcript(cl)

    test_that("correct object types returned", {
        expect_s3_class(tl, "OyezTranscriptList")
        expect_s3_class(tl[[1]], "OyezTranscript")
    })

    test_that("correct number of items returned", {
        expect_length(tl, 2)
    })
})
