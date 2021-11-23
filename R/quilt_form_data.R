quilt_form_data <- function(question, text, response_type, addID,
                            nlow, nhigh) {

  df = data.frame(question = paste(rep(question, "\n\n", length(text)), text))

  df$responseOptions = paste(rep("Yes;No", length(text)))

  if(response_type=="yesno"){
    df$responseOptions = paste(rep("Yes;No", length(text)))
  }

  if(response_type=="scale"){
    if(is.null(nlow)|is.null(nhigh)) {
      stop("Scale response requires upper and lower bound to be specified")
    }
    df$responseOptions = paste(rep(nlow:nhigh), collapse = ";")
  }

  if(isTRUE(addID)){
    df$id = paste0("QID", length(text))
  }

  return(df)
}
