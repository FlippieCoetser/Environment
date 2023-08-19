#' Manage Environment Variables
#'
#' @description
#' `.Renviron` configuration file is well suited to management sensitive information. 
#' This `Environment` package makes defining and reading environment variables straightforward.
#' 
#' `Utility.Validation()` is an internal function that returns a set of validators used by `Utility.Service()`.
#' * The first validator: `Name`, is used to check if a name argument was provided.
#' * The second validator: `Value`, is used to check if a value for environment variable was found.
#' @usage NULL
#' @returns A `list` of validators: 
#' * `Name()`
#' * `Value()`
Utility.Validation <- \() {
  exception <- Utility.Exceptions()

  validations <- list()
  validations[["IsEmpty"]] <- \(member) member |> (\(x){ x == "" })()
  validations[["IsNull"]]  <- \(member) member |> is.null()

  validations[["Name"]] <- \(name) {
    name |> validations[["IsNull"]]() |> exception[["NameIsNull"]]()
    return(name)
  }
  validations[["Value"]] <- \(value,name) {
    value |> validations[["IsEmpty"]]() |> exception[["ValueIsEmpty"]](name)
    return(value)
  }
  return(validations)
}
