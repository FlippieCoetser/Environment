Path.Validator <- \() {
  exception <- Path.Exceptions()

  validations <- list()
  validations[['Path']]       <- \(path) {
    pattern <- "^(([a-zA-Z]:)(\\\\[a-zA-Z0-9_.-]+)+)$|^(/([a-zA-Z0-9_.-]*/?)*)$|^(([a-zA-Z]:)(/[a-zA-Z0-9_.-]+)+)$"
    pattern |> grepl(path) |> isFALSE() |> exception[['InvalidPath']](path)

    return(path)
  }
  validations[['Filename']]   <- \(filename) {
    pattern <- "^[a-zA-Z0-9_.-]*[a-zA-Z0-9]$"
    pattern |> grepl(filename) |> isFALSE() |> exception[['InvalidFilename']](filename)

    return(filename)
  }
  validations[['Normalized']] <- \(path) {
    pattern <- "^(([a-zA-Z]:)(/[a-zA-Z0-9_.-]+)+)$|^(/([a-zA-Z0-9_.-]*/?)*)$"
    pattern |> grepl(path) |> isFALSE() |> exception[['InvalidNormalized']](path)

    return(path)
  }
  validations[['Filepath']]   <- \(filepath) {
    pattern <- "^(([a-zA-Z]:)(/[a-zA-Z0-9_.-]+)+/[a-zA-Z0-9_.-]*[a-zA-Z0-9])|(/([a-zA-Z0-9_.-]*/?)*[a-zA-Z0-9_.-]*[a-zA-Z0-9])$"
    pattern |> grepl(filepath) |> isFALSE() |> exception[['InvalidFilepath']](filepath)
    return(filepath)
  }
  return(validations)
}