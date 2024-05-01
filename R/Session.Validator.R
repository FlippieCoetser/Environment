Session.Validator <- \() {
  exception <- Session.Validation.Exceptions()
  
  validations <- list()
  validations[['navigation.response']] <- \(response) {
    response |> tryCatch(warning = exception[['filepath.not.found']])
  }
  validations[['filepath']]           <- \(filepath) {
    pattern <- "^(([a-zA-Z]:)(/[a-zA-Z0-9_.-]+)+/[a-zA-Z0-9_.-]*[a-zA-Z0-9])|(/([a-zA-Z0-9_.-]*/?)*[a-zA-Z0-9_.-]*[a-zA-Z0-9])$"
    pattern |> grepl(filepath) |> isFALSE() |> exception[['filepath.invalid']](filepath)
    return(filepath)
  }
  validations[['is.empty']]            <- \(value) {
    value |> (\(x){ x == "" })()
  } 
  validations[['is.NULL']]             <- \(value) {
    value |> is.null()
  }
  validations[['Name']]               <- \(name) {
    name |> validations[['is.NULL']]() |> exception[['name.null']]()
    return(name)
  }
  validations[['Value']]              <- \(value, name = NULL) {
    value |> validations[['is.NULL']]() |> exception[['value.null']]()
    value |> validations[['is.empty']]() |> exception[['value.empty']](name)
    return(value)
  }
  validations[['IDE']]                <- \(ide) {
    'None' |> grepl(ide) |> exception[['IDE.not.active']]()
  }
  validations[['api.availability']]    <- \(available, ide = NULL) {
    available |> isFALSE() |> exception[['RStudio.api.unavailable']](ide)
  }
  validations[['api.capability']]      <- \(capable, ide = NULL) {
    capable |> isFALSE() |> exception[['filepath.unavailable']](ide)
  }
  return(validations)
}