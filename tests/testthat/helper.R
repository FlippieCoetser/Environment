environment <- 'ENVIRONMENT' |> Sys.getenv()

expect.exist    <- \(component) component |> is.null() |> expect_equal(FALSE) 
expect.list     <- \(members) members   |> is.list() |> expect_equal(TRUE)
expect.no.error <- \(exception) exception |> expect_no_error()
expect.error    <- \(exception, error) exception |> expect_error(error)
expect.equal    <- \(actual, expected) actual |> expect_equal(expected)
expect.warning  <- \(actual, expected = NULL) actual |> expect_warning(expected)
expect.true     <- \(actual) actual |> expect_equal(TRUE)
expect.false    <- \(actual) actual |> expect_equal(FALSE)
expect.empty    <- \(actual) actual |> expect_equal("")