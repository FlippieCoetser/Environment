Session.Utility.Service <- \(broker) {
  services <- list()
  services[['HasRStudioAPI']] <- \() {
    broker[["HasRStudioAPI"]]()
  }
  services[['HasNavigateToFile']] <- \() {}
  return(services)
}