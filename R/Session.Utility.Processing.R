Session.Utility.Processing <- \(service) {
  processors <- list()
  processors[['GetIDEInUse']] <- \() {
    if(service[["VSCodeInUse"]]() |> isFALSE()) {
      return("RStudio")
    }
    if(service[['VSCodeInUse']]()) {
      return("VSCode")
    }
  }
  return(processors)
}