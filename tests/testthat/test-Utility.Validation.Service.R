test_that("name |> validate[['Name']]() should throw error when name is null", {
    # Given
    validate <- Utility.Validation.Service()

    name  <- NULL

    # Then
    name |> validate[["Name"]]() |> expect_error()
})
test_that("value |> validate[['Value']]() should throw error when value is empty", {
    # Given
    validate <- Utility.Validation.Service()

    error <- "No value for environment variable with provided name found. Check .Renviron configuration file."

    value <- ''

    # Then
    value |> validate[["Value"]]() |> expect_error(error)
})
