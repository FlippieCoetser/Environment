Session.Utility.Validation <- \() {
  exception <- Session.Exceptions()
  
  validations <- list()
  validations[['NavigationResponse']] <- \(response) {
    response |> tryCatch(warning = exception[['NavigateToFileExceptions']])
  }
  validations[['Filepath']]           <- \(filepath) {
    pattern <- "^(([a-zA-Z]:)(/[a-zA-Z0-9_.-]+)+/[a-zA-Z0-9_.-]*[a-zA-Z0-9])|(/([a-zA-Z0-9_.-]*/?)*[a-zA-Z0-9_.-]*[a-zA-Z0-9])$"
    pattern |> grepl(filepath) |> isFALSE() |> exception[['InvalidFilepath']](filepath)
    return(filepath)
  }
  validations[['IsEmpty']]            <- \(value) {
    value |> (\(x){ x == "" })()
  } 
  validations[['IsNull']]             <- \(value) {
    value |> is.null()
  }
  validations[['Name']]               <- \(name) {
    name |> validations[['IsNull']]() |> exception[['NameIsNull']]()
    return(name)
  }
  validations[['Value']]              <- \(value, name = NULL) {
    value |> validations[['IsNull']]() |> exception[['ValueIsNull']]()
    value |> validations[['IsEmpty']]() |> exception[['ValueIsEmpty']](name)
    return(value)
  }
  validations[['IDE']]                <- \(ide) {
    'None' |> grepl(ide) |> exception[['NoIDEInUse']]()
  }
  validations[['APIAvailability']]    <- \(available, ide = NULL) {
    available |> isFALSE() |> exception[['RStudioAPIUnavailable']](ide)
  }
  validations[['APICapability']]      <- \(capable, ide = NULL) {
    capable |> isFALSE() |> exception[['NavigateToFileUnavailable']](ide)
  }
  return(validations)
}