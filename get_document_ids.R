# Input inquiry ID (`committee_business_id`), returns list of unique document IDs
get_document_ids <- function(committee_business_id) {
  
  # Build URL
  url <- "https://committees-api.parliament.uk/api/WrittenEvidence?CommitteeBusinessId={committee_business_id}"
  url <- glue(url)
  
  # Extract IDs from JSON
  response <- GET(url)
  json_content <- content(response, as = "text", encoding = "UTF-8")
  parsed_data <- fromJSON(json_content)
  document_ids <- parsed_data$items[9]
  
}