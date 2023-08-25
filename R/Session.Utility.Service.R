Session.Utility.Service <- \(broker) {
  validate <- Session.Utility.Validation()
  exception <- Session.Utility.Exceptions()
  services <- list()
  services[['HasRStudioAPI']]     <- \() {
    broker[["HasRStudioAPI"]]()
  }
  services[['HasNavigateToFile']] <- \() {
    broker[["HasNavigateToFile"]]()
  }
  services[['NavigateToFile']]    <- \(filepath) {
    filepath |> validate[['Filepath']]()
    filepath |> broker[["NavigateToFile"]]() |> validate[["NavigationResponse"]]()  
  }
  services[['IDEInUse']]          <- \() { 
    broker[["IDEInUse"]]()
  }
  services[['VSCodeInUse']]       <- \() {
    broker[["VSCodeInUse"]]()
  }
  services[['GetEnvVariable']]    <- \(name) {
    name |> validate[['Name']]()
    name |> broker[["GetEnvVariable"]]() |> validate[['Value']](name)
  }
  services[['CacheEnvVariable']]  <- \(name, value) {
    name |> validate[['Name']]()
    name |> broker[["CacheEnvVariable"]](value)
  }
  return(services)
}