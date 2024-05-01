Path.Validator <- \() {
  exception <- Path.Validation.Exceptions()

  validations <- list()
  validations[['Path']]       <- \(path) {
    pattern <- "^(([a-zA-Z]:)(\\\\[a-zA-Z0-9_.-]+)+)$|^(/([a-zA-Z0-9_.-]*/?)*)$|^(([a-zA-Z]:)(/[a-zA-Z0-9_.-]+)+)$"
    pattern |> grepl(path) |> isFALSE() |> exception[['path.invalid']](path)

    return(path)
  }
  validations[['Filename']]   <- \(filename) {
    pattern <- "^[a-zA-Z0-9_.-]*[a-zA-Z0-9]$"
    pattern |> grepl(filename) |> isFALSE() |> exception[['filename.invalid']](filename)

    return(filename)
  }
  validations[['Normalized']] <- \(path) {
    pattern <- "^(([a-zA-Z]:)(/[a-zA-Z0-9_.-]+)+)$|^(/([a-zA-Z0-9_.-]*/?)*)$"
    pattern |> grepl(path) |> isFALSE() |> exception[['normalized.invalid']](path)

    return(path)
  }
  validations[['filepath']]   <- \(filepath) {
    pattern <- "^(([a-zA-Z]:)(/[a-zA-Z0-9_.-]+)+/[a-zA-Z0-9_.-]*[a-zA-Z0-9])|(/([a-zA-Z0-9_.-]*/?)*[a-zA-Z0-9_.-]*[a-zA-Z0-9])$"
    pattern |> grepl(filepath) |> isFALSE() |> exception[['filepath.invalid']](filepath)
    return(filepath)
  }
  return(validations)
}