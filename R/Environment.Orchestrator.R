#' Environment Variable Orchestrator
#'
#' @description
#' Provides a suite of utility functions for managing environment variables in the `.Renviron` file. 
#' This includes initialization, retrieval, caching, and clearing of environment variables, enhancing secure management of sensitive data.
#'
#' @details
#' The Environment.Orchestrator function initializes and provides access to the following utility functions:
#'
#' @return A list of utility functions that facilitate direct interactions with environment variables, structured as follows:
#' \describe{
#'   \item{\code{open.config.file}}{Opens or creates the `.Renviron` file, enabling the user to manage environment variables.}
#'   \item{\code{get.env.variable}}{Retrieves the value of an environment variable by its key.}
#'   \item{\code{cache.env.variable}}{Temporarily stores an environment variable value during the current R session.}
#'   \item{\code{clear.env.variable}}{Removes a cached environment variable from the current session.}
#' }
Environment.Orchestrator <- \() {
  path <- 
    Path.Broker()  |> 
    Path.Service() |> 
    Path.Processor()

  session <- 
    Session.Broker()  |> 
    Session.Service() |> 
    Session.Processor()

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