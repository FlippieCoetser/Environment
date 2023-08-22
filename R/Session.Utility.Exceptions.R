Session.Utility.Exceptions <- \() {
  exceptions <- list()
  exceptions[['NavigateToFileExceptions']] <- \() {}
  exceptions[['PathNotFound']] <- \() { }
  exceptions[['FileNotFound']] <- \() { }
  return(exceptions)
}