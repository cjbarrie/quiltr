test_that("defensive programming", {
  expect_error(capture_warnings(
    quilt_form(
      input_data = qdat,
      question_type = "multianswer"
    )
  ))
})

test_that("defensive programming", {
  expect_error(capture_warnings(
    quilt_form(
      input_data = qdat,
      filename = "qualtrics_survey.txt"
    )
  ))
})


test_that("defensive programming", {
  expect_error(capture_warnings(
    quilt_form(
      question_type = "multianswer",
      filename = "qualtrics_survey.txt"
    )
  ))
})
