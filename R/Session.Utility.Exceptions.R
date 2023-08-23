Session.Utility.Exceptions <- \() {
  exceptions <- list()
  exceptions[['NavigateToFileExceptions']] <- \(error) {
    filepath <- sub('.*?"(.*?)":.*', '\\1', error[['message']])
    
    'cannot find the path' |> grepl(error) |> exceptions[['PathNotFound']](filepath) 
  }
  exceptions[['PathNotFound']] <- \(invoke, path = NULL) {
    if (invoke) {
      stop("Path not found: ", path, ".", call. = FALSE)
    } 
  }
  exceptions[['FileNotFound']] <- \(invoke, file = NULL) {
    if (invoke) {
      stop("File not found: ", file, ".", call. = FALSE)
    } 
  }
  return(exceptions)
}