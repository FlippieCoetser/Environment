Session.Exceptions <- \() {
  exceptions <- list()
  exceptions[['Filepath.Not.Found']]  <- \(error) {
    filepath <- sub('.*?"(.*?)":.*', '\\1', error[['message']])

    'cannot find the path' |> grepl(error) |> exceptions[['Path.Not.Found']](filepath) 
    'cannot find the file' |> grepl(error) |> exceptions[['File.Not.Found']](filepath)
  }
  exceptions[['Path.Not.Found']]              <- \(invoke, path = NULL) {
    if (invoke) {
      stop("Path not found: ", path, ".", call. = FALSE)
    } 
  }
  exceptions[['File.Not.Found']]              <- \(invoke, file = NULL) {
    if (invoke) {
      stop("File not found: ", file, ".", call. = FALSE)
    } 
  }
  exceptions[['Filepath.Invalid']]           <- \(invoke, filepath = NULL) {
    if (invoke) {
      stop("Invalid filepath: ", filepath, ".", call. = FALSE)
    }
  }
  exceptions[['Name.Null']]                <- \(invoke) {
    if (invoke) {
      stop("Environment variable name is null, but required.", call. = FALSE)
    }
  }
  exceptions[['Value.Empty']]              <- \(invoke, name = NULL) {
    if (invoke) {
      stop("No value found for provided environment variable:", name, ". Please check .Renviron configuration file.", call. = FALSE)
    }
  }
  exceptions[['Value.Null']]               <- \(invoke) {
    if (invoke) {
      stop("Value is null. Expected a value for the environment to cache.", call. = FALSE)
    }
  }
  exceptions[['NoIDE.InUse']]                <- \(invoke) {
    if (invoke) {
      stop("No IDE in use but required.", call. = FALSE)
    }
  }
  exceptions[['RStudio.API.Unavailable']]     <- \(invoke, ide = NULL) {
    if (invoke) {
      stop("RStudio API is unavailable in ", ide, ".", call. = FALSE)
    }
  }
  exceptions[['Filepath.Unavailable']] <- \(invoke, ide = NULL) {
    if (invoke) {
      stop("Navigate to File function is unavailable in ",ide,".", call. = FALSE)
    }
  }
  return(exceptions)
}