#' Manage Environment Variables
#'
#' @description
#' `.Renviron` configuration file is well suited to management sensitive information. 
#' This `Environment` package makes defining and reading environment variables straightforward.
#' 
#' `Environment.Orchestrator()` returns a set of utility functions that can be used to interact with `.Renviron` files:
#' * The first function: `Open.Config.File`, will open an existing or a new empty `.Renviron` configuration file.
#' Users can then add environment variables by defining `'key'='value'` pairs.
#' * The second function: `Get.Env.Variable`, will read the value of the matching key (name) from the configuration file.
#' * The third function: `Cache.Env.Variable`, will cache the value of the matching key (name) in the current R session.
#' @usage NULL
#' @returns A `list` of utility functions: 
#' * `Open.Config.File()`
#' * `Get.Env.Variable(name)`
#' * `Cache.Env.Variable(name, value)`
Environment.Orchestrator <- \(...) {
  path <- 
    Path.Broker()  |> 
    Path.Service() |> 
    Path.Processor()

  session <- 
    Session.Broker()  |> 
    Session.Service() |> 
    Session.Processor()

  arguments <- list(...)
  if(arguments[['path']] |> is.null() |> isFALSE()) {
    path <- arguments[['path']]
  }
  if(arguments[['session']] |> is.null() |> isFALSE()) {
    session <- arguments[['session']]
  }

  orchestrations <- list()
  orchestrations[['Open.Config.File']] <- \() {
    path[['Get.Config.Filepath']]()   |> 
    path[['Ensure.Filepath.Exist']]() |>
    session[['Open.Filepath']]()
  }
  orchestrations[['Get.Env.Variable']] <- \(name) {
    name |> session[['Get.Env.Variable']]()
  }
  orchestrations[['Cache.Env.Variable']] <- \(name, value) {
    name |> session[['Cache.Env.Variable']](value)
  }
  orchestrations[['Clear.Env.Variable']] <- \(name) {
    name |> session[['Clear.Env.Variable']]()
  }
  return(orchestrations)
}