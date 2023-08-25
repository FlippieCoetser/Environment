Path.Utility.Processing <- \(service) {
  processors <- list()
  processors[['GetConfigFilepath']] <- \() {
    filename <- service[['GetConfigFilename']]()

    service[['GetUserHomePath']]() |> 
    service[['NormalizePath']]()   |> 
    service[['CombinePath']](filename)
  }
  processors[['EnsureFilepathExist']] <- \() {}
  return(processors)
}