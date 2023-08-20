Path.Utility.Exceptions <- \() {
  exceptions <- list()
  exceptions[['InvalidPath']] <- \(invoke, path = NULL) {
    if (invoke) {
      stop("Invalid path: ", path, ".", call. = FALSE)
    } 
  }
  exceptions[['InvalidFilename']] <- \(invoke, filename = NULL) { 
    if (invoke) {
      stop("Invalid filename: ", filename, ".", call. = FALSE)
    }
  }
  exceptions[['InvalidNormalized']] <- \(invoke, path = NULL) {
    if (invoke) {
      stop("Invalid normalized path: ", path, ".", call. = FALSE)
    }
  }
  return(exceptions)
}