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
  it("then validations contains 'Navigation.Response' validator.", {
    # When
    validations <- Session.Validator()

    # Then
    validations[['Navigation.Response']] |> expect.exist()
  })
  it("then validations contains 'Filepath' validator.", {
    # When
    validations <- Session.Validator()

    # Then
    validations[['Filepath']] |> expect.exist()
  })
  it("then validations contains 'IsEmpty' validator.", {
    # When
    validations <- Session.Validator()

    # Then
    validations[['IsEmpty']] |> expect.exist()
  })
  it("then validations contains 'IsNull' validator.", {
    # When
    validations <- Session.Validator()

    # Then
    validations[['IsNull']] |> expect.exist()
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
  it("then validations contains 'API.Availability' Validator.",{
    # When
    validations <- Session.Validator()

    # Then
    validations[['API.Availability']] |> expect.exist()
  })
  it("then validations contains 'API.Capability' Validator.",{
    # When
    validations <- Session.Validator()

    # Then
    validations[['API.Capability']] |> expect.exist()
  })
})

describe("When response |> validate[['Navigation.Response']]()",{
  it("then a Path.Not.Found exception is thrown if response throws a warning containing path not found",{
    # Given
    validate <- Session.Validator()

    throw.warning <- \() {
      warning('path[1]="C:/Users/Path.Invalid/Documents/.Renviron": The system cannot find the path specified.')
    }

    expected.error <- "Path not found: C:/Users/Path.Invalid/Documents/.Renviron."
    
    # Then
    throw.warning() |> validate[['Navigation.Response']]() |> expect.error(expected.error)
  })
  it("then a File.Not.Found exception is thrown if response throws a warning containing file not found",{
    # Given
    validate <- Session.Validator()

    throw.warning <- \() {
      warning('path[1]="C:/Users/Analyst/Documents/check.txt": The system cannot find the file specified.')
    }

    expected.error <- "File not found: C:/Users/Analyst/Documents/check.txt."
    
    # Then
    throw.warning() |> validate[['Navigation.Response']]() |> expect.error(expected.error)
  })
})

describe("When filepath |> validate[['Filepath']]()",{
  it("then filepath is returned if filepath is valid.",{
    # Given
    validate <- Session.Validator()

    input.filepath <- "C:/Users/username/Documents/.Renviron"

    expect.filepath <- input.filepath

    # When
    actual.filepath <-  input.filepath |> validate[['Filepath']]()
    
    # Then
    actual.filepath |> expect.equal(expect.filepath)
  })
  it("then an exception is thrown if filepath is invalid.",{
    # Given
    validate <- Session.Validator()

    filepath <- "C:\\Users\\username\\Documents\\.Renviron"

    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\.Renviron", ".")

    # Then
    filepath |> validate[['Filepath']]() |> expect.error(expected.error)
  })
})

describe("When value |> validate[['IsEmpty']]()",{
  it("then True is return if value is empty.",{
    # Given
    validate <- Session.Validator()

    # When
    value <- ""

    # Then
    value |> validate[['IsEmpty']]() |> expect.true()
  })
  it("then False is return if value is not empty.",{
    # Given
    validate <- Session.Validator()

    # When
    value <- "value"

    # Then
    value |> validate[['IsEmpty']]() |> expect.false()
  })
})

describe("When value |> validate[['IsNull']]()",{
  it("then True is return if value is NULL.",{
    # Given
    validate <- Session.Validator()

    # When
    value <- NULL

    # Then
    value |> validate[['IsNull']]() |> expect.true()
  })
  it("then False is return if value is not NULL.",{
    # Given
    validate <- Session.Validator()

    # When
    value <- "value"

    # Then
    value |> validate[['IsNull']]() |> expect.false()
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

describe("When availability |> validate[['API.Availability']](ide)",{
  it("then no exception is thrown if RStudio API is available",{
    # Given
    validate <- Session.Validator()

    # When
    availability <- TRUE

    # Then
    availability |> validate[['API.Availability']]() |> expect.no.error()
  })
  it("then an exception is thrown if RStudio API is unavailable in RStudio.",{
    # Given
    validate <- Session.Validator()

    expected.error <- "RStudio API is unavailable in RStudio."

    # When
    availability <- FALSE
    ide <- "RStudio"

    # Then
    availability |> validate[['API.Availability']](ide) |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudio API is unavailable in VSCode.",{
    # Given
    validate <- Session.Validator()

    expected.error <- "RStudio API is unavailable in VSCode."

    # When
    availability <- FALSE
    ide <- "VSCode"

    # Then
    availability |> validate[['API.Availability']](ide) |> expect.error(expected.error)
  })
})

describe("When capable |> validate[['API.Capability']](ide)",{
  it("then no exception is thrown if Navigate To File function is available.",{
    # Given
    validate <- Session.Validator()

    # When
    capable <- TRUE

    # Then
    capable |> validate[['API.Capability']](ide) |> expect.no.error()
  })
  it("then an exception is thrown if Navigate To File function is not available in RStudio.",{
    # Given
    validate <- Session.Validator()

    expected.error <- "Navigate to File function is unavailable in RStudio."

    # When
    capable <- FALSE
    ide <- "RStudio"

    # Then
    capable |> validate[['API.Capability']](ide) |> expect.error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is not available in VSCode.",{
    # Given
    validate <- Session.Validator()

    expected.error <- "Navigate to File function is unavailable in VSCode."

    # When
    capable <- FALSE
    ide <- "VSCode"

    # Then
    capable |> validate[['API.Capability']](ide) |> expect.error(expected.error)
  })
})