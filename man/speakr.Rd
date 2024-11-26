\name{speakr}
\alias{speakr}
\title{SpeakR}
\description{Extracts all written evidence for a UK Parliament Select Committee inquiry.}
\usage{
  speakr()
}
\value{
  Dataframe with list of documents, authors, and raw text. Also save data as CSV and optionally, removed text in a .txt file.
}
\examples{
  speakr(1813, clean = TRUE)
  speakr(1813, clean = FALSE)
  written_evidence <- (1813)
}