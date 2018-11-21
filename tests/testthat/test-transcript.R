context("test-transcript.R")


with_mock_api({
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
})
