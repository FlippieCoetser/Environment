describe('Session.Exceptions', {
  it('Exist',{
    # Then
    Session.Exceptions |> expect.exist()
  })
})

describe("When exceptions <- Session.Exceptions()",{
  it("then exceptions is a list.", {
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions |> expect.list()
  })
  it("then exceptions contains NavigateToFileExceptions exception.", {
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["NavigateToFileExceptions"]] |> expect.exist()
  })
  it("then exceptions contains PathNotFound exception.", {
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["PathNotFound"]] |> expect.exist()
  })
  it("then exceptions contains FileNotFound exception.", {
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["FileNotFound"]] |> expect.exist()
  })
  it("then exceptions contains InvalidFilepath exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["InvalidFilepath"]] |> expect.exist()
  })
  it("then exceptions contains NameIsNull exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["NameIsNull"]] |> expect.exist()
  })
  it("then exceptions contains ValueIsEmpty exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["ValueIsEmpty"]] |> expect.exist()
  })
  it("then exceptions contains ValueIsNull exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["ValueIsNull"]] |> expect.exist()
  })
  it("then exceptions contains NoIDEInUse exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["NoIDEInUse"]] |> expect.exist()
  })
  it("then exceptions contains RStudioAPIUnavailable exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["RStudioAPIUnavailable"]] |> expect.exist()
  })
  it("then exceptions contains NavigateToFileUnavailable exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["NavigateToFileUnavailable"]] |> expect.exist()
  })
})

describe("When input |> exception[['PathNotFound']](path)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Session.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["PathNotFound"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Session.Exceptions()

    random.path    <- "random.path"
    expected.error <- paste0("Path not found: ", random.path, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["PathNotFound"]](random.path) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['FileNotFound']](file)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Session.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["FileNotFound"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Session.Exceptions()

    random.file    <- "random.file"
    expected.error <- paste0("File not found: ", random.file, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["FileNotFound"]](random.file) |> expect.error(expected.error)
  })
})

describe("When error |> exception[['NavigateToFileExceptions']]()",{
  it("then an PathNotFound exception is thrown if error message contain cannot find the path.",{
    # Given
    exception <- Session.Exceptions()

    excepted.error <- "Path not found: C:/Users/InvalidPath/Documents/.Renviron."

    # When
    warning <- list()
    warning[['message']] <- 'path[1]="C:/Users/InvalidPath/Documents/.Renviron": The system cannot find the path specified.'

    # Then
    warning |> exception[["NavigateToFileExceptions"]]() |> expect.error(excepted.error)
  })
  it("then an FileNotFound exception is thrown if error message contain cannot find the file.",{
    # Given
    exception <- Session.Exceptions()

    excepted.error <- "File not found: C:/Users/Analyst/Documents/check.txt."

    # When
    warning <- list()
    warning[['message']] <- 'path[1]="C:/Users/Analyst/Documents/check.txt": The system cannot find the file specified.'

    # Then
    warning |> exception[["NavigateToFileExceptions"]]() |> expect.error(excepted.error)
  })
})

describe("When input |> exception[['InvalidFilepath']]()",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Session.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["InvalidFilepath"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Session.Exceptions()

    random.filepath <- "filepath"
    expected.error  <- paste0("Invalid filepath: ", random.filepath, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["InvalidFilepath"]](random.filepath) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['NameIsNull']]()",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["NameIsNull"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Exceptions()

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
    exception <- Session.Exceptions()

    variable.name  <- "name"

    # When
    input <- FALSE

    # Then
    input |> exception[["ValueIsEmpty"]](variable.name) |> expect.no.error()
  })
  it("Then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Exceptions()

    variable.name  <- "name"
    expected.error <- paste0("No value found for provided environment variable:", variable.name, ". Please check .Renviron configuration file.")

    # When
    input <- TRUE

    # Then
    input |> exception[["ValueIsEmpty"]](variable.name) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['ValueIsNull']]()",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["ValueIsNull"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Exceptions()

    expected.error <- "Value is null. Expected a value for the environment to cache."

    # When
    input <- TRUE

    # Then
    input |> exception[["ValueIsNull"]]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['NoIDEInUse']]()",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["NoIDEInUse"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Exceptions()

    expected.error <- "No IDE in use but required."

    # When
    input <- TRUE

    # Then
    input |> exception[["NoIDEInUse"]]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['RStudioAPIUnavailable']](ide)",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["RStudioAPIUnavailable"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Exceptions()
    
    ide <- "ide.name"
    expected.error <- paste0("RStudio API is unavailable in ",ide,".")

    # When
    input <- TRUE

    # Then
    input |> exception[["RStudioAPIUnavailable"]](ide) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['NavigateToFileUnavailable']](ide)",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["NavigateToFileUnavailable"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Exceptions()
    
    ide <- "ide.name"
    expected.error <- paste0("Navigate to File function is unavailable in ",ide,".")

    # When
    input <- TRUE

    # Then
    input |> exception[["NavigateToFileUnavailable"]](ide) |> expect.error(expected.error)
  })
})