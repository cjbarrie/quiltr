#' Format text data to structure needed for `quilt_write_form()`
#'
#' @param prompt character string: prompt of text for labelling, e.g.: "Label this text: "
#' @param text character vector: text inputs for labelling
#' @param response_type character vector: one of c("yesno", "options", "scale")
#' @param options character vector of response options: e.g., c("big", "small", "biggie smalls")
#' @param addID add an ID variable to the text data
#' @param nlow integer: low end of numeric scale
#' @param nhigh integer: high end of numeric scale
#'
#' @return a data.frame
#' @export
#'
#' @examples
#' \dontrun{
#'
#' data(lipsum_text)
#'
#' qdat <- quilt_form_data(prompt = "Label this text: ",
#'                         text = lipsum_text$text, response_type = "yesno",
#'                         addID = T)
#'
#' qdat <- quilt_form_data(prompt = "Label this text: ",
#'                         text = lipsum_text$text, response_type = "options",
#'                         options = c("Not at all", "Somewhat", "Very much"),
#'                         addID = T)
#'
#' qdat <- quilt_form_data(prompt = "Label this text: ",
#'                         text = lipsum_text$text, response_type = "scale",
#'                         nlow = 1, nhigh = 10, addID = T)
#' }
quilt_form_data <- function(prompt = NULL, text, response_type, options, addID,
                            nlow, nhigh) {

  if(is.null(prompt)){
    prompt = ""
    df = data.frame(prompt = paste(rep(prompt, length(text)), text))
  } else {
    df = data.frame(prompt = paste(rep(prompt, "\n", length(text)), text))
  }

  if(response_type=="yesno"){
    df$response_type = paste(rep("Yes;No", length(text)))
  }

  if(response_type=="options"){
    if(is.null(options)) {
      stop("Options response requires options input")
    }
    df$response_type = paste(rep(options), collapse = ";")
  }

  if(response_type=="scale"){
    if(is.null(nlow)|is.null(nhigh)) {
      stop("Scale response requires upper and lower bound to be specified")
    }
    df$response_type = paste(rep(nlow:nhigh), collapse = ";")
  }

  if(isTRUE(addID)){
    df$id = paste0("QID", 1:length(text))
  }

  return(df)
}
