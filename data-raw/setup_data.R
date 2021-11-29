library(stringi)
library(dplyr)

lipsum_text <- data.frame(text = stri_rand_lipsum(100, start_lipsum = TRUE))

usethis::use_data(lipsum_text, overwrite = TRUE)

filenames <- list.files("/Users/cbarrie6/Downloads/Arabiya/Politics/",
           recursive = TRUE,
           pattern = "\\.txt$",
           full.names = TRUE)

txts_all <- data.frame(doc_id = NULL, text = NULL)

for (i in seq_along(filenames)) {

  filename <- filenames[[i]]

  txt <- as.data.frame(readtext::readtext(filename))

  txts_all <- rbind(txts_all, txt)

}

arabiya_text <- txts_all %>%
  sample_n(100) %>%
  select(text)

data("arabiya_text")


Encoding(arabiya_text$text) <- "UTF-8"

usethis::use_data(arabiya_text, overwrite = TRUE)
