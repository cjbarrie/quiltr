test_that("defensive programming", {
  expect_error(capture_warnings(
    quilt_form_data(
      prompt = "Label this text: ",
      text = lipsum_text$text,
      response_type = "scale"
    )
  ))
})

test_that("defensive programming", {
  expect_error(capture_warnings(
    quilt_form_data(
      prompt = "Label this text: ",
      text = lipsum_text$text,
      response_type = "options"
    )
  ))
})

test_that("returns data.frame", {
  expect_true(is.data.frame(
    quilt_form_data(
      prompt = "Label this text: ",
      text = lipsum_text$text,
      response_type = "yesno"
    )
  ))
})

test_that("returns data.frame of size nrow input text data", {
  df <- quilt_form_data(
      prompt = "Label this text: ",
      text = lipsum_text$text,
      response_type = "yesno"
    )
  expect_true(nrow(df) == nrow(lipsum_text))
})


test_that("returns different size data.frame as NA text removed", {
  df <- quilt_form_data(
    prompt = "Label this text: ",
    text = lipsum_text$text,
    response_type = "yesno",
    remove_NA = TRUE
  )
  expect_false(nrow(df) == nrow(lipsum_text))
})

test_that("page breaks returned correctly", {

  input_data <- pbreak(qdat, 1)
  expect_true(nrow(input_data) == nrow(qdat) + nrow(qdat))
  input_data <- pbreak(qdat, 2)
  expect_true(nrow(input_data) == nrow(qdat) + 1/2*nrow(qdat))
  input_data <- pbreak(qdat, 3)
  expect_true(nrow(input_data) == round(nrow(qdat) + 1/3*nrow(qdat)))

})

test_that("page break rows contain empty fields", {

  input_data <- pbreak(qdat, 1)
  expect_true(length(input_data$response_type[input_data$prompt=="[[PageBreak]]"]) == 0)

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
