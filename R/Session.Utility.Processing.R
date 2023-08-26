Session.Utility.Processing <- \(service) {
  processors <- list()
  processors[['GetIDEInUse']] <- \() {
    if(service[["VSCodeInUse"]]() |> isFALSE()) {
      return("RStudio")
    }
  }
  return(processors)
}