Session.Utility.Exceptions <- \() {
  exceptions <- list()
  exceptions[['NavigateToFileExceptions']] <- \(error) {
    filepath <- sub('.*?"(.*?)":.*', '\\1', error[['message']])

    'cannot find the path' |> grepl(error) |> exceptions[['PathNotFound']](filepath) 
    'cannot find the file' |> grepl(error) |> exceptions[['FileNotFound']](filepath)
  }
  exceptions[['PathNotFound']]    <- \(invoke, path = NULL) {
    if (invoke) {
      stop("Path not found: ", path, ".", call. = FALSE)
    } 
  }
  exceptions[['FileNotFound']]    <- \(invoke, file = NULL) {
    if (invoke) {
      stop("File not found: ", file, ".", call. = FALSE)
    } 
  }
  exceptions[['InvalidFilepath']] <- \(invoke, filepath = NULL) {
    if (invoke) {
      stop("Invalid filepath: ", filepath, ".", call. = FALSE)
    }
  }
  exceptions[['NameIsNull']]      <- \(invoke) {
    if (invoke) {
      stop("Name is null. Expected a name for the environment to retrieve its value.")
    }
  }
  exceptions[['ValueIsEmpty']]    <- \(invoke, name = NULL) {
    if (invoke) {
      stop("No value found for provided environment variable:", name, ". Please check .Renviron configuration file.")
    }
  }
  exceptions[['ValueIsNull']]     <- \(invoke) {
    if (invoke) {
      stop("Value is null. Expected a value for the environment to cache.")
    }
  }
  exceptions[['NoIDEInUse']]      <- \(invoke) {
    if (invoke) {
      stop("No IDE in use but required.")
    }
  }
  exceptions[['RStudioAPIUnavailable']] <- \(invoke, ide = NULL) {
    if (invoke) {
      stop("RStudio API is unavailable for IDE: ", ide, ".", call. = FALSE)
    }
  }
  exceptions[['NavigateToFileUnavailable']] <- \(invoke, ide = NULL) {
    if (invoke) {
      stop("Navigate to File function is unavailable in IDE: ",ide,".", call. = FALSE)
    }
  }
  return(exceptions)
}