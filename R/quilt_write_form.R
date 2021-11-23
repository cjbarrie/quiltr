quilt_write_form <- function(input_data, ro_separator = ";",
                             page_break_every = 0,
                             question_type,
                             filename = "surveyOut.txt") {

  if(question_type=="dropdown"){
    qtype = "[[Question:MC:Dropdown]]"
  }

  if(question_type=="select"){
    qtype = "[[Question:MC:Select]]"
  }

  if(question_type=="multiselect"){
    qtype = "[[Question:MC:MultiSelect]]"
  }

  if(question_type=="singleanswer"){
    qtype = "[[Question:MC:SingleAnswer:Horizontal]]"
  }

  if(question_type=="multianswer"){
    qtype = "[[Question:MC:MultipleAnswer:Horizontal]]"
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

    rowCount <- nrow(input_data)

    input_data$rowID <- 1:rowCount

    breakNumbers <- seq(from = page_break_every, to = rowCount,
                        by = page_break_every) + .1

    input_data[(rowCount + 1):(rowCount + length(breakNumbers)), ] <- ""

    input_data$question[(rowCount + 1):(rowCount + length(breakNumbers))] <- "[[PageBreak]]\n"

    input_data$rowID[(rowCount + 1):(rowCount + length(breakNumbers))] <- breakNumbers

    input_data <- input_data[order(input_data$rowID), ]

  } else input_data$rowID = 1:nrow(input_data)

  meltedSurvey <- reshape2::melt(input_data, id.vars = "rowID", factorsAsStrings = TRUE)

  meltedSurvey <- dplyr::arrange(meltedSurvey, rowID, as.character(variable))

  meltedSurvey$value[which(meltedSurvey$variable == "id" & meltedSurvey$value != "")] <-
    paste(qtype, "\n",
          meltedSurvey$value[which(meltedSurvey$variable == "id" & meltedSurvey$value != "")],
          sep = "")

  meltedSurvey$value[which(meltedSurvey$variable == "responseOptions" & meltedSurvey$value != "")] <-
    paste("[[Choices]]", "\n",
          meltedSurvey$value[which(meltedSurvey$variable == "responseOptions" & meltedSurvey$value != "")],
          "\n",
          sep = "")

  meltedSurvey <- unlist(strsplit(meltedSurvey$value, ro_separator))

  meltedSurvey[1] <- paste("[[AdvancedFormat]]\n", meltedSurvey[1], sep = "\n")

  writeLines(meltedSurvey, filename)
}
