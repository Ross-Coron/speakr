library(jsonlite)
library(tidyverse)

get_submitters <- function(inquiry_id) {


# Get JSON from URL and parse
url <- "https://committees-api.parliament.uk/api/WrittenEvidence?CommitteeBusinessId={inquiry_id}&Take=256"
url <- glue(url)
jsonData <- fromJSON(url)
jsonData <- jsonData$items |> select(witnesses)

organisations <- c()

# For each item, get organisation's name
for (i in 1:nrow(jsonData)) {
  
  if (is.null(jsonData$witnesses[[i]]$organisations[[1]]$name)) {
    organisations = c(organisations, NA)
  } else {
    organisations = c(organisations, jsonData$witnesses[[i]]$organisations[[1]]$name)
  }
  
  
  
}

return(organisations)
}
