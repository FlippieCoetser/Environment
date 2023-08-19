Path.Utility.Service <- \() {
  services <- list()
  services[['GetUserHomePath']] <- \() {}
  services[['GetConfigFilename']] <- \() {}
  services[['NormalizePath']] <- \(path) {}
  services[['CombinePath']] <- \(path, filename) {}
  services[['FilepathExists']] <- \(filepath) {}
  return(services)
}