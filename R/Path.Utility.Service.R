Path.Utility.Service <- \(broker) {
  services <- list()
  services[['GetUserHomePath']] <- \() {
    broker[['GetUserHomePath']]()
  }
  services[['GetConfigFilename']] <- \() {
    broker[['GetConfigFilename']]()
  }
  services[['NormalizePath']] <- \(path) {}
  services[['CombinePath']] <- \(path, filename) {}
  services[['FilepathExists']] <- \(filepath) {}
  services[['CreateFilepath']] <- \(filepath) {}
  return(services)
}