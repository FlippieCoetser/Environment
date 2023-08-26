describe('Session.Utility.Exceptions', {
  it('Exist',{
    # Then
    Session.Utility.Exceptions |> expect.exist()
  })
})

describe("When exceptions <- Session.Utility.Exceptions()",{
  it("then exceptions should be a list.", {
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions |> expect.list()
  })
  it("then exceptions should contain NavigateToFileExceptions.", {
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["NavigateToFileExceptions"]] |> expect.exist()
  })
  it("then exceptions should contain PathNotFound Exception.", {
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["PathNotFound"]] |> expect.exist()
  })
  it("then exceptions should contain FileNotFound Exception.", {
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["FileNotFound"]] |> expect.exist()
  })
  it("then exceptions should contain InvalidFilepath Exception",{
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["InvalidFilepath"]] |> expect.exist()
  })
  it("then exceptions should contain NameIsNull Exception",{
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["NameIsNull"]] |> expect.exist()
  })
  it("then exceptions should contain ValueIsEmpty Exception",{
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["ValueIsEmpty"]] |> expect.exist()
  })
  it("then exceptions should contain ValueIsNull Exception",{
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["ValueIsNull"]] |> expect.exist()
  })
  it("then exceptions should contain NoIDEInUse Exception",{
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["NoIDEInUse"]] |> expect.exist()
  })
  it("then exceptions should contain RStudioAPIUnavailable Exception",{
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["RStudioAPIUnavailable"]] |> expect.exist()
  })
  it("then exceptions should contain NavigateToFileUnavailable Exception",{
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["NavigateToFileUnavailable"]] |> expect.exist()
  })
})

describe("When input |> exception[['PathNotFound']](path)",{
  it("then no exception should be thrown if input is FALSE.",{
    # Given
    exception <- Session.Utility.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["PathNotFound"]]() |> expect.no.error()
  })
  it("then an exception should be thrown if input is TRUE.",{
    # Given
    exception <- Session.Utility.Exceptions()

    random.path    <- "random.path"
    expected.error <- paste0("Path not found: ", random.path, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["PathNotFound"]](random.path) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['FileNotFound']](file)",{
  it("then no exception should be thrown if input is FALSE.",{
    # Given
    exception <- Session.Utility.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["FileNotFound"]]() |> expect.no.error()
  })
  it("then an exception should be thrown if input is TRUE.",{
    # Given
    exception <- Session.Utility.Exceptions()

    random.file    <- "random.file"
    expected.error <- paste0("File not found: ", random.file, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["FileNotFound"]](random.file) |> expect.error(expected.error)
  })
})

describe("When error |> exception[['NavigateToFileExceptions']]()",{
  it("then an PathNotFound exception should be thrown in error message contain cannot find the path.",{
    # Given
    exception <- Session.Utility.Exceptions()

    excepted.error <- "Path not found: C:/Users/InvalidPath/Documents/.Renviron."

    # When
    warning <- list()
    warning[['message']] <- 'path[1]="C:/Users/InvalidPath/Documents/.Renviron": The system cannot find the path specified.'

    # Then
    warning |> exception[["NavigateToFileExceptions"]]() |> expect.error(excepted.error)
  })
  it("then an FileNotFound exception should be thrown if error message contain cannot find the file.",{
    # Given
    exception <- Session.Utility.Exceptions()

    excepted.error <- "File not found: C:/Users/Analyst/Documents/check.txt."

    # When
    warning <- list()
    warning[['message']] <- 'path[1]="C:/Users/Analyst/Documents/check.txt": The system cannot find the file specified.'

    # Then
    warning |> exception[["NavigateToFileExceptions"]]() |> expect.error(excepted.error)
  })
})

describe("When input |> exception[['InvalidFilepath']]()",{
  it("then no exception should be thrown if input is FALSE.",{
    # Given
    exception <- Session.Utility.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["InvalidFilepath"]]() |> expect.no.error()
  })
  it("then an exception should be thrown if input is TRUE.",{
    # Given
    exception <- Session.Utility.Exceptions()

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
    exception <- Session.Utility.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["NameIsNull"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Utility.Exceptions()

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
    exception <- Session.Utility.Exceptions()

    variable.name  <- "name"

    # When
    input <- FALSE

    # Then
    input |> exception[["ValueIsEmpty"]](variable.name) |> expect.no.error()
  })
  it("Then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Utility.Exceptions()

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
    exception <- Session.Utility.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["ValueIsNull"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Utility.Exceptions()

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
    exception <- Session.Utility.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["NoIDEInUse"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Utility.Exceptions()

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
    exception <- Session.Utility.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["RStudioAPIUnavailable"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Utility.Exceptions()
    
    ide <- "ide.name"
    expected.error <- paste0("RStudio API is unavailable for IDE: ",ide,".")

    # When
    input <- TRUE

    # Then
    input |> exception[["RStudioAPIUnavailable"]](ide) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['NavigateToFileUnavailable']](ide)",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Utility.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["NavigateToFileUnavailable"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Utility.Exceptions()
    
    ide <- "ide.name"
    expected.error <- paste0("Navigate to File function is unavailable in IDE: ",ide,".")

    # When
    input <- TRUE

    # Then
    input |> exception[["NavigateToFileUnavailable"]](ide) |> expect.error(expected.error)
  })
})