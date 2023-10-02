Session.Processor <- \(service) {
  validate <- Session.Validator()

  processes <- list()
  processes[['GetIDE.InUse']]      <- \() {
    if(service[["IDE.InUse"]]() |> isFALSE()) {
      return("None")
    }
    if(service[["VSCode.InUse"]]() |> isFALSE()) {
      return("RStudio")
    }
    if(service[['VSCode.InUse']]()) {
      return("VSCode")
    }
  }
  processes[['CheckIDE.InUse']]    <- \(ide) {
    ide |> validate[['IDE']]()
    
    service[['Has.RStudio.API']]() |> validate[['API.Availability']](ide)
    service[['Has.NavigateToFilepath']]() |> validate[['API.Capability']](ide)
  }
  processes[['Open.Filepath']]     <- \(filepath) {
    processes[['GetIDE.InUse']]() |> processes[['CheckIDE.InUse']]()

    filepath |> service[['Navigate.To.Filepath']]()
  }
  processes[['Get.Env.Variable']]   <- \(name) {
    name |> service[['Get.Env.Variable']]()
  }
  processes[['Cache.Env.Variable']] <- \(name, value) {  
    name |> service[['Cache.Env.Variable']](value)
  }
  processes[['Clear.Env.Variable']]  <- \(name) {
    name |> service[['Clear.Env.Variable']]()
  }
  return(processes)
}