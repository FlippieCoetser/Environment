set.env.variable <- \(name, value) {
  entry <- list()
  entry[[name]] <- value
  "Sys.setenv" |> do.call(entry)
}