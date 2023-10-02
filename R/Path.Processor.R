Path.Processor <- \(service) {
  processes <- list()
  processes[['Get.Config.Filepath']]   <- \() {
    filename <- service[['Get.Config.Filename']]()

    service[['Get.User.Path']]() |> 
    service[['Normalize.Path']]()   |> 
    service[['Combine.Path']](filename)
  }
  processes[['Ensure.Filepath.Exist']] <- \(filepath) {
    filepath.exists <- filepath |> service[['Filepath.Exists']]()

    if(!filepath.exists) {
      filepath |> service[['Create.Filepath']]()
    }
    return(filepath)
  }
  return(processes)
}