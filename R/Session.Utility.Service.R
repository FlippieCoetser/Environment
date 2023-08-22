Session.Utility.Service <- \(broker) {
  services <- list()
  services[['HasRStudioAPI']] <- \() {
    broker[["HasRStudioAPI"]]()
  }
  return(services)
}