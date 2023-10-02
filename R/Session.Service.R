Session.Service <- \(broker) {
  validate <- Session.Validator()
  
  services <- list()
  services[['Has.RStudio.API']]     <- \() {
    broker[["Has.RStudio.API"]]()
  }
  services[['Has.NavigateToFilepath']] <- \() {
    broker[["Has.NavigateToFilepath"]]()
  }
  services[['Navigate.To.Filepath']]    <- \(filepath) {
    filepath |> validate[['Filepath']]()
    filepath |> broker[["Navigate.To.Filepath"]]() |> validate[["Navigation.Response"]]()  
  }
  services[['IDE.InUse']]          <- \() { 
    broker[["IDE.InUse"]]()
  }
  services[['VSCode.InUse']]       <- \() {
    broker[["VSCode.InUse"]]()
  }
  services[['Get.Env.Variable']]    <- \(name) {
    name |> validate[['Name']]()
    name |> broker[["Get.Env.Variable"]]() |> validate[['Value']](name)
  }
  services[['Cache.Env.Variable']]  <- \(name, value) {
    name  |> validate[['Name']]()
    value |> validate[['Value']]()
    
    name |> broker[["Cache.Env.Variable"]](value)
  }
  services[['Clear.Env.Variable']]  <- \(name) {
    name |> validate[['Name']]()
    name |> broker[["Clear.Env.Variable"]]()
  }
  return(services)
}