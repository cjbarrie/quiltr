library(stringi)

lipsum_text <- data.frame(text = stri_rand_lipsum(100, start_lipsum = TRUE))

usethis::use_data(lipsum_text, overwrite = TRUE)
