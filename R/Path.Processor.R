Path.Processor <- \(service) {
  processes <- list()
  processes[['GetConfigFilepath']]   <- \() {
    filename <- service[['GetConfigFilename']]()

    service[['GetUserHomePath']]() |> 
    service[['NormalizePath']]()   |> 
    service[['CombinePath']](filename)
  }
  processes[['EnsureFilepathExist']] <- \(filepath) {
    filepath.exists <- filepath |> service[['FilepathExists']]()

    if(!filepath.exists) {
      filepath |> service[['CreateFilepath']]()
    }
    return(filepath)
  }
  return(processes)
}