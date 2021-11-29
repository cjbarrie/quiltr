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
  expect_true(nrow(df)==nrow(lipsum_text))
})


test_that("returns different size data.frame as NA text removed", {
  df <- quilt_form_data(
    prompt = "Label this text: ",
    text = lipsum_text$text,
    response_type = "yesno",
    remove_NA = TRUE
  )
  expect_false(nrow(df)==nrow(lipsum_text))
})
