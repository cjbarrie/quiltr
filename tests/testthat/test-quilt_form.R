test_that("defensive programming", {
  expect_error(capture_warnings(
    quilt_form(
      input_data = qdat,
      question_type = "dropdown"
    )
  ))
  expect_error(capture_warnings(
    quilt_form(
      input_data = qdat,
      question_type = "select"
    )
  ))
  expect_error(capture_warnings(
    quilt_form(
      input_data = qdat,
      question_type = "multiselect"
    )
  ))
  expect_error(capture_warnings(
    quilt_form(
      input_data = qdat,
      question_type = "singleanswer"
    )
  ))
  expect_error(capture_warnings(
    quilt_form(
      input_data = qdat,
      question_type = "multianswer"
    )
  ))
  expect_error(capture_warnings(
    quilt_form(
      input_data = qdat,
      question_type = "rankorder"
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


test_that("quilted form is of class character", {

  input_data <- pbreak(qdat, 1)
  quilted_form <- formpaste(input_data, "[[Question:MC:Dropdown]]")
  expect_true(is.character(quilted_form))

})


test_that("quilted form is of length nrow page-breaked data", {

  input_data <- pbreak(qdat, 3)
  quilted_form <- formpaste(input_data, "[[Question:MC:Dropdown]]")
  expect_true(length(quilted_form) == nrow(input_data))

})

test_that("ID appended when null", {

  input_data = qdat[,-3]
  input_data <- addformIDs(input_data)
  IDs <- input_data$id
  expect_true(length(IDs) == nrow(input_data))
  expect_type(input_data$id, "character")
  expect_equal(input_data$id[1], "[[ID:1]]")

})


test_that("page breaks returned correctly", {

  input_data <- pbreak(qdat, 1)
  expect_true(nrow(input_data) == nrow(qdat) + nrow(qdat))
  input_data <- pbreak(qdat, 2)
  expect_true(nrow(input_data) == nrow(qdat) + 1/2*nrow(qdat))
  input_data <- pbreak(qdat, 3)
  expect_true(nrow(input_data) == round(nrow(qdat) + 1/3*nrow(qdat)))

})

test_that("page break rows of correct length", {

  page_break_every = 1
  input_data <- pbreak(qdat, page_break_every)
  expect_true(length(input_data$response_type[input_data$prompt=="[[PageBreak]]\n"]) ==  1/page_break_every*nrow(qdat))
  page_break_every = 2
  input_data <- pbreak(qdat, page_break_every)
  expect_true(length(input_data$response_type[input_data$prompt=="[[PageBreak]]\n"]) ==  1/page_break_every*nrow(qdat))
  page_break_every = 3
  input_data <- pbreak(qdat, page_break_every)
  expect_true(length(input_data$response_type[input_data$prompt=="[[PageBreak]]\n"]) ==  round(1/page_break_every*nrow(qdat)))

})
