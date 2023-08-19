Path.Utility.Service <- \() {
  services <- list()
  services[['GetUserHomePath']] <- \() {}
  services[['GetConfigFilename']] <- \() {}
  services[['NormalizePath']] <- \(path) {}
  return(services)
}