Path.Service <- \(broker) {
  validate <- Path.Validator()

  services <- list()
  services[['get.user.path']]   <- \() {
    broker[['get.user.path']]() |> validate[['Path']]()
  }
  services[['get.config.filename']] <- \() {
    broker[['get.config.filename']]() |> validate[['Filename']]()
  }
  services[['normalize.path']]     <- \(path) {
    path |> validate[['Path']]()
    path |> broker[['normalize.path']]() |> validate[['Normalized']]()
  }
  services[['combine.path']]       <- \(path, filename) {
    path     |> validate[['Normalized']]()
    filename |> validate[['Filename']]()
    
    path |> broker[['combine.path']](filename) |> validate[['filepath']]()
  }
  services[['filepath.exists']]    <- \(filepath) {
    filepath |> validate[['filepath']]()
    filepath |> broker[['filepath.exists']]()
  }
  services[['create.filepath']]    <- \(filepath) {
    filepath |> validate[['filepath']]()
    filepath |> broker[['create.filepath']]()
  }
  return(services)
}