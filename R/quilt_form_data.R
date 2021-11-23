#' Format text data to structure needed for `quilt_write_form()`
#'
#' @param question character string: question prompt of text for labelling, e.g.: "Label this text: "
#' @param text character vector: text inputs for labelling
#' @param response_type character vector: one of c("yesno", "scale")
#' @param addID add an ID variable to the text data
#' @param nlow integer: lower end of numeric scale
#' @param nhigh integer: higher end of numeric scale
#'
#' @return a data.frame
#' @export
#'
#' @examples
#' \dontrun{
#'
#' library(stringi)
#'
#' textdat <- data.frame(text = stri_rand_lipsum(100, start_lipsum = TRUE))
#'
#' qdat <- quilt_form_data(question = "Label this text: ",
#' text = textdat$text, response_type = "scale",
#' nlow = 1, nhigh = 10, addID = T)
#'
#' }
quilt_form_data <- function(question, text, response_type, addID,
                            nlow, nhigh) {

  df = data.frame(question = paste(rep(question, "\n", length(text)), text))

  df$response_type = paste(rep("Yes;No", length(text)))

  if(response_type=="yesno"){
    df$response_type = paste(rep("Yes;No", length(text)))
  }

  if(response_type=="scale"){
    if(is.null(nlow)|is.null(nhigh)) {
      stop("Scale response requires upper and lower bound to be specified")
    }
    df$response_type = paste(rep(nlow:nhigh), collapse = ";")
  }

  if(isTRUE(addID)){
    df$id = paste0("QID", length(text))
  }

  return(df)
}
