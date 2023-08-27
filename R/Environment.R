#' Manage Environment Variables
#'
#' @description
#' `.Renviron` configuration file is well suited to management sensitive information. 
#' This `Environment` package makes defining and reading environment variables straightforward.
#' 
#' `Environment()` returns a set of utility functions that can be used to interact with `.Renviron` files:
#' * The first function: `OpenConfigFile`, will open an existing or a new empty `.Renviron` configuration file.
#' Users can then add environment variables by defining `'key'='value'` pairs.
#' * The second function: `GetEnvVariable`, will read the value of the matching key (name) from the configuration file.
#' * The third function: `CacheEnvVariable`, will cache the value of the matching key (name) in the current R session.
#' @usage NULL
#' @returns A `list` of utility functions: 
#' * `OpenConfigFile()`
#' * `GetEnvVariable(name)`
#' * `CacheEnvVariable(name, value)`
#' @export 
Environment <- \() {
  Environment.Orchestrator()
}