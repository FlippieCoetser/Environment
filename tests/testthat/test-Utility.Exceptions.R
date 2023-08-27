describe('Utility.Exceptions', {
  it('Exist',{
    # Then
    Utility.Exceptions |> expect.exist()
  })
})

describe("When exceptions <- Utility.Exceptions()", {
  it("then exceptions is a list.", {
    # Given
    exceptions <- Utility.Exceptions()

    # Then
    exceptions |> expect.list()
  })
  it("then exceptions contains NameIsNull exception.", {
    # Given
    exceptions <- Utility.Exceptions()

    # Then
    exceptions[["NameIsNull"]] |> expect.exist()
  })
  it("then exceptions contains ValueIsEmpty exception.", {
    # Given
    exceptions <- Utility.Exceptions()

    # Then
    exceptions[["ValueIsEmpty"]] |> expect.exist()
  })
})

describe("When input |> exception[['NameIsNull']]()",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Utility.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["NameIsNull"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Utility.Exceptions()

    expected.error <- "Name is null. Expected a name for the environment to retrieve its value."

    # When
    input <- TRUE

    # Then
    input |> exception[["NameIsNull"]]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['ValueIsEmpty']](name)",{
  it("Then no exception is thrown if input is FALSE",{
    # Given
    exception <- Utility.Exceptions()

    variable.name  <- "name"

    # When
    input <- FALSE

    # Then
    input |> exception[["ValueIsEmpty"]](variable.name) |> expect.no.error()
  })
  it("Then an exception is thrown if input is TRUE",{
    # Given
    exception <- Utility.Exceptions()

    variable.name  <- "name"
    expected.error <- paste0("No value found for provided environment variable:", variable.name, ". Please check .Renviron configuration file.")

    # When
    input <- TRUE

    # Then
    input |> exception[["ValueIsEmpty"]](variable.name) |> expect.error(expected.error)
  })
})