Session.Broker <- \() {
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
  operations[['GetEnvVariable']]    <- \(name) {
    name |> Sys.getenv()
  }
  operations[['CacheEnvVariable']]  <- \(name, value) {
    entry <- list()
    entry[[name]] <- value
    "Sys.setenv" |> do.call(entry)
  }
  operations[['ClearEnvVariable']]  <- \() {}
  return(operations)
}