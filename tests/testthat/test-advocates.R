context("test-advocates.R")

with_mock_api({
    test_that("advocates parse and a correct number is retrieved for a single case", {
        a <- oyez_case(term = 2014, docket_number='13-1175')
        ads <- advocates(a)
        expect_s3_class(ads, "OyezAdvocateList")
        expect_length(ads, 3)
        expect_s3_class(ads[[1]], "OyezAdvocate")
    })

    test_that("addons are correctly inserted", {
        a <- oyez_case(term = 2014, docket_number='13-1175')
        ads <- advocates(a)
        expect_equal(ads[[1]]$case_name, "City of Los Angeles v. Patel")
        expect_equal(ads[[1]]$term, "2014")
        expect_equal(ads[[1]]$docket_number, '13-1175')
    })


    test_that("advocates parse and a correct number is retrieved for multiple cases", {
        good_df <- data.frame(
            term = c("2014", "2014", "2000"),
            docket_number = c("13-1175", "13-1499", "00-949")
        )
        a <- oyez_cases(good_df)
        ads <- advocates(a)
        expect_s3_class(ads, "OyezAdvocateList")
        expect_length(ads, 8)
        expect_s3_class(ads[[1]], "OyezAdvocate")
    })
})
