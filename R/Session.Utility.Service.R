Session.Utility.Service <- \(broker) {
  exception <- Session.Utility.Exceptions()
  services <- list()
  services[['HasRStudioAPI']] <- \() {
    broker[["HasRStudioAPI"]]()
  }
  services[['HasNavigateToFile']] <- \() {
    broker[["HasNavigateToFile"]]()
  }
  services[['NavigateToFile']] <- \(filepath) {
    tryCatch({
      filepath |> broker[["NavigateToFile"]]()
    }, warning = exception[['NavigateToFileExceptions']])
  }
  return(services)
}