Session.Processor <- \(service) {
  validate <- Session.Validator()

  processes <- list()
  processes[['GetIDEInUse']]      <- \() {
    if(service[["IDEInUse"]]() |> isFALSE()) {
      return("None")
    }
    if(service[["VSCodeInUse"]]() |> isFALSE()) {
      return("RStudio")
    }
    if(service[['VSCodeInUse']]()) {
      return("VSCode")
    }
  }
  processes[['CheckIDEInUse']]    <- \(ide) {
    ide |> validate[['IDE']]()
    
    service[['HasRStudioAPI']]() |> validate[['APIAvailability']](ide)
    service[['HasNavigateToFile']]() |> validate[['APICapability']](ide)
  }
  processes[['OpenFilepath']]     <- \(filepath) {
    processes[['GetIDEInUse']]() |> processes[['CheckIDEInUse']]()

    filepath |> service[['NavigateToFile']]()
  }
  processes[['GetEnvVariable']]   <- \(name) {
    name |> service[['GetEnvVariable']]()
  }
  processes[['CacheEnvVariable']] <- \(name, value) {  
    name |> service[['CacheEnvVariable']](value)
  }
  processes[['ClearEnvVariable']]  <- \(name) {
    name |> service[['ClearEnvVariable']]()
  }
  return(processes)
}