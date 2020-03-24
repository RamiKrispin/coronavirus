test_that(desc = "Test the dates", {
  expect_equal(base::class(coronavirus$date) == "Date", TRUE)
  expect_equal(base::min(coronavirus$date) == as.Date("2020-01-22"), TRUE)
})


test_that(desc = "Test the type variable", {
  expect_equal(base::all(c("confirmed", "death") %in%
                           unique(coronavirus$type)), TRUE)
  expect_equal(base::any(is.na(coronavirus$type)), FALSE)
})

