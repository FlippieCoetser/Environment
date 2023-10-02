Session.Broker <- \() {
  operations <- list()
  operations[['Has.RStudio.API']]     <- \() {
    rstudioapi::isAvailable()
  }
  operations[['Has.NavigateToFilepath']] <- \() {
    rstudioapi::hasFun("navigateToFile")
  }
  operations[['Navigate.To.Filepath']]    <- \(filepath) {
    filepath |> rstudioapi::navigateToFile()
  }
  operations[['IDE.InUse']]          <- \() {
    interactive()
  }
  operations[['VSCode.InUse']]       <- \() {
    Sys.getenv("TERM_PROGRAM") == "vscode"
  }
  operations[['Get.Env.Variable']]    <- \(name) {
    name |> Sys.getenv()
  }
  operations[['Cache.Env.Variable']]  <- \(name, value) {
    entry <- list()
    entry[[name]] <- value
    "Sys.setenv" |> do.call(entry)
  }
  operations[['Clear.Env.Variable']]  <- \(name) {
    entry <- list()
    entry[[name]] <- ''
    "Sys.setenv" |> do.call(entry)
  }
  return(operations)
}