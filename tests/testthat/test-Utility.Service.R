test_that("name |> environment[['GetVariableByName']]() returns value which match with value in .Renviron file", {
    # Given
    environment <- Utility.Service()

    variable.Name  <- "Username"
    input.name <- variable.Name

    # Then
    input.name |> 
        environment[["GetVariableByName"]]() |>
            is.null() |> 
                expect_equal(FALSE)
})

test_that("name |> environment[['OpenConfigurationFile']]() should not throw an error", {
    # Given
    environment <- Utility.Service()

    # Then
    environment[["OpenConfigurationFile"]]() |> expect_no_error()
})