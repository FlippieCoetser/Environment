Session.Service <- \(broker) {
  validate <- Session.Validator()
  
  services <- list()
  services[['has.RStudio.api']]     <- \() {
    broker[["has.RStudio.api"]]()
  }
  services[['has.navigate.to.file']] <- \() {
    broker[["has.navigate.to.file"]]()
  }
  services[['navigate.to.file']]    <- \(filepath) {
    filepath |> validate[['filepath']]()
    filepath |> broker[["navigate.to.file"]]() |> validate[["navigation.response"]]()  
  }
  services[['IDE.active']]          <- \() { 
    broker[["IDE.active"]]()
  }
  services[['VSCode.active']]       <- \() {
    broker[["VSCode.active"]]()
  }
  services[['get.env.variable']]    <- \(name) {
    name |> validate[['Name']]()
    name |> broker[["get.env.variable"]]() |> validate[['Value']](name)
  }
  services[['cache.env.variable']]  <- \(name, value) {
    name  |> validate[['Name']]()
    value |> validate[['Value']]()
    
    name |> broker[["cache.env.variable"]](value)
  }
  services[['clear.env.variable']]  <- \(name) {
    name |> validate[['Name']]()
    name |> broker[["clear.env.variable"]]()
  }
  return(services)
}