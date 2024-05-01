Session.Validation.Exceptions <- \() {
  exceptions <- list()
  exceptions[['filepath.not.found']]  <- \(error) {
    filepath <- sub('.*?"(.*?)":.*', '\\1', error[['message']])

    'cannot find the path' |> grepl(error) |> exceptions[['path.not.found']](filepath) 
    'cannot find the file' |> grepl(error) |> exceptions[['file.not.found']](filepath)
  }
  exceptions[['path.not.found']]              <- \(invoke, path = NULL) {
    if (invoke) {
      stop("Path not found: ", path, ".", call. = FALSE)
    } 
  }
  exceptions[['file.not.found']]              <- \(invoke, file = NULL) {
    if (invoke) {
      stop("File not found: ", file, ".", call. = FALSE)
    } 
  }
  exceptions[['filepath.invalid']]           <- \(invoke, filepath = NULL) {
    if (invoke) {
      stop("Invalid filepath: ", filepath, ".", call. = FALSE)
    }
  }
  exceptions[['name.null']]                <- \(invoke) {
    if (invoke) {
      stop("Environment variable name is null, but required.", call. = FALSE)
    }
  }
  exceptions[['value.empty']]              <- \(invoke, name = NULL) {
    if (invoke) {
      stop("No value found for provided environment variable:", name, ". Please check .Renviron configuration file.", call. = FALSE)
    }
  }
  exceptions[['value.null']]               <- \(invoke) {
    if (invoke) {
      stop("Value is null. Expected a value for the environment to cache.", call. = FALSE)
    }
  }
  exceptions[['IDE.not.active']]                <- \(invoke) {
    if (invoke) {
      stop("No IDE in use but required.", call. = FALSE)
    }
  }
  exceptions[['RStudio.api.unavailable']]     <- \(invoke, ide = NULL) {
    if (invoke) {
      stop("RStudio API is unavailable in ", ide, ".", call. = FALSE)
    }
  }
  exceptions[['filepath.unavailable']] <- \(invoke, ide = NULL) {
    if (invoke) {
      stop("Navigate to File function is unavailable in ",ide,".", call. = FALSE)
    }
  }
  return(exceptions)
}