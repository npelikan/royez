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


    ## mutliple cases!

    ## data.frame ingest
    good_df <- data.frame(
        term = c("2014", "2014", "2000"),
        docket_number = c("13-1175", "13-1499", "00-949")
    )

    test_that("dataframe parse creates expected object", {
        df_out <- oyez_cases(good_df)
        expect_s3_class(df_out, "OyezCaseList")
        expect_length(df_out, 3)
    })

    good_df_nofactor <- data.frame(
        term = c("2014", "2014", "2000"),
        docket_number = c("13-1175", "13-1499", "00-949"),
        stringsAsFactors = F
    )

    test_that("dataframe parse creates expected object with no factors", {
        df_out <- oyez_cases(good_df_nofactor)
        expect_s3_class(df_out, "OyezCaseList")
        expect_length(df_out, 3)
    })

    test_that("dataframe parse errors on bad input", {
        # stop error
        expect_error(oyez_cases(data.frame(term = c("2012"))),
                     regexp = 'data.frame inputs to `oyez_cases()` must contain columns term and docket_number',
                     fixed = TRUE)
        # no such case error
        expect_error(
            oyez_cases(data.frame(
                term = c("2014", "2000"),
                docket_number = c("barf", "00-949")))
        )
    })

    ## list ingest
    good_list <- list(
        list(
            term = "2014",
            docket_number = "13-1175"
        ),
        list(
            term = "2014",
            docket_number = "13-1499"
        ),
        list(
            term = "2000",
            docket_number = "00-949"
        )
    )

    test_that("list parse creates expected objects", {
        ls_out <- oyez_cases(good_list)
        expect_s3_class(ls_out, "OyezCaseList")
        expect_length(ls_out, 3)
    })

    test_that("list parse errors on bad input", {
        # input error
        expect_error(
            oyez_cases(list(
                list(
                    term = "2014",
                    docket_number = "13-1175"
                ),
                list(
                    term = "2014"
                )
                ))
        )
        expect_error(
            oyez_cases(list(
                list(
                    term = "2014",
                    docket_number = "13-1175"
                ),
                list(
                    term = "2014",
                    docket_number = 'barf'
                )
            ))
        )
    })
})

