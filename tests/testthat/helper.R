environment <- 'ENVIRONMENT' |> Sys.getenv()

expect.exist    <- \(component) component |> is.null() |> expect_equal(FALSE) 
expect.list     <- \(members) members   |> is.list() |> expect_equal(TRUE)
expect.no.error <- \(exception) exception |> expect_no_error()
expect.error    <- \(exception, error) exception |> expect_error(error)
expect.equal    <- \(actual, expected) actual |> expect_equal(expected)