# Define REGEX string (most often redundant line at start of evidence)
regex_string <- "^ISG.*\\(ISG\\s\\d+\\)"

removed_text <- c()
matches <- gregexpr(regex_string, evidence_text$extracted_text)
extracted <- regmatches(evidence_text$extracted_text, matches)
for (match in extracted) {
  removed_text <- c(removed_text, match)
}
writeLines(removed_text, "removed_text.txt")

# Looks for string in data frame, removing if found
evidence_text$extracted_text <- gsub(regex_string, "", evidence_text$extracted_text)
