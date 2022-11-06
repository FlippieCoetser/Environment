#' Manage Environment Variables
#'
#' @description
#' `.Renviron` configuraiton file is well suited to management sensitive information. 
#' This `Environment` package makes defining and reading environment variables straightforward.
#' 
#' `Utility.Validation.Service()` is an internal function that returns a set of validators used by `Utility.Service()`.
#' * The first validator: `Name`, is used to check if a name argument was provided.
#' * The second validator: `Value`, is used to check if a value for environment variable was found.
#' @usage NULL
#' @returns A `list` of validators: 
#' * `Name()`
#' * `Value()`
Utility.Validation.Service <- \() {
    exception <- Utility.Exceptions()

    validate <- list()
    validate[["IsEmpty"]] <- \(member) member |> (\(x){ x == "" })()
    validate[["IsNull"]]  <- \(member) member |> is.null()

    validate[["Name"]] <- \(name) {
        name |>
            validate[["IsNull"]]() |>
                exception[["NameIsNull"]]()

        return(name)
    }
    validate[["Value"]] <- \(value) {
        value |>
            validate[["IsEmpty"]]() |>
                exception[["ValueIsEmpty"]]()

        return(value)
    }
  return(validate)
}
