Path.Processing <- \(service) {
  processors <- list()
  processors[['GetConfigFilepath']]   <- \() {
    filename <- service[['GetConfigFilename']]()

    service[['GetUserHomePath']]() |> 
    service[['NormalizePath']]()   |> 
    service[['CombinePath']](filename)
  }
  processors[['EnsureFilepathExist']] <- \(filepath) {
    filepath.exists <- filepath |> service[['FilepathExists']]()

    if(!filepath.exists) {
      filepath |> service[['CreateFilepath']]()
    }
    return(filepath)
  }
  return(processors)
}