Session.Utility.Broker <- \() {
  operations <- list()
  operations[['HasRStudioAPI']]     <- \() {
    rstudioapi::isAvailable()
  }
  operations[['HasNavigateToFile']] <- \() {
    rstudioapi::hasFun("navigateToFile")
  }
  operations[['NavigateToFile']]    <- \(filepath) {
    filepath |> rstudioapi::navigateToFile()
  }
  operations[['IDEInUse']]          <- \() {
    interactive()
  }
  operations[['VSCodeInUse']]       <- \() {
    Sys.getenv("TERM_PROGRAM") == "vscode"
  }
  operations[['GetEnvVariable']]    <- \(variable) {
    variable |> Sys.getenv()
  }
  operations[['CacheEnvVariable']]  <- \(variable, value) {
    entry <- value |> list() |> setNames(variable)
    "Sys.setenv" |> do.call(entry)
  }
  return(operations)
}