Session.Utility.Processing <- \(service) {
  validate <- Session.Utility.Validation()

  processors <- list()
  processors[['GetIDEInUse']] <- \() {
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
  processors[['OpenConfigFile']] <- \(filepath) {
    ide <- processors[['GetIDEInUse']]()
    ide |> validate[['IDE']]()

  }
  return(processors)
}