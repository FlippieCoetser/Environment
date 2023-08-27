Session.Utility.Processing <- \(service) {
  validate <- Session.Utility.Validation()

  processors <- list()
  processors[['GetIDEInUse']]      <- \() {
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
  processors[['CheckIDEInUse']]    <- \(ide) {
    ide |> validate[['IDE']]()
    
    service[['HasRStudioAPI']]() |> validate[['APIAvailability']](ide)
    service[['HasNavigateToFile']]() |> validate[['APICapability']](ide)
  }
  processors[['OpenFilepath']]     <- \(filepath) {
    processors[['GetIDEInUse']]() |> processors[['CheckIDEInUse']]()

    filepath |> service[['NavigateToFile']]()
  }
  processors[['GetEnvVariable']]   <- \(name) {
    name |> service[['GetEnvVariable']]()
  }
  processors[['CacheEnvVariable']] <- \(name, value) {  
    name |> service[['CacheEnvVariable']](value)
  }
  return(processors)
}