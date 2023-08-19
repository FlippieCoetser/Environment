Session.Utility.Broker <- \() {
  operations <- list()
  operations[['HasRStudioAPI']]     <- \() {
    rstudioapi::isAvailable()
  }
  operations[['HasNavigateToFile']] <- \() {
    rstudioapi::hasFun("navigateToFile")
  }
  operations[['NavigateToFile']]    <- \(path) {
    path |> rstudioapi::navigateToFile()
  }
  operations[['IDEInUse']]          <- \() {
    interactive()
  }
  operations[['VSCodeInUse']]       <- \() {
    Sys.getenv("TERM_PROGRAM") == "vscode"
  }
  return(operations)
}