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
  operations[['GetEnvVariable']]    <- \() {}
  operations[['CacheEnvVariable']]  <- \() {}
  return(operations)
}