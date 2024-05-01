#' Manage Environment Variables
#'
#' @description
#' `.Renviron` configuration file is well suited to management sensitive information. 
#' This `Environment` package makes defining and reading environment variables straightforward.
#' 
#' `Environment.Orchestrator()` returns a set of utility functions that can be used to interact with `.Renviron` files:
#' * The first function: `open.config.file`, will open an existing or a new empty `.Renviron` configuration file.
#' Users can then add environment variables by defining `'key'='value'` pairs.
#' * The second function: `get.env.variable`, will read the value of the matching key (name) from the configuration file.
#' * The third function: `cache.env.variable`, will cache the value of the matching key (name) in the current R session.
#' @usage NULL
#' @returns A `list` of utility functions: 
#' * `open.config.file()`
#' * `get.env.variable(name)`
#' * `cache.env.variable(name, value)`
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
  orchestrations[['open.config.file']] <- \() {
    path[['get.config.filepath']]()   |> 
    path[['ensure.filepath.exist']]() |>
    session[['open.filepath']]()
  }
  orchestrations[['get.env.variable']] <- \(name) {
    name |> session[['get.env.variable']]()
  }
  orchestrations[['cache.env.variable']] <- \(name, value) {
    name |> session[['cache.env.variable']](value)
  }
  orchestrations[['clear.env.variable']] <- \(name) {
    name |> session[['clear.env.variable']]()
  }
  return(orchestrations)
}