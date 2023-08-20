Path.Utility.Validation <- \() {
  exception <- Path.Utility.Exceptions()

  validators <- list()
  validators[['Path']] <- \(path) {
    pattern <- "^(([a-zA-Z]:)(\\\\[a-zA-Z0-9_.-]+)+)$|^(/([a-zA-Z0-9_.-]*/?)*)$"
    pattern |> grepl(path) |> isFALSE() |> exception[['InvalidPath']](path)

    return(path)
  }
  return(validators)
}