Session.Utility.Exceptions <- \() {
  exceptions <- list()
  exceptions[['NavigateToFileExceptions']] <- \() {}
  exceptions[['PathNotFound']] <- \() { }
  return(exceptions)
}