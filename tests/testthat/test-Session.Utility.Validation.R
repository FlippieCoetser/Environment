describe('Session.Utility.Validation', {
  it('Exist',{
    # Then
    Session.Utility.Validation |> expect.exist()
  })
})

describe("When validators <- Session.Utility.Validation()",{
  it("then validators should be a list.", {
    # Given
    validators <- Session.Utility.Validation()

    # Then
    validators |> expect.list()
  })
  it("then validators should contain NavigationResponse validator.", {
    # Given
    validators <- Session.Utility.Validation()

    # Then
    validators[["NavigationResponse"]] |> expect.exist()
  })
  it("then validators should contain Filepath validator.", {
    # Given
    validators <- Session.Utility.Validation()

    # Then
    validators[["Filepath"]] |> expect.exist()
  })
  it("then validators should contain IsEmpty validator.", {
    # Given
    validators <- Session.Utility.Validation()

    # Then
    validators[["IsEmpty"]] |> expect.exist()
  })
  it("then validators should contain IsNull validator.", {
    # Given
    validators <- Session.Utility.Validation()

    # Then
    validators[["IsNull"]] |> expect.exist()
  })
  it("then validators should contain Name validator.",{
    # Given
    validators <- Session.Utility.Validation()

    # Then
    validators[["Name"]] |> expect.exist()
  })
  it("then validators should contain Value validator.",{
    # Given
    validators <- Session.Utility.Validation()

    # Then
    validators[["Value"]] |> expect.exist()
  })
  it("then validators should contain IDE Validator.",{
    # Given
    validators <- Session.Utility.Validation()

    # Then
    validators[["IDE"]] |> expect.exist()
  })
})

describe("When response |> validate[['NavigationResponse']]()",{
  it("then a PathNotFound exception should be thrown is response throws a warning containing path not found",{
    # Given
    validate <- Session.Utility.Validation()
    throw.warning <- \() {
      warning('path[1]="C:/Users/InvalidPath/Documents/.Renviron": The system cannot find the path specified.')
    }

    expected.error <- "Path not found: C:/Users/InvalidPath/Documents/.Renviron."
    
    # Then
    throw.warning() |> validate[["NavigationResponse"]]() |> expect.error(expected.error)
  })
  it("then a FileNotFound exception should be thrown if response throws a warning containing file not found",{
    # Given
    validate <- Session.Utility.Validation()
    throw.warning <- \() {
      warning('path[1]="C:/Users/Analyst/Documents/check.txt": The system cannot find the file specified.')
    }

    expected.error <- "File not found: C:/Users/Analyst/Documents/check.txt."
    
    # Then
    throw.warning() |> validate[["NavigationResponse"]]() |> expect.error(expected.error)
  })
})

describe("When filepath |> validate[['Filepath']]()",{
  it("then filepath should be returned if filepath is valid.",{
    # Given
    validate <- Session.Utility.Validation()

    input.filepath <- "C:/Users/username/Documents/.Renviron"
    expect.filepath <- input.filepath

    # When
    actual.filepath <-  input.filepath |> validate[["Filepath"]]()
    
    # Then
    actual.filepath |> expect.equal(expect.filepath)
  })
  it("then an exception should be thrown if filepath is invalid.",{
    # Given
    validate <- Session.Utility.Validation()

    filepath <- "C:\\Users\\username\\Documents\\.Renviron"
    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\.Renviron", ".")

    # Then
    filepath |> validate[["Filepath"]]() |> expect.error(expected.error)
  })
})

describe("When value |> validate[['IsEmpty']]()",{
  it("then True is return if value is empty.",{
    # Given
    validate <- Session.Utility.Validation()

    # When
    value <- ""

    # Then
    value |> validate[["IsEmpty"]]() |> expect.true()
  })
  it("then False is return if value is not empty.",{
    # Given
    validate <- Session.Utility.Validation()

    # When
    value <- "value"

    # Then
    value |> validate[["IsEmpty"]]() |> expect.false()
  })
})

describe("When value |> validate[['IsNull']]()",{
  it("then True is return if value is NULL.",{
    # Given
    validate <- Session.Utility.Validation()

    # When
    value <- NULL

    # Then
    value |> validate[["IsNull"]]() |> expect.true()
  })
  it("then False is return if value is not NULL.",{
    # Given
    validate <- Session.Utility.Validation()

    # When
    value <- "value"

    # Then
    value |> validate[["IsNull"]]() |> expect.false()
  })
})

describe("When name |> validate[['Name']]()",{
  it("then name is returned when name is not null",{
    # Given
    validate <- Session.Utility.Validation()

    # When
    name  <- "name" 

    # Then
    name |> validate[["Name"]]() |> expect.equal(name)
  })
  it("then no exception is thrown when name is not null",{
    # Given
    validate <- Session.Utility.Validation()

    # When
    name  <- "name" 

    # Then
    name |> validate[["Name"]]() |> expect.no.error()
  })
  it("then an exception is thrown when name is null",{
    # Given
    validate <- Session.Utility.Validation()

    expected.error <- "Name is null. Expected a name for the environment to retrieve its value."

    # When
    name  <- NULL 

    # Then
    name |> validate[["Name"]]() |> expect.error(expected.error)
  })
})

describe("When value |> validate[['Value']](name)",{
  it("then value is returned when value is not empty",{
    # Given
    validate <- Session.Utility.Validation()

    # When
    name  <- "name" 
    value <- "value"

    # Then
    value |> validate[["Value"]](name) |> expect.equal(value)
  })
  it("then no exception is thrown when value is not empty",{
    # Given
    validate <- Session.Utility.Validation()

    # When
    name  <- "name" 
    value <- "value"

    # Then
    value |> validate[["Value"]](name) |> expect.no.error()
  })
  it("then an exception is thrown when value is empty",{
    # Given
    validate <- Session.Utility.Validation()

    # When
    name  <- "name" 
    value <- ""

    expected.error <- paste0("No value found for provided environment variable:", name, ". Please check .Renviron configuration file.")

    # Then
    value |> validate[["Value"]](name) |> expect.error(expected.error)
  })
  it("then an exception is thrown when value is Null",{
    # Given
    validate <- Session.Utility.Validation()

    # When
    value <- NULL

    expected.error <- "Value is null. Expected a value for the environment to cache."

    # Then
    value |> validate[["Value"]]() |> expect.error(expected.error)
  })
})

describe("When ide |> validate[['IDE']]()",{
  it("then an exception should be thrown if no IDE in use.",{
    # Given
    validate <- Session.Utility.Validation()

    expected.error <- "No IDE in use but required."

    # When
    ide <- "None"

    # Then
    ide |> validate[["IDE"]]() |> expect.error(expected.error)
  })
})