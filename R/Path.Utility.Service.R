Path.Utility.Service <- \(broker) {
  validate <- Path.Utility.Validation()

  services <- list()
  services[['GetUserHomePath']] <- \() {
    broker[['GetUserHomePath']]() |> validate[['Path']]()
  }
  services[['GetConfigFilename']] <- \() {
    broker[['GetConfigFilename']]() |> validate[['Filename']]()
  }
  services[['NormalizePath']] <- \(path) {
    path |> validate[['Path']]()
    path |> broker[['NormalizePath']]() |> validate[['Normalized']]()
  }
  services[['CombinePath']] <- \(path, filename) {
    path |> validate[['Normalized']]()
    path |> broker[['CombinePath']](filename)
  }
  services[['FilepathExists']] <- \(filepath) {
    filepath |> broker[['FilepathExists']]()
  }
  services[['CreateFilepath']] <- \(filepath) {
    filepath |> broker[['CreateFilepath']]()
  }
  return(services)
}