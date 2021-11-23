# quiltr
Qualtrics for labelling text using R

## Installation

You can install the package with:
``` r
devtools::install_github("cjbarrie/quiltr")
```

To use the package, it first needs to be loaded with:

```r

library(quiltr)

```

The <tt>quiltr</tt> package has been adapted from the <tt>qualtricsR</tt> [here](https://github.com/saberry/qualtricsR). This package was designed for generating bespoke surveys in a format appropriate for importing into Qualtrics. 

The <tt>quiltr</tt> package is designed solely for generating forms for data labelling, in particular text labelling. 

There are two main workhorse functions, which are `quilt_form_data()` and `quilt_write_form`. The first of these takes a dataset of text for labelling and structures it appropriately for writing the Qualtrics data labelling form. The second takes the data.frame produced by `quilt_form_data()` and generates a .txt file that is importable into Qualtrics.

We will first generate a dummy text dataset for the purposes of this tutorial.

```r

library(stringi)

textdat <- data.frame(text = stri_rand_lipsum(100, start_lipsum = TRUE))

```

We can then call `quilt_form_data()`, which takes the following arguments:

```r

qdat <- quilt_form_data(question = "Label this text: ",
                     text = textdat$text, response_type = "scale",
                     nlow = 1, nhigh = 10, addID = T)

```

The `question` argument is optional and gives the user the chance to add a prompt before the text meant for labelling. The second argument specifies the text to be labelled. Here, we are specifying our dummy `textdat` data and, specifically, the column `textdat$text`. The `response_type` argument has several options, including "scale" for and integer scale. For this, we then need to specify an upper and lower bound with the `nlow` and `nhigh` arguments. 

Once we have our data in the appropriate format, we can then generate our Qualtrics importable form with `quilt_write_form()` as follows:

```r

quilt_write_form(input_data = qdat,
            page_break_every = 1, question_type = "multianswer",
            filename = "quilted_survey.txt")

```

