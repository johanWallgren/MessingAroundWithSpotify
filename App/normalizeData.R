normalizeData <- function(data){
  normData <- (data - min(data)) / (max(data) - min(data)) 
  return(normData)
}
