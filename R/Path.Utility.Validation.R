Path.Utility.Validation <- \() {
  validators <- list()
  validators[['Path']] <- \(path) {
    pattern <- "(^([a-zA-Z]:)(\\[a-zA-Z0-9_-.]*)*)|((/[a-zA-Z0-9_-.]*)*)"
    check <- pattern |> grepl(path)

    if (check == TRUE) {
      return(path)
    } else {
      return(NA)
    }
  }
  return(validators)
}