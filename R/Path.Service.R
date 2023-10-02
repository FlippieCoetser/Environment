Path.Service <- \(broker) {
  validate <- Path.Validator()

  services <- list()
  services[['Get.User.Path']]   <- \() {
    broker[['Get.User.Path']]() |> validate[['Path']]()
  }
  services[['Get.Config.Filename']] <- \() {
    broker[['Get.Config.Filename']]() |> validate[['Filename']]()
  }
  services[['Normalize.Path']]     <- \(path) {
    path |> validate[['Path']]()
    path |> broker[['Normalize.Path']]() |> validate[['Normalized']]()
  }
  services[['Combine.Path']]       <- \(path, filename) {
    path     |> validate[['Normalized']]()
    filename |> validate[['Filename']]()
    
    path |> broker[['Combine.Path']](filename) |> validate[['Filepath']]()
  }
  services[['Filepath.Exists']]    <- \(filepath) {
    filepath |> validate[['Filepath']]()
    filepath |> broker[['Filepath.Exists']]()
  }
  services[['Create.Filepath']]    <- \(filepath) {
    filepath |> validate[['Filepath']]()
    filepath |> broker[['Create.Filepath']]()
  }
  return(services)
}