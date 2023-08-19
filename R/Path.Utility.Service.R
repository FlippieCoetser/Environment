Path.Utility.Service <- \(broker) {
  services <- list()
  services[['GetUserHomePath']] <- \() {
    broker[['GetUserHomePath']]()
  }
  services[['GetConfigFilename']] <- \() {
    broker[['GetConfigFilename']]()
  }
  services[['NormalizePath']] <- \(path) {
    path |> broker[['NormalizePath']]()
  }
  services[['CombinePath']] <- \(path, filename) {
    path |> broker[['CombinePath']](filename)
  }
  services[['FilepathExists']] <- \(filepath) {
    filepath |> broker[['FilepathExists']]()
  }
  services[['CreateFilepath']] <- \(filepath) {}
  return(services)
}