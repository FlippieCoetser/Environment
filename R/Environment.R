#' Manage Environment Variables
#'
#' @description
#' `.Renviron` configuration file is well suited to management sensitive information. 
#' This `Environment` package makes defining and reading environment variables straightforward.
#' 
#' `Environment()` returns a set of utility functions that can be used to interact with `.Renviron` files:
#' * The first function: `open.config.file`, will open an existing or a new empty `.Renviron` configuration file.
#' Users can then add environment variables by defining `'key'='value'` pairs.
#' * The second function: `get.env.variable`, will read the value of the matching key (name) from the configuration file.
#' * The third function: `cache.env.variable`, will cache the value of the matching key (name) in the current R session.
#' @usage NULL
#' @returns A `list` of utility functions: 
#' * `open.config.file()`
#' * `get.env.variable(name)`
#' * `cache.env.variable(name, value)`
#' @export 
Environment <- \() {
  Environment.Orchestrator()
}

.onLoad <- \(libname, pkgname) {
  orchestrator <- Environment.Orchestrator()
  assign("open.config.file", orchestrator[['open.config.file']], envir = .GlobalEnv)
  assign("get.env.variable", orchestrator[['get.env.variable']], envir = .GlobalEnv)
  assign("cache.env.variable", orchestrator[['cache.env.variable']], envir = .GlobalEnv)
  assign("clear.env.variable", orchestrator[['clear.env.variable']], envir = .GlobalEnv)
}