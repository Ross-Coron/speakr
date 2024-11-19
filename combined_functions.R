library(glue)
library(httr)
library(xml2)
library(jsonlite) # For fromJSON
library(base64enc) # For base64_decode


# Get inquiry number from user
get_inquiry_id <- function() {
  inquiry_id <- readline(prompt = "Input unique inquiry ID: ")
}


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


# Input vector of documents, get document data as data frame
get_documents <- function(document_list) {
  
  # Initialize an empty data frame for results
  results <- data.frame(evidence_id = character(), extracted_text = character(), stringsAsFactors = FALSE)
  
  # Iterate over the document list
  for (document in document_list$id) {
    
    # Properly construct the URL using glue
    url <- glue("https://committees-api.parliament.uk/api/WrittenEvidence/{document}/Document/Html")
    
    # Send GET request to the URL
    response <- GET(url)
    
    # Check if the request was successful
    if (status_code(response) == 200) {
      
      # Parse the JSON content
      json_content <- content(response, as = "text", encoding = "UTF-8")
      parsed_data <- fromJSON(json_content)
      
      # Extract the 'data' field
      base64_data <- parsed_data$data
      
      # Decode the Base64 string
      decoded_data <- base64decode(base64_data)
      
      # Convert raw decoded data to text
      html_content <- rawToChar(decoded_data)
      
      # Extract raw text (if it's in HTML format)
      if (grepl("<html>", html_content, fixed = TRUE)) {
        html_parsed <- read_html(html_content)
        raw_text <- xml_text(html_parsed, trim = FALSE)
      } else {
        raw_text <- html_content
      }
      
      # Append to the dataframe
      results <- rbind(results, data.frame(evidence_id = document, extracted_text = raw_text, stringsAsFactors = FALSE))
      
    } else {
      # Append an error message if the request failed
      results <- rbind(results, data.frame(evidence_id = document, extracted_text = paste("Failed to retrieve. Status:", status_code(response)), stringsAsFactors = FALSE))
    }
  }
  
  # Return the final results
  return(results)
}


# Test code. Enter 1813 to test
inquiry_id <- get_inquiry_id()
document_ids <- get_document_ids(inquiry_id)
documents_dataframe <- get_documents(document_ids)
write.csv(documents_dataframe, "test_output.csv", row.names = FALSE)
