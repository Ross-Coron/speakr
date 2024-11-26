source("../../R/check_input.R")

test_that("`check_input` raises error if no input.", {
  expect_error(check_input())
})

test_that("`check_input` raises error if incorrect input.", {
  expect_error(check_input("foo"))
  expect_error(check_input(1813, clean = "bar"))
})

test_that("`check_input` raises no error if input OK.", {
  expect_no_error(check_input(1813))
  expect_no_error(check_input(1813, clean = FALSE))
})
