Session.Utility.Validation <- \() {
  exception <- Session.Utility.Exceptions()
  
  validations <- list()
  validations[['NavigationResponse']] <- \(response) {
    response |> tryCatch(warning = exception[['NavigateToFileExceptions']])
  }
  validations[['Filepath']]  <- \(filepath) {
    pattern <- "^(([a-zA-Z]:)(/[a-zA-Z0-9_.-]+)+/[a-zA-Z0-9_.-]*[a-zA-Z0-9])|(/([a-zA-Z0-9_.-]*/?)*[a-zA-Z0-9_.-]*[a-zA-Z0-9])$"
    pattern |> grepl(filepath) |> isFALSE() |> exception[['InvalidFilepath']](filepath)
    return(filepath)
  }
  validations[['IsEmpty']] <- \(value) {
    value |> (\(x){ x == "" })()
  } 
  validations[['IsNull']] <- \(value) {
    value |> is.null()
  }
  return(validations)
}