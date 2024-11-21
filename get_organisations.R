library(jsonlite)
library(tidyverse)

url <- "https://committees-api.parliament.uk/api/WrittenEvidence?CommitteeBusinessId=1813"

jsonData <- fromJSON(url)
processedData <- jsonData$items |> select(witnesses)

organisations <- c()
for (i in 1:nrow(processedData)) {
  #print(x[[i]]$organisations[[1]]$name)
  if (is.null(x[[i]]$organisations[[1]]$name)) {
    organisations = c(organisations, NA)
  } else {
  organisations = c(organisations, x[[i]]$organisations[[1]]$name)
  }
}
