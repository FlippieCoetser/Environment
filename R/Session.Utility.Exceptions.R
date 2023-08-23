Session.Utility.Exceptions <- \() {
  exceptions <- list()
  exceptions[['NavigateToFileExceptions']] <- \(error) {
    filepath <- sub('.*?"(.*?)":.*', '\\1', error[['message']])

    'cannot find the path' |> grepl(error) |> exceptions[['PathNotFound']](filepath) 
    'cannot find the file' |> grepl(error) |> exceptions[['FileNotFound']](filepath)
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
  exceptions[['InvalidFilepath']]  <- \(invoke, filepath = NULL) {
    if (invoke) {
      stop("Invalid filepath: ", filepath, ".", call. = FALSE)
    }
  }
  return(exceptions)
}