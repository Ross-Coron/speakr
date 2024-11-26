check_input <- function(inquiry_id, clean = TRUE) {
  
  if (!is.numeric(inquiry_id)){
    stop("Incorrect input! For help, enter `?speakr` into terminal.")
  }
  
  if (!is.logical(clean)){
    stop("Incorrect input! See enter `?speakr` into terminal.")
  }
  
  else {
    print("Input OK. Attempting to retrieve data...")
    return (TRUE)
  }
}