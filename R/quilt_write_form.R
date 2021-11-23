#' Create text labelling form for importing to Qualtrics
#'
#' @param input_data data.frame: input data generated with `quilt_form_data()`
#' @param page_break_every integer: number of text examples before page break
#' @param question_type character vector: one of c("dropdown", "select", "multiselect", "singleanswer", "multianswer", )
#' @param filename name of survey .txt form generated
#'
#' @return a .txt survey file
#' @export
#'
#' @examples
#' \dontrun{
#'
#' library(stringi)
#'
#' textdat <- data.frame(text = stri_rand_lipsum(100, start_lipsum = TRUE))
#'
#' qdat <- quilt_form_data(question = "Label this text: ", text = textdat$text,
#' response_type = "scale", nlow = 1, nhigh = 10, addID = T)
#'
#' quilt_write_form(input_data = qdat,page_break_every = 1,
#' question_type = "multianswer",filename = "test/testing.txt")
#' }
quilt_write_form <- function(input_data,
                             page_break_every = 0,
                             question_type,
                             filename = "surveyOut.txt") {

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

  rowID <- NULL

  variable <- NULL

  if(!(is.null(input_data$id))) {
    input_data$id <- paste("[[ID:",
                           input_data$id,
                           "]]", sep = "")
  } else {
    input_data$id <- paste("[[ID:",
                           gsub("\\s", "_", input_data$id), "]]",
                           sep = "")
  }

  if(page_break_every != 0) {

    nformrow <- nrow(input_data)

    input_data$rowID <- 1:nformrow

    pbreaknums <- seq(from = page_break_every, to = nformrow,
                      by = page_break_every) + .1

    input_data[(nformrow + 1):(nformrow + length(pbreaknums)), ] <- ""

    input_data$question[(nformrow + 1):(nformrow + length(pbreaknums))] <- "[[PageBreak]]\n"

    input_data$rowID[(nformrow + 1):(nformrow + length(pbreaknums))] <- pbreaknums

    input_data <- input_data[order(input_data$rowID), ]

  } else input_data$rowID = 1:nrow(input_data)

  quiltedform <- reshape2::melt(input_data, id.vars = "rowID", factorsAsStrings = TRUE)

  quiltedform <- quiltedform[order(quiltedform$rowID,
                                   as.character(quiltedform$variable)), , drop = FALSE]

  quiltedform$value[which(quiltedform$variable == "id" & quiltedform$value != "")] <-
    paste(question_type, "\n",
          quiltedform$value[which(quiltedform$variable == "id" & quiltedform$value != "")],
          sep = "")

  quiltedform$value[which(quiltedform$variable == "response_type" & quiltedform$value != "")] <-
    paste("[[Choices]]", "\n",
          quiltedform$value[which(quiltedform$variable == "response_type" & quiltedform$value != "")],
          "\n",
          sep = "")

  quiltedform <- unlist(strsplit(quiltedform$value, ";"))

  quiltedform[1] <- paste("[[AdvancedFormat]]\n", quiltedform[1], sep = "\n")

  writeLines(quiltedform, filename)
}
