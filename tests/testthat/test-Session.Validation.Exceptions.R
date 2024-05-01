describe('Session.Validation.Exceptions', {
  it('Exist',{
    Session.Validation.Exceptions |> expect.exist()
  })
})

describe("When exceptions <- Session.Validation.Exceptions()",{
  it("then exceptions is a list.", {
    # When
    exceptions <- Session.Validation.Exceptions()

    # Then
    exceptions |> expect.list()
  })
  it("then exceptions contains 'filepath.not.found' exception.", {
    # When
    exceptions <- Session.Validation.Exceptions()

    # Then
    exceptions[['filepath.not.found']] |> expect.exist()
  })
  it("then exceptions contains 'path.not.found' exception.", {
    # When
    exceptions <- Session.Validation.Exceptions()

    # Then
    exceptions[['path.not.found']] |> expect.exist()
  })
  it("then exceptions contains 'file.not.found' exception.", {
    # When
    exceptions <- Session.Validation.Exceptions()

    # Then
    exceptions[['file.not.found']] |> expect.exist()
  })
  it("then exceptions contains 'filepath.invalid' exception.",{
    # When
    exceptions <- Session.Validation.Exceptions()

    # Then
    exceptions[['filepath.invalid']] |> expect.exist()
  })
  it("then exceptions contains 'name.null' exception.",{
    # When
    exceptions <- Session.Validation.Exceptions()

    # Then
    exceptions[['name.null']] |> expect.exist()
  })
  it("then exceptions contains 'value.empty' exception.",{
    # When
    exceptions <- Session.Validation.Exceptions()

    # Then
    exceptions[['value.empty']] |> expect.exist()
  })
  it("then exceptions contains 'value.null' exception.",{
    # When
    exceptions <- Session.Validation.Exceptions()

    # Then
    exceptions[['value.null']] |> expect.exist()
  })
  it("then exceptions contains 'IDE.not.active' exception.",{
    # When
    exceptions <- Session.Validation.Exceptions()

    # Then
    exceptions[['IDE.not.active']] |> expect.exist()
  })
  it("then exceptions contains 'RStudio.api.unavailable' exception.",{
    # When
    exceptions <- Session.Validation.Exceptions()

    # Then
    exceptions[['RStudio.api.unavailable']] |> expect.exist()
  })
  it("then exceptions contains 'filepath.unavailable' exception.",{
    # When
    exceptions <- Session.Validation.Exceptions()

    # Then
    exceptions[['filepath.unavailable']] |> expect.exist()
  })
})

describe("When input |> exception[['path.not.found']](path)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Session.Validation.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[['path.not.found']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Session.Validation.Exceptions()

    random.path    <- "random.path"
    
    expected.error <- paste0("Path not found: ", random.path, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[['path.not.found']](random.path) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['file.not.found']](file)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Session.Validation.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[['file.not.found']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Session.Validation.Exceptions()

    random.file    <- "random.file"

    expected.error <- paste0("File not found: ", random.file, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[['file.not.found']](random.file) |> expect.error(expected.error)
  })
})

describe("When error |> exception[['filepath.not.found']]()",{
  it("then an path.not.found exception is thrown if error message contain cannot find the path.",{
    # Given
    exception <- Session.Validation.Exceptions()

    excepted.error <- "Path not found: C:/Users/path.invalid/Documents/.Renviron."

    # When
    warning <- list()
    warning[['message']] <- 'path[1]="C:/Users/path.invalid/Documents/.Renviron": The system cannot find the path specified.'

    # Then
    warning |> exception[['filepath.not.found']]() |> expect.error(excepted.error)
  })
  it("then an file.not.found exception is thrown if error message contain cannot find the file.",{
    # Given
    exception <- Session.Validation.Exceptions()

    excepted.error <- "File not found: C:/Users/Analyst/Documents/check.txt."

    # When
    warning <- list()
    warning[['message']] <- 'path[1]="C:/Users/Analyst/Documents/check.txt": The system cannot find the file specified.'

    # Then
    warning |> exception[['filepath.not.found']]() |> expect.error(excepted.error)
  })
})

describe("When input |> exception[['filepath.invalid']]()",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Session.Validation.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[['filepath.invalid']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Session.Validation.Exceptions()

    random.filepath <- "filepath"

    expected.error  <- paste0("Invalid filepath: ", random.filepath, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[['filepath.invalid']](random.filepath) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['name.null']]()",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Validation.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[['name.null']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Validation.Exceptions()

    expected.error <- "Environment variable name is null, but required."

    # When
    input <- TRUE

    # Then
    input |> exception[['name.null']]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['value.empty']](name)",{
  it("Then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Validation.Exceptions()

    variable.name  <- "name"

    # When
    input <- FALSE

    # Then
    input |> exception[['value.empty']](variable.name) |> expect.no.error()
  })
  it("Then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Validation.Exceptions()

    variable.name  <- "name"

    expected.error <- paste0("No value found for provided environment variable:", variable.name, ". Please check .Renviron configuration file.")

    # When
    input <- TRUE

    # Then
    input |> exception[['value.empty']](variable.name) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['value.null']]()",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Validation.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[['value.null']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Validation.Exceptions()

    expected.error <- "Value is null. Expected a value for the environment to cache."

    # When
    input <- TRUE

    # Then
    input |> exception[['value.null']]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['IDE.not.active']]()",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Validation.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[['IDE.not.active']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Validation.Exceptions()

    expected.error <- "No IDE in use but required."

    # When
    input <- TRUE

    # Then
    input |> exception[['IDE.not.active']]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['RStudio.api.unavailable']](ide)",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Validation.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[['RStudio.api.unavailable']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Validation.Exceptions()
    
    ide <- "ide.name"

    expected.error <- paste0("RStudio API is unavailable in ",ide,".")

    # When
    input <- TRUE

    # Then
    input |> exception[['RStudio.api.unavailable']](ide) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['filepath.unavailable']](ide)",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Validation.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[['filepath.unavailable']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Validation.Exceptions()
    
    ide <- "ide.name"

    expected.error <- paste0("Navigate to File function is unavailable in ",ide,".")

    # When
    input <- TRUE

    # Then
    input |> exception[['filepath.unavailable']](ide) |> expect.error(expected.error)
  })
})