context("test-oyez_case.R")

with_mock_api({
    test_that("a correct file is exported", {
        out <- oyez_case(term = '2014', docket_number = '13-1175')
        expect_s3_class(out, 'OyezCase')
        expect_equal(out$ID, 56058)
    })

    test_that("bad searches invoke a stop", {
        expect_error(oyez_case(term = '2014', docket_number = 'barf'))
    })
})

