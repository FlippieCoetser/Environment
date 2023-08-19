Path.Utility.Exceptions <- \() {
  exceptions <- list()
  exceptions[['InvalidPath']] <- \(invoke, path = NULL) {
    if (invoke) {
      stop("Invalid path: ", path, ".")
    } 
  }
  return(exceptions)
}