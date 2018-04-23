normalizeData <- function(data){
  normData <- ((data - min(data)) / (max(data) - min(data)) - 0.5) * 2 
  return(normData)
}