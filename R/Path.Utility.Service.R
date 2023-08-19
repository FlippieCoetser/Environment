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
  services[['CombinePath']] <- \(path, filename) {}
  services[['FilepathExists']] <- \(filepath) {}
  services[['CreateFilepath']] <- \(filepath) {}
  return(services)
}