# Input inquiry ID (`committee_business_id`), returns list of unique document IDs
get_document_ids <- function(inquiry_id) {
  
  # Build URL
  url <- "https://committees-api.parliament.uk/api/WrittenEvidence?CommitteeBusinessId={inquiry_id}&Take=256"
  
  url <- glue(url)
  
  # Extract IDs from JSON
  response <- GET(url)
  json_content <- content(response, as = "text", encoding = "UTF-8")
  parsed_data <- fromJSON(json_content)
  document_ids <- parsed_data$items[9]
  
}