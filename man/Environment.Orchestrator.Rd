% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Environment.Orchestrator.R
\name{Environment.Orchestrator}
\alias{Environment.Orchestrator}
\title{Environment Variable Orchestrator}
\usage{
Environment.Orchestrator()
}
\value{
A list of utility functions that facilitate direct interactions with environment variables, structured as follows:
\describe{
\item{\code{open.config.file}}{Opens or creates the \code{.Renviron} file, enabling the user to manage environment variables.}
\item{\code{get.env.variable}}{Retrieves the value of an environment variable by its key.}
\item{\code{cache.env.variable}}{Temporarily stores an environment variable value during the current R session.}
\item{\code{clear.env.variable}}{Removes a cached environment variable from the current session.}
}
}
\description{
Provides a suite of utility functions for managing environment variables in the \code{.Renviron} file.
This includes initialization, retrieval, caching, and clearing of environment variables, enhancing secure management of sensitive data.
}
\details{
The Environment.Orchestrator function initializes and provides access to the following utility functions:
}
