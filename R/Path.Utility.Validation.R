Path.Utility.Validation <- \() {
  exception <- Path.Utility.Exceptions()

  validators <- list()
  validators[['Path']]       <- \(path) {
    pattern <- "^(([a-zA-Z]:)(\\\\[a-zA-Z0-9_.-]+)+)$|^(/([a-zA-Z0-9_.-]*/?)*)$"
    pattern |> grepl(path) |> isFALSE() |> exception[['InvalidPath']](path)

    return(path)
  }
  validators[['Filename']]   <- \(filename) {
    pattern <- "^[a-zA-Z0-9_.-]*[a-zA-Z0-9]$"
    pattern |> grepl(filename) |> isFALSE() |> exception[['InvalidFilename']](filename)

    return(filename)
  }
  validators[['Normalized']] <- \(path) {
    pattern <- "^(([a-zA-Z]:)(/[a-zA-Z0-9_.-]+)+)$|^(/([a-zA-Z0-9_.-]*/?)*)$"
    pattern |> grepl(path) |> isFALSE() |> exception[['InvalidNormalized']](path)

    return(path)
  }
  validators[['Filepath']]   <- \(filepath) {
    pattern <- "^(([a-zA-Z]:)(/[a-zA-Z0-9_.-]+)+/[a-zA-Z0-9_.-]*[a-zA-Z0-9])|(/([a-zA-Z0-9_.-]*/?)*[a-zA-Z0-9_.-]*[a-zA-Z0-9])$"
    pattern |> grepl(filepath) |> isFALSE() |> exception[['InvalidFilepath']](filepath)
    return(filepath)
  }
  return(validators)
}