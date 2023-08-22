Session.Utility.Exceptions <- \() {
  exceptions <- list()
  exceptions[['NavigateToFileExceptions']] <- \() {}
  exceptions[['PathNotFound']] <- \(invoke, path = NULL) {
    if (invoke) {
      stop("Path not found: ", path, ".", call. = FALSE)
    } 
  }
  exceptions[['FileNotFound']] <- \() { }
  return(exceptions)
}