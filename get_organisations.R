library(jsonlite)
library(tidyverse)

url <- "https://committees-api.parliament.uk/api/WrittenEvidence?CommitteeBusinessId=1813"

jsonData <- fromJSON(url)
jsonData <- jsonData$items |> select(witnesses)

organisations <- c()
for (i in 1:nrow(jsonData)) {
  
  if (is.null(jsonData$witnesses[[i]]$organisations[[1]]$name)) {
    organisations = c(organisations, NA)
  } else {
    organisations = c(organisations, jsonData$witnesses[[i]]$organisations[[1]]$name)
  }
}  

organisations
