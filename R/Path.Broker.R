Path.Broker <- \() {
  operations <- list()
  operations[['get.user.path']]   <- \() {
    path.expand('~')
  }
  operations[['get.config.filename']] <- \() { 
    '.Renviron'
  }
  operations[['normalize.path']]     <- \(path) {
    gsub("\\\\", "/", path)
  }
  operations[['combine.path']]       <- \(path, filename) {
    path |> file.path(filename)
  }
  operations[['filepath.exists']]    <- \(filepath) {
    filepath |> file.exists()
  }
  operations[['create.filepath']]    <- \(filepath) {
    filepath |> file.create()
  }
  return(operations)
}