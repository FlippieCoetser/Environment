Path.Processor <- \(service) {
  processes <- list()
  processes[['get.config.filepath']]   <- \() {
    filename <- service[['get.config.filename']]()

    service[['get.user.path']]() |> 
    service[['normalize.path']]()   |> 
    service[['combine.path']](filename)
  }
  processes[['ensure.filepath.exist']] <- \(filepath) {
    filepath.exists <- filepath |> service[['filepath.exists']]()

    if(!filepath.exists) {
      filepath |> service[['create.filepath']]()
    }
    return(filepath)
  }
  return(processes)
}