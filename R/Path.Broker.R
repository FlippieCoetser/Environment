Path.Broker <- \() {
  operations <- list()
  operations[['Get.User.Path']]   <- \() {
    path.expand('~')
  }
  operations[['Get.Config.Filename']] <- \() { 
    '.Renviron'
  }
  operations[['Normalize.Path']]     <- \(path) {
    gsub("\\\\", "/", path)
  }
  operations[['Combine.Path']]       <- \(path, filename) {
    path |> file.path(filename)
  }
  operations[['Filepath.Exists']]    <- \(filepath) {
    filepath |> file.exists()
  }
  operations[['Create.Filepath']]    <- \(filepath) {
    filepath |> file.create()
  }
  return(operations)
}