install.packages('rtika', repos = 'https://cloud.r-project.org')


library(rtika)
install_tika() # You need to install the Apache Tika .jar once.

# Tika also can interact with the Tesseract OCR program on some Linux variants,
# to extract plain text from images of text. If tesseract-ocr is installed, Tika
# should automatically locate and use it for images and PDFs that contain images of
# text. However, this does not seem to work on OS X or Windows. To try on Linux,
# first follow the Tesseract installation instructions. The next time Tika is run,
# it should work. For a different approach, I suggest tesseract package by @jeroen,
# which is a specialized R interface.

q1 = tika_text('/Users/quinnx/Desktop/Kane Sawyer - Resume.pdf')
q2 = tika_text("/Users/quinnx/Desktop/Quinn Pertuit's Resume.pdf")
q3 = tika_text("/Users/quinnx/Desktop/Kane Sawyer - with Notes.docx")
q1 %>%
  readr::read_lines(skip_empty_rows = TRUE) %>%
  stringr::str_squish() %>%
  stringr::str_trim()

q2 %>% strsplit(split = "\n")
library(tm)

q.corp <- Corpus(URISource(q),
               readerControl = list(reader = readPlain))

q.tdm <- TermDocumentMatrix(q.corp,control = list(removePunctuation = TRUE,
                                          stopwords = TRUE,
                                          tolower = TRUE,
                                          stemming = TRUE,
                                          removeNumbers = TRUE,
                                          bounds = list(global = c(3, Inf))))

# Test files
batch <- c(
  system.file("extdata", "jsonlite.pdf", package = "rtika"),
  system.file("extdata", "curl.pdf", package = "rtika"),
  system.file("extdata", "table.docx", package = "rtika"),
  system.file("extdata", "xml2.pdf", package = "rtika"),
  system.file("extdata", "R-FAQ.html", package = "rtika"),
  system.file("extdata", "calculator.jpg", package = "rtika"),
  system.file("extdata", "tika.apache.org.zip", package = "rtika")
)

# batches are best, and can also be piped with magrittr.
text <- tika_text(batch)
