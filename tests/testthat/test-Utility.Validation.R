describe('Utility.Validation', {
  it('Exist',{
    # Then
    Utility.Validation |> expect.exist()
  })
})

describe("When validations <- Utility.Validation()", {
  it("then validations should be a list.", {
    # Given
    validations <- Utility.Validation()

    # Then
    validations |> expect.list()
  })
  it("then validations should contain Name validator.", {
    # Given
    validations <- Utility.Validation()

    # Then
    validations[["Name"]] |> expect.exist()
  })
  it("then validations should contain Value validator.", {
    # Given
    validations <- Utility.Validation()

    # Then
    validations[["Value"]] |> expect.exist()
  })
})

describe("When name |> validate[['Name']]()",{
  it("then name is returned when name is not NULL",{
    # Given
    validate <- Utility.Validation()

    # When 
    name <- "test"

    # Then
    name |> validate[["Name"]]() |> expect.equal(name)
  })
  it("then no exception is thrown when name is not NULL",{
    # Given
    validate <- Utility.Validation()

    # When 
    name <- "test"

    # Then
    name |> validate[["Name"]]() |> expect.no.error()
  })
  it("then an exception is thrown when name is NULL",{
    # Given
    validate <- Utility.Validation()

    expected.error <- "Name is null. Expected a name for the environment to retrieve its value."

    # When
    name <- NULL

    # Then
    name |> validate[["Name"]]() |> expect.error(expected.error)
  })
})

describe("When value |> validate[['Value']](name)",{
  it("then value is returned when value is not empty",{
    # Given
    validate <- Utility.Validation()

    # When
    name  <- "name" 
    value <- "value"

    # Then
    value |> validate[["Value"]](name) |> expect.equal(value)
  })
  it("then no exception is thrown when value is not empty",{
    # Given
    validate <- Utility.Validation()

    # When
    name  <- "name" 
    value <- "value"

    # Then
    value |> validate[["Value"]](name) |> expect.no.error()
  })
  it("then an exception is thrown when value is empty",{
    # Given
    validate <- Utility.Validation()

    # When
    name  <- "name" 
    value <- ""

    expected.error <- paste0("No value found for provided environment variable:", name, ". Please check .Renviron configuration file.")

    # Then
    value |> validate[["Value"]](name) |> expect.error(expected.error)
  })
})