Path.Validation.Exceptions <- \() {
  exceptions <- list()
  exceptions[['path.invalid']]       <- \(invoke, path = NULL) {
    if (invoke) {
      stop("Invalid path: ", path, ".", call. = FALSE)
    } 
  }
  exceptions[['filename.invalid']]   <- \(invoke, filename = NULL) { 
    if (invoke) {
      stop("Invalid filename: ", filename, ".", call. = FALSE)
    }
  }
  exceptions[['normalized.invalid']] <- \(invoke, path = NULL) {
    if (invoke) {
      stop("Invalid normalized path: ", path, ".", call. = FALSE)
    }
  }
  exceptions[['filepath.invalid']]   <- \(invoke, filepath = NULL) {
    if (invoke) {
      stop("Invalid filepath: ", filepath, ".", call. = FALSE)
    }
  }
  return(exceptions)
}