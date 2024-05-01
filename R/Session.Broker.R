Session.Broker <- \() {
  operations <- list()
  operations[['has.RStudio.api']]     <- \() {
    rstudioapi::isAvailable()
  }
  operations[['has.navigate.to.file']] <- \() {
    rstudioapi::hasFun("navigateToFile")
  }
  operations[['navigate.to.file']]    <- \(filepath) {
    filepath |> rstudioapi::navigateToFile()
  }
  operations[['IDE.active']]          <- \() {
    interactive()
  }
  operations[['VSCode.active']]       <- \() {
    Sys.getenv("TERM_PROGRAM") == "vscode"
  }
  operations[['get.env.variable']]    <- \(name) {
    name |> Sys.getenv()
  }
  operations[['cache.env.variable']]  <- \(name, value) {
    entry <- list()
    entry[[name]] <- value
    "Sys.setenv" |> do.call(entry)
  }
  operations[['clear.env.variable']]  <- \(name) {
   name |> Sys.unsetenv()
  }
  return(operations)
}