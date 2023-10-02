Session.Validator <- \() {
  exception <- Session.Exceptions()
  
  validations <- list()
  validations[['Navigation.Response']] <- \(response) {
    response |> tryCatch(warning = exception[['Filepath.Not.Found']])
  }
  validations[['Filepath']]           <- \(filepath) {
    pattern <- "^(([a-zA-Z]:)(/[a-zA-Z0-9_.-]+)+/[a-zA-Z0-9_.-]*[a-zA-Z0-9])|(/([a-zA-Z0-9_.-]*/?)*[a-zA-Z0-9_.-]*[a-zA-Z0-9])$"
    pattern |> grepl(filepath) |> isFALSE() |> exception[['Filepath.Invalid']](filepath)
    return(filepath)
  }
  validations[['IsEmpty']]            <- \(value) {
    value |> (\(x){ x == "" })()
  } 
  validations[['IsNull']]             <- \(value) {
    value |> is.null()
  }
  validations[['Name']]               <- \(name) {
    name |> validations[['IsNull']]() |> exception[['Name.Null']]()
    return(name)
  }
  validations[['Value']]              <- \(value, name = NULL) {
    value |> validations[['IsNull']]() |> exception[['Value.Null']]()
    value |> validations[['IsEmpty']]() |> exception[['Value.Empty']](name)
    return(value)
  }
  validations[['IDE']]                <- \(ide) {
    'None' |> grepl(ide) |> exception[['NoIDE.InUse']]()
  }
  validations[['API.Availability']]    <- \(available, ide = NULL) {
    available |> isFALSE() |> exception[['RStudio.API.Unavailable']](ide)
  }
  validations[['API.Capability']]      <- \(capable, ide = NULL) {
    capable |> isFALSE() |> exception[['Filepath.Unavailable']](ide)
  }
  return(validations)
}