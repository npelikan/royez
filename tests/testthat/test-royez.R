context("test-royez.R")

test_that("message is printed", {
  expect_message(dev_warning_('0.0.0.9000'))
})
