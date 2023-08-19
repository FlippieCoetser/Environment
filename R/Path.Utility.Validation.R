Path.Utility.Validation <- \() {
  validators <- list()
  validators[['Path']] <- \(path) {
    pattern <- "^(?:[A-Za-z]:\\\\(?:[^\\\\]+\\\\)*[^\\\\]+|/(?:[^/]+/)*[^/]+)$"
    check <- pattern |> grepl(path)

    if (check == TRUE) {
      return(path)
    } else {
      return(NA)
    }
  }
  return(validators)
}