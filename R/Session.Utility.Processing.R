Session.Utility.Processing <- \(service) {
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
  processors[['OpenConfigFile']] <- \() {}
  return(processors)
}