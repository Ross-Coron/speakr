library(glue)
library(httr)
library(xml2)
library(jsonlite) # For fromJSON
library(base64enc) # For base64_decode

evidence <- c("72758", "76311", "74791")
url <- "https://committees-api.parliament.uk/api/WrittenEvidence/{x}/Document/Html"

# Initialize an empty data frame
results <- data.frame(evidence_id = character(), extracted_text = character(), stringsAsFactors = FALSE)

for (x in evidence) {
  
  # Dynamically create the URL for each evidence ID
  full_url <- glue(url)
  
  # Send GET request to the URL
  response <- GET(full_url)
  
  # Check if the request was successful
  if (status_code(response) == 200) {
    
    # Parse the JSON content
    json_content <- content(response, as = "text", encoding = "UTF-8")
    parsed_data <- fromJSON(json_content)
    
    # Extract the 'data' field
    base64_data <- parsed_data$data
    
    # Decode the Base64 string
    decoded_data <- base64decode(base64_data)
    
    # Convert raw decoded data to text (assuming UTF-8 encoding)
    html_content <- rawToChar(decoded_data)
    
    # Extract raw text (if it's in HTML format)
    if (grepl("<html>", html_content, fixed = TRUE)) {
      html_parsed <- read_html(html_content)
      raw_text <- xml_text(html_parsed, trim = FALSE)
    } else {
      raw_text <- html_content
    }
    
    # Append to the dataframe
    results <- rbind(results, data.frame(evidence_id = x, extracted_text = raw_text, stringsAsFactors = FALSE))
    
  } else {
    # Append an error message if the request failed
    results <- rbind(results, data.frame(evidence_id = x, extracted_text = paste("Failed to retrieve. Status:", status_code(response)), stringsAsFactors = FALSE))
  }
}