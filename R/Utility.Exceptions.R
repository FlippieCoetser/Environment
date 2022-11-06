#' Manage Environment Variables
#'
#' @description
#' `.Renviron` configuraiton file is well suited to management sensitive information. 
#' This `Environment` package makes defining and reading environment variables straightforward.
#' 
#' `Utility.Exceptions()` is an internal function that returns a set of exceptions used by `Utility.Validation.Service`.
#' * The first exception: `NameIsNull`, indicates to the user that no environment variable name has been provided.
#' * The second exception: `ValueIsEmpty`, indicates to the user than no machting value for key (name) could be found in `.Renviron` file.
#' @usage NULL
#' @returns A `list` of exceptions: 
#' * `NameIsNull()`
#' * `ValueIsEmpty()`
Utility.Exceptions <- \() {
    exception <- list()
    exception[["NameIsNull"]]   <- \(invoke) {
        if (invoke) {
            stop("Name is null. Function requires name of environment variable to retrieve its value.")
        }
    }
    exception[["ValueIsEmpty"]] <- \(invoke) {
        if (invoke) {
            stop("No value for environment variable with provided name found. Check .Renviron configuration file.")
        }
    }

    return(exception)
}