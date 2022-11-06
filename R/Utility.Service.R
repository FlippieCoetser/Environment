#' Manage Environment Variables
#'
#' @description
#' `.Renviron` configuraiton file is well suited to management sensitive information. 
#' This `Environment` package makes defining and reading environment variables straightforward.
#' 
#' `Utility.Service()` returns a set of utility functions that can be used to ineract with `.Renviron` files:
#' * The first function: `OpenConfigurationFile`, will open an existing or a new empty `.Renviron` configuration file.
#' Users can then add environment variables by defining `'key'='value'` pairs.
#' * The second function: `GetVariableByName`, will read the value of the matching key (name) from the configuration file.
#' @usage NULL
#' @returns A `list` of utility functions: 
#' * `OpenConfigurationFile()`
#' * `GetVariableByName(name)`
#' @examples
#' utility <- Utility.Service()
#' 
#' utility[["OpenConfigurationFile"]]()
#' 
#' rm(utility)
#' @export
Utility.Service <- \() {
  validate <- Utility.Validation.Service()

  service <- list()
  service[["OpenConfigurationFile"]] <- \() {
      usethis::edit_r_environ()
  }
  service[["GetVariableByName"]] <- \(name)
    name |>
      validate[["Name"]]()     |>
        Sys.getenv()           |>
          validate[["Value"]]()

  service[["OpenConfigurationFile"]] <- \() {
      usethis::edit_r_environ()
  }
  return(service)
}
