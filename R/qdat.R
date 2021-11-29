#' Dataset generated with `quilt_form_data`
#'
#' A dataset containing one hundred paragraphs of lipsum text with columns
#' for text (prompt), response_type and ID
#'
#' @format A data frame with 100 rows and 3 variables:
#' \describe{
#'   \item{prompt}{Paragraphs of (pseudo) random lorem ipsum text}
#'   \item{response_type}{Response options separated with semi-colons}
#'   \item{id}{Unique ID assigned to the text}
#'   ...
#' }
#' @source \url{https://www.rdocumentation.org/packages/stringi/versions/1.5.3/topics/stri_rand_lipsum}
"qdat"
