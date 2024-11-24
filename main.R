library(glue)
library(httr)
library(xml2)
library(jsonlite)
library(base64enc)

source("get_document_ids.R")
source("get_submitters.R")
source("get_documents.R")
source("evidence_clean.R")


written_submissions <- function(inquiry_id, clean = TRUE) {
  
  inquiry_id <- as.integer(inquiry_id)
  
  # Get list of IDs of evidence documents submitted to inquiry
  document_ids <- get_document_ids(inquiry_id)
  
  # Get names of submitters
  submitters <- get_submitters(inquiry_id)
  
  # Get evidence IDs and text
  evidence_text <- get_documents(document_ids)
  
  # If clean present as optional argument
  if (clean == TRUE) {
    evidence_text <- clean_evidence(evidence_text)
  }
  
  # Pull together into data frame
  output <- data.frame(
    id = evidence_text$evidence_id,
    submitter = submitters,
    text = evidence_text$extracted_text
  )
  
  # Export to CSV file
  write.csv(output, "written_evidence.csv", row.names = FALSE)
  
}

