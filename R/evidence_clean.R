clean_evidence <- function(evidence_text){
  
  # Define REGEX expression (most often redundant line at start of evidence)
  regex_string <- "^ISG.*\\(ISG\\s?\\d+\\)"
  
  # Check evidence text for REGEX expression
  matches <- gregexpr(regex_string, evidence_text$extracted_text)
  extracted <- regmatches(evidence_text$extracted_text, matches)
  
  # Save removed text to .txt file
  removed_text <- c()
  for (match in extracted) {
    if (length(match) == 0) {
      removed_text <- c(removed_text, "<NO TEXT REMOVED>")
    }
    removed_text <- c(removed_text, match)
  }
  writeLines(removed_text, "removed_text.txt")
  print("Text cleaned via REGEX. See removed_text.txt for details")
  
  # Remove identified REGEX text from data frame
  evidence_text$extracted_text <- gsub(regex_string, "", evidence_text$extracted_text)
  
  return (evidence_text)
}

