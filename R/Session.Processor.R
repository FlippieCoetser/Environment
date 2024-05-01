Session.Processor <- \(service) {
  validate <- Session.Validator()

  processes <- list()
  processes[['get.active.IDE']]      <- \() {
    if(service[["IDE.active"]]() |> isFALSE()) {
      return("None")
    }
    if(service[["VSCode.active"]]() |> isFALSE()) {
      return("RStudio")
    }
    if(service[['VSCode.active']]()) {
      return("VSCode")
    }
  }
  processes[['check.active.IDE']]    <- \(ide) {
    ide |> validate[['IDE']]()
    
    service[['has.RStudio.api']]() |> validate[['api.availability']](ide)
    service[['has.navigate.to.file']]() |> validate[['api.capability']](ide)
  }
  processes[['open.filepath']]     <- \(filepath) {
    processes[['get.active.IDE']]() |> processes[['check.active.IDE']]()

    filepath |> service[['navigate.to.file']]()
  }
  processes[['get.env.variable']]   <- \(name) {
    name |> service[['get.env.variable']]()
  }
  processes[['cache.env.variable']] <- \(name, value) {  
    name |> service[['cache.env.variable']](value)
  }
  processes[['clear.env.variable']]  <- \(name) {
    name |> service[['clear.env.variable']]()
  }
  return(processes)
}