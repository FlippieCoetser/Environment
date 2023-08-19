Path.Utility.Service <- \() {
  services <- list()
  services[['GetUserHomePath']] <- \() {}
  services[['GetConfigFilename']] <- \() {}
  return(services)
}