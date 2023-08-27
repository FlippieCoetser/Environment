#' Manage Environment Variables
#'
#' @description
#' `.Renviron` configuration file is well suited to management sensitive information. 
#' This `Environment` package makes defining and reading environment variables straightforward.
#' 
#' `Utility.Service()` returns a set of utility functions that can be used to interact with `.Renviron` files:
#' * The first function: `OpenConfigurationFile`, will open an existing or a new empty `.Renviron` configuration file.
#' Users can then add environment variables by defining `'key'='value'` pairs.
#' * The second function: `GetVariableByName`, will read the value of the matching key (name) from the configuration file.
#' @usage NULL
#' @returns A `list` of utility functions: 
#' * `OpenConfigurationFile()`
#' * `GetVariableByName(name)`
#' @export
Utility.Service <- \() {
  orchestrator <- Environment.Orchestrator()

  service <- list()
  service[["OpenConfigurationFile"]] <- \() {
    orchestrator[["OpenConfigFile"]]()
  }
  service[["GetVariableByName"]]     <- \(name) {
    name |> orchestrator[['GetEnvVariable']]()
  }
  return(service)
}
