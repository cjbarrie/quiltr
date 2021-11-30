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

test_that("test error message for absent options", {
  expect_error(
    quilt_form_data(
      prompt = "Label this text: ",
      text = lipsum_text$text,
      response_type = "options",
      options = NULL
  ), "Options response requires options input")
})

test_that("test error message for absent scale", {
  expect_error(
    quilt_form_data(
      prompt = "Label this text: ",
      text = lipsum_text$text,
      response_type = "scale",
      nlow = NULL,
      nhigh = 10
    ), "Scale response requires upper and lower bound to be specified")
  expect_error(
    quilt_form_data(
      prompt = "Label this text: ",
      text = lipsum_text$text,
      response_type = "scale",
      nlow = 1,
      nhigh = NULL
    ), "Scale response requires upper and lower bound to be specified")
  expect_error(
    quilt_form_data(
      prompt = "Label this text: ",
      text = lipsum_text$text,
      response_type = "scale",
      nlow = NULL,
      nhigh = NULL
    ), "Scale response requires upper and lower bound to be specified")
})

test_that("returns data.frame of named columns prompt, response type, id", {
  expect_true(is.data.frame(
    quilt_form_data(
      prompt = "Label this text: ",
      text = lipsum_text$text,
      response_type = "yesno"
    )
  ))

  df <- quilt_form_data(
    prompt = "Label this text: ",
    text = lipsum_text$text,
    response_type = "yesno"
  )

  expect_named(df, c("prompt", "response_type", "id"))

})

test_that("options formatted when specified", {

  option_responses = c("big", "small", "biggie smalls")

  df <- quilt_form_data(
    prompt = "Label this text: ",
    text = lipsum_text$text,
    response_type = "options",
    options = option_responses
  )

  expect_named(df, c("prompt", "response_type", "id"))
  expect_equal(df$response_type[1], paste(option_responses, collapse = ";"))


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


test_that("prompts returned as empty when NULL", {

  prompt = NULL
  df <- addprompt(prompt, lipsum_text$text)
  expect_equal(nchar(df$prompt[1]), nchar(lipsum_text$text[1]))
})

test_that("options formatted when specified", {

    option_responses = c("big", "small", "biggie smalls")

    df <- quilt_form_data(
      prompt = "Label this text: ",
      text = lipsum_text$text,
      response_type = "options",
      options = option_responses
    )

    expect_named(df, c("prompt", "response_type", "id"))
    expect_equal(df$response_type[1], paste(option_responses, collapse = ";"))


})

test_that("scales formatted when specified", {

  nlowint = 1
  nhighint = 10

  df <- quilt_form_data(
    prompt = "Label this text: ",
    text = lipsum_text$text,
    response_type = "scale",
    nlow = nlowint,
    nhigh = nhighint
  )

  expect_equal(df$response_type[1], paste(rep(nlowint:nhighint), collapse = ";"))

})
