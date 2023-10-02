Path.Exceptions <- \() {
  exceptions <- list()
  exceptions[['Path.Invalid']]       <- \(invoke, path = NULL) {
    if (invoke) {
      stop("Invalid path: ", path, ".", call. = FALSE)
    } 
  }
  exceptions[['Filename.Invalid']]   <- \(invoke, filename = NULL) { 
    if (invoke) {
      stop("Invalid filename: ", filename, ".", call. = FALSE)
    }
  }
  exceptions[['Normalized.Invalid']] <- \(invoke, path = NULL) {
    if (invoke) {
      stop("Invalid normalized path: ", path, ".", call. = FALSE)
    }
  }
  exceptions[['Filepath.Invalid']]   <- \(invoke, filepath = NULL) {
    if (invoke) {
      stop("Invalid filepath: ", filepath, ".", call. = FALSE)
    }
  }
  return(exceptions)
}