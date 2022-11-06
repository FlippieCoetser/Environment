test_that("Utility.Exceptions() should return list of exceptions.",{
    # Given
    exceptions <- Utility.Exceptions()

    # Then
    exceptions |> is.list() |> expect_equal(TRUE)
})

test_that("List for exceptions returned from Utility.Exceptions should include NameIsNull.", {
    # Given
    exceptions <- Utility.Exceptions()

    # Then
    exceptions[["NameIsNull"]] |> is.null() |> expect_equal(FALSE)
})

test_that("TRUE |> exception[['NameIsNull']]() should throw error", {
    # Given
    exception <- Utility.Exceptions()

    error <- "Name is null. Function requires name of environment variable to retrieve its value."

    # Then
    TRUE |> exception[["NameIsNull"]]() |> expect_error(error)
})

test_that("List for exceptions returned from Environment.Utility.Exceptions should include ValueIsEmpty.",{
    # Given
    exceptions <- Utility.Exceptions()

    # Then
    exceptions[["ValueIsEmpty"]] |> is.null() |> expect_equal(FALSE)
})

test_that("TRUE |> exception[['ValueIsEmpty']]() should throw error", {
    # Given
    exception <- Utility.Exceptions()

    error <- "No value for environment variable with provided name found. Check .Renviron configuration file."

    # Then
    TRUE |> exception[["ValueIsEmpty"]]() |> expect_error(error)
})