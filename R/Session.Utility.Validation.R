Session.Utility.Validation <- \() {
  exception <- Session.Utility.Exceptions()
  
  validations <- list()
  validations[['NavigationResponse']] <- \(response) {
    response |> tryCatch(warning = exception[['NavigateToFileExceptions']])
  }
  return(validations)
}