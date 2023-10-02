#' Manage Environment Variables
#'
#' @description
#' `.Renviron` configuration file is well suited to management sensitive information. 
#' This `Environment` package makes defining and reading environment variables straightforward.
#' 
#' `Environment()` returns a set of utility functions that can be used to interact with `.Renviron` files:
#' * The first function: `Open.Config.File`, will open an existing or a new empty `.Renviron` configuration file.
#' Users can then add environment variables by defining `'key'='value'` pairs.
#' * The second function: `Get.Env.Variable`, will read the value of the matching key (name) from the configuration file.
#' * The third function: `Cache.Env.Variable`, will cache the value of the matching key (name) in the current R session.
#' @usage NULL
#' @returns A `list` of utility functions: 
#' * `Open.Config.File()`
#' * `Get.Env.Variable(name)`
#' * `Cache.Env.Variable(name, value)`
#' @export 
Environment <- \() {
  Environment.Orchestrator()
}

.onLoad <- \(libname, pkgname) {
  orchestrator <- Environment.Orchestrator()
  assign("Open.Config.File", orchestrator[['Open.Config.File']], envir = .GlobalEnv)
  assign("Get.Env.Variable", orchestrator[['Get.Env.Variable']], envir = .GlobalEnv)
  assign("Cache.Env.Variable", orchestrator[['Cache.Env.Variable']], envir = .GlobalEnv)
  assign("Clear.Env.Variable", orchestrator[['Clear.Env.Variable']], envir = .GlobalEnv)
}