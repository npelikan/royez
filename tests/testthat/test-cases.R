context("test-cases.R")

with_mock_api({
    test_that("returns cases for single advocate", {
        a <- oyez_case(term = 2014, docket_number='13-1175')
        ads <- advocates(a)
        cl <- cases(ads[[1]])
        expect_s3_class(cl, 'OyezCaseList')
        expect_length(cl, 18)
        expect_s3_class(cl[[1]], 'OyezCase')
    })

})
