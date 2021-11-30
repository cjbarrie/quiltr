#' Create text labelling form for importing to Qualtrics
#'
#' @param input_data data.frame: input data generated with `quilt_form_data()`
#' @param page_break_every integer: number of text examples before page break; default is 0
#' @param question_type character vector: one of c("dropdown", "select", "multiselect", "singleanswer", "multianswer", "rankorder", "singleline", "essay" )
#' @param filename name of survey .txt form generated, e.g. "quilted_form.txt."
#'
#' @return a .txt survey file
#' @export
#'
#' @examples
#' \dontrun{
#'
#' data(lipsum_text)
#'
#' qdat <- quilt_form_data(prompt = "Label this text: ", text = lipsum_text$text,
#'                         response_type = "scale", nlow = 1, nhigh = 10, addID = T)
#'
#' quilt_form(input_data = qdat, page_break_every = 1,
#'                  question_type = "multianswer", filename = "test/testing.txt")
#' }
quilt_form <- function(input_data,
                             page_break_every = 0,
                             question_type,
                             filename) {

  if(question_type=="dropdown"){
    question_type = "[[Question:MC:Dropdown]]"
  }

  if(question_type=="select"){
    question_type = "[[Question:MC:Select]]"
  }

  if(question_type=="multiselect"){
    question_type = "[[Question:MC:MultiSelect]]"
  }

  if(question_type=="singleanswer"){
    question_type = "[[Question:MC:SingleAnswer:Horizontal]]"
  }

  if(question_type=="multianswer"){
    question_type = "[[Question:MC:MultipleAnswer:Horizontal]]"
  }

  if(question_type=="rankorder"){
    question_type = "[[Question:RankOrder]]"
  }

  if(question_type=="singleline"){
    question_type = "[[Question:TextEntry:SingleLine]]"
  }

  if(question_type=="essay"){
    question_type = "[[Question:TextEntry:Essay]]"
  }

  rowID <- NULL

  variable <- NULL

  input_data <- addformIDs(input_data)

  if(page_break_every != 0) {

    input_data <- pbreak(input_data, page_break_every)

  } else input_data$rowID = 1:nrow(input_data)

  quilted_form <- formpaste(input_data, question_type)

  writeLines(quilted_form, filename)
}
