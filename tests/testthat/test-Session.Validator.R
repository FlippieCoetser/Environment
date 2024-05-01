describe('Session.Validator', {
  it('Exist',{
    Session.Validator |> expect.exist()
  })
})

describe("When validations <- Session.Validator()",{
  it("then validators is a list.", {
    # When
    validations <- Session.Validator()

    # Then
    validations |> expect.list()
  })
  it("then validations contains 'navigation.response' validator.", {
    # When
    validations <- Session.Validator()

    # Then
    validations[['navigation.response']] |> expect.exist()
  })
  it("then validations contains 'filepath' validator.", {
    # When
    validations <- Session.Validator()

    # Then
    validations[['filepath']] |> expect.exist()
  })
  it("then validations contains 'is.empty' validator.", {
    # When
    validations <- Session.Validator()

    # Then
    validations[['is.empty']] |> expect.exist()
  })
  it("then validations contains 'is.NULL' validator.", {
    # When
    validations <- Session.Validator()

    # Then
    validations[['is.NULL']] |> expect.exist()
  })
  it("then validations contains 'Name' validator.",{
    # When
    validations <- Session.Validator()

    # Then
    validations[['Name']] |> expect.exist()
  })
  it("then validations contains 'Value' validator.",{
    # When
    validations <- Session.Validator()

    # Then
    validations[['Value']] |> expect.exist()
  })
  it("then validations contains 'IDE' Validator.",{
    # When
    validations <- Session.Validator()

    # Then
    validations[['IDE']] |> expect.exist()
  })
  it("then validations contains 'api.availability' Validator.",{
    # When
    validations <- Session.Validator()

    # Then
    validations[['api.availability']] |> expect.exist()
  })
  it("then validations contains 'api.capability' Validator.",{
    # When
    validations <- Session.Validator()

    # Then
    validations[['api.capability']] |> expect.exist()
  })
})

describe("When response |> validate[['navigation.response']]()",{
  it("then a path.not.found exception is thrown if response throws a warning containing path not found",{
    # Given
    validate <- Session.Validator()

    throw.warning <- \() {
      warning('path[1]="C:/Users/path.invalid/Documents/.Renviron": The system cannot find the path specified.')
    }

    expected.error <- "Path not found: C:/Users/path.invalid/Documents/.Renviron."
    
    # Then
    throw.warning() |> validate[['navigation.response']]() |> expect.error(expected.error)
  })
  it("then a file.not.found exception is thrown if response throws a warning containing file not found",{
    # Given
    validate <- Session.Validator()

    throw.warning <- \() {
      warning('path[1]="C:/Users/Analyst/Documents/check.txt": The system cannot find the file specified.')
    }

    expected.error <- "File not found: C:/Users/Analyst/Documents/check.txt."
    
    # Then
    throw.warning() |> validate[['navigation.response']]() |> expect.error(expected.error)
  })
})

describe("When filepath |> validate[['filepath']]()",{
  it("then filepath is returned if filepath is valid.",{
    # Given
    validate <- Session.Validator()

    input.filepath <- "C:/Users/username/Documents/.Renviron"

    expect.filepath <- input.filepath

    # When
    actual.filepath <-  input.filepath |> validate[['filepath']]()
    
    # Then
    actual.filepath |> expect.equal(expect.filepath)
  })
  it("then an exception is thrown if filepath is invalid.",{
    # Given
    validate <- Session.Validator()

    filepath <- "C:\\Users\\username\\Documents\\.Renviron"

    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\.Renviron", ".")

    # Then
    filepath |> validate[['filepath']]() |> expect.error(expected.error)
  })
})

describe("When value |> validate[['is.empty']]()",{
  it("then True is return if value is empty.",{
    # Given
    validate <- Session.Validator()

    # When
    value <- ""

    # Then
    value |> validate[['is.empty']]() |> expect.true()
  })
  it("then False is return if value is not empty.",{
    # Given
    validate <- Session.Validator()

    # When
    value <- "value"

    # Then
    value |> validate[['is.empty']]() |> expect.false()
  })
})

describe("When value |> validate[['is.NULL']]()",{
  it("then True is return if value is NULL.",{
    # Given
    validate <- Session.Validator()

    # When
    value <- NULL

    # Then
    value |> validate[['is.NULL']]() |> expect.true()
  })
  it("then False is return if value is not NULL.",{
    # Given
    validate <- Session.Validator()

    # When
    value <- "value"

    # Then
    value |> validate[['is.NULL']]() |> expect.false()
  })
})

describe("When name |> validate[['Name']]()",{
  it("then name is returned when name is not null",{
    # Given
    validate <- Session.Validator()

    # When
    name  <- "name" 

    # Then
    name |> validate[['Name']]() |> expect.equal(name)
  })
  it("then no exception is thrown when name is not null",{
    # Given
    validate <- Session.Validator()

    # When
    name  <- "name" 

    # Then
    name |> validate[['Name']]() |> expect.no.error()
  })
  it("then an exception is thrown when name is null",{
    # Given
    validate <- Session.Validator()

    expected.error <- "Environment variable name is null, but required."

    # When
    name  <- NULL 

    # Then
    name |> validate[['Name']]() |> expect.error(expected.error)
  })
})

describe("When value |> validate[['Value']](name)",{
  it("then value is returned when value is not empty",{
    # Given
    validate <- Session.Validator()

    # When
    name  <- "name" 
    value <- "value"

    # Then
    value |> validate[['Value']](name) |> expect.equal(value)
  })
  it("then no exception is thrown when value is not empty",{
    # Given
    validate <- Session.Validator()

    # When
    name  <- "name" 
    value <- "value"

    # Then
    value |> validate[['Value']](name) |> expect.no.error()
  })
  it("then an exception is thrown when value is empty",{
    # Given
    validate <- Session.Validator()

    # When
    name  <- "name" 
    value <- ""

    expected.error <- paste0("No value found for provided environment variable:", name, ". Please check .Renviron configuration file.")

    # Then
    value |> validate[['Value']](name) |> expect.error(expected.error)
  })
  it("then an exception is thrown when value is Null",{
    # Given
    validate <- Session.Validator()

    # When
    value <- NULL

    expected.error <- "Value is null. Expected a value for the environment to cache."

    # Then
    value |> validate[['Value']]() |> expect.error(expected.error)
  })
})

describe("When ide |> validate[['IDE']]()",{
  it("then an exception is thrown if no IDE in use.",{
    # Given
    validate <- Session.Validator()

    expected.error <- "No IDE in use but required."

    # When
    ide <- "None"

    # Then
    ide |> validate[['IDE']]() |> expect.error(expected.error)
  })
})

describe("When availability |> validate[['api.availability']](ide)",{
  it("then no exception is thrown if RStudio API is available",{
    # Given
    validate <- Session.Validator()

    # When
    availability <- TRUE

    # Then
    availability |> validate[['api.availability']]() |> expect.no.error()
  })
  it("then an exception is thrown if RStudio API is unavailable in RStudio.",{
    # Given
    validate <- Session.Validator()

    expected.error <- "RStudio API is unavailable in RStudio."

    # When
    availability <- FALSE
    ide <- "RStudio"

    # Then
    availability |> validate[['api.availability']](ide) |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudio API is unavailable in VSCode.",{
    # Given
    validate <- Session.Validator()

    expected.error <- "RStudio API is unavailable in VSCode."

    # When
    availability <- FALSE
    ide <- "VSCode"

    # Then
    availability |> validate[['api.availability']](ide) |> expect.error(expected.error)
  })
})

describe("When capable |> validate[['api.capability']](ide)",{
  it("then no exception is thrown if Navigate To File function is available.",{
    # Given
    validate <- Session.Validator()

    # When
    capable <- TRUE

    # Then
    capable |> validate[['api.capability']](ide) |> expect.no.error()
  })
  it("then an exception is thrown if Navigate To File function is not available in RStudio.",{
    # Given
    validate <- Session.Validator()

    expected.error <- "Navigate to File function is unavailable in RStudio."

    # When
    capable <- FALSE
    ide <- "RStudio"

    # Then
    capable |> validate[['api.capability']](ide) |> expect.error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is not available in VSCode.",{
    # Given
    validate <- Session.Validator()

    expected.error <- "Navigate to File function is unavailable in VSCode."

    # When
    capable <- FALSE
    ide <- "VSCode"

    # Then
    capable |> validate[['api.capability']](ide) |> expect.error(expected.error)
  })
})