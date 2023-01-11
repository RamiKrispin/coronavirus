test_that(desc = "Test the dates", {
  expect_equal(class(coronavirus$date) == "Date", TRUE)
  expect_equal(min(coronavirus$date) == as.Date("2020-01-22"), TRUE)
})


test_that(desc = "Test the type variable", {
  expect_equal(all(c("confirmed", "death") %in%
                           unique(coronavirus$type)), TRUE)
  expect_equal(any(is.na(coronavirus$type)), FALSE)
})


test_that(desc = "Test the vaccine data", {
  expect_equal(any(is.na(covid19_vaccine$country_region)), FALSE)
  expect_equal(class(covid19_vaccine$date) == "Date", TRUE)
})

