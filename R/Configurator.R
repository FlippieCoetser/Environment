#' Environment Variable Configurator
#'
#' @description
#' Provides a suite of utility functions for managing environment variables in the `.Renviron` file.
#' This includes initialization, retrieval, caching, and clearing of environment variables, enhancing secure management of sensitive data.
#'
#' @details
#' The Configurator function initializes and provides access to the following utility functions:
#'
#' @return A list of utility functions that facilitate direct interactions with environment variables, structured as follows:
#' \describe{
#'   \item{\code{open.config.file}}{Opens or creates the `.Renviron` file, enabling the user to manage environment variables.}
#'   \item{\code{get.env.variable}}{Retrieves the value of an environment variable by its key.}
#'   \item{\code{cache.env.variable}}{Temporarily stores an environment variable value during the current R session.}
#'   \item{\code{clear.env.variable}}{Removes a cached environment variable from the current session.}
#' }
#'
#' @examples
#' # Initialize the configurator
#' configurator <- Environment::Configurator()
#'
#' # Define the environment variable name and value
#' variable.name <- 'API_KEY'
#' variable.value <- '123456789'
#' 
#' #' # Set an environment variable for example purposes
#' Sys.setenv(API_KEY = variable.value)
#'
#' # Retrieve an environment variable
#' variable.name |> configurator[['get.env.variable']]()
#'
#' # Cache an environment variable
#' variable.name |> configurator[['cache.env.variable']](variable.value)
#'
#' # Clear a cached environment variable
#' variable.name |> configurator[['clear.env.variable']]()
#' @export 
Configurator <- \() {
  Environment.Orchestrator()
}

.onLoad <- \(libname, pkgname) {
  orchestrator <- Environment.Orchestrator()
  assign("open.config.file", orchestrator[['open.config.file']], envir = .GlobalEnv)
  assign("get.env.variable", orchestrator[['get.env.variable']], envir = .GlobalEnv)
  assign("cache.env.variable", orchestrator[['cache.env.variable']], envir = .GlobalEnv)
  assign("clear.env.variable", orchestrator[['clear.env.variable']], envir = .GlobalEnv)
}
