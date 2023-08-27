Path.Broker <- \() {
  operations <- list()
  operations[['GetUserHomePath']]   <- \() {
    path.expand('~')
  }
  operations[['GetConfigFilename']] <- \() { 
    '.Renviron'
  }
  operations[['NormalizePath']]     <- \(path) {
    gsub("\\\\", "/", path)
  }
  operations[['CombinePath']]       <- \(path, filename) {
    path |> file.path(filename)
  }
  operations[['FilepathExists']]    <- \(filepath) {
    filepath |> file.exists()
  }
  operations[['CreateFilepath']]    <- \(filepath) {
    filepath |> file.create()
  }
  return(operations)
}