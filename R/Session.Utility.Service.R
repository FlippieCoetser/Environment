Session.Utility.Service <- \(broker) {
  validate <- Session.Utility.Validation()
  exception <- Session.Utility.Exceptions()
  services <- list()
  services[['HasRStudioAPI']] <- \() {
    broker[["HasRStudioAPI"]]()
  }
  services[['HasNavigateToFile']] <- \() {
    broker[["HasNavigateToFile"]]()
  }
  services[['NavigateToFile']] <- \(filepath) {
    filepath |> broker[["NavigateToFile"]]() |> validate[["NavigationResponse"]]()  
  }
  return(services)
}