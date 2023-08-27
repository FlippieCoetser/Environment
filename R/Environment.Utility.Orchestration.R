Environment.Utility.Orchestration <- \(...) {
  path <- 
    Path.Utility.Broker()  |> 
    Path.Utility.Service() |> 
    Path.Utility.Processing()

  session <- 
    Session.Utility.Broker()  |> 
    Session.Utility.Service() |> 
    Session.Utility.Processing()

  arguments <- list(...)
  if(arguments[['path']] |> is.null() |> isFALSE()) {
    path <- arguments[['path']]
  }
  if(arguments[['session']] |> is.null() |> isFALSE()) {
    session <- arguments[['session']]
  }

  orchestrations <- list()
  orchestrations[['OpenConfigFile']] <- \() {
    path[['GetConfigFilepath']]()   |> 
    path[['EnsureFilepathExist']]() |>
    session[['OpenFilepath']]()
  }
  orchestrations[['GetEnvVariable']] <- \(name) {
    name |> session[['GetEnvVariable']]()
  }
  return(orchestrations)
}