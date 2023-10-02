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
  it("then exceptions contains Filepath.Not.Found exception.", {
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["Filepath.Not.Found"]] |> expect.exist()
  })
  it("then exceptions contains Path.Not.Found exception.", {
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["Path.Not.Found"]] |> expect.exist()
  })
  it("then exceptions contains File.Not.Found exception.", {
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["File.Not.Found"]] |> expect.exist()
  })
  it("then exceptions contains Filepath.Invalid exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["Filepath.Invalid"]] |> expect.exist()
  })
  it("then exceptions contains Name.Null exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["Name.Null"]] |> expect.exist()
  })
  it("then exceptions contains Value.Empty exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["Value.Empty"]] |> expect.exist()
  })
  it("then exceptions contains Value.Null exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["Value.Null"]] |> expect.exist()
  })
  it("then exceptions contains NoIDE.InUse exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["NoIDE.InUse"]] |> expect.exist()
  })
  it("then exceptions contains RStudio.API.Unavailable exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["RStudio.API.Unavailable"]] |> expect.exist()
  })
  it("then exceptions contains Filepath.Unavailable exception.",{
    # Given
    exceptions <- Session.Exceptions()

    # Then
    exceptions[["Filepath.Unavailable"]] |> expect.exist()
  })
})

describe("When input |> exception[['Path.Not.Found']](path)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Session.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["Path.Not.Found"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Session.Exceptions()

    random.path    <- "random.path"
    expected.error <- paste0("Path not found: ", random.path, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["Path.Not.Found"]](random.path) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['File.Not.Found']](file)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Session.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["File.Not.Found"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Session.Exceptions()

    random.file    <- "random.file"
    expected.error <- paste0("File not found: ", random.file, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["File.Not.Found"]](random.file) |> expect.error(expected.error)
  })
})

describe("When error |> exception[['Filepath.Not.Found']]()",{
  it("then an Path.Not.Found exception is thrown if error message contain cannot find the path.",{
    # Given
    exception <- Session.Exceptions()

    excepted.error <- "Path not found: C:/Users/Path.Invalid/Documents/.Renviron."

    # When
    warning <- list()
    warning[['message']] <- 'path[1]="C:/Users/Path.Invalid/Documents/.Renviron": The system cannot find the path specified.'

    # Then
    warning |> exception[["Filepath.Not.Found"]]() |> expect.error(excepted.error)
  })
  it("then an File.Not.Found exception is thrown if error message contain cannot find the file.",{
    # Given
    exception <- Session.Exceptions()

    excepted.error <- "File not found: C:/Users/Analyst/Documents/check.txt."

    # When
    warning <- list()
    warning[['message']] <- 'path[1]="C:/Users/Analyst/Documents/check.txt": The system cannot find the file specified.'

    # Then
    warning |> exception[["Filepath.Not.Found"]]() |> expect.error(excepted.error)
  })
})

describe("When input |> exception[['Filepath.Invalid']]()",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Session.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["Filepath.Invalid"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Session.Exceptions()

    random.filepath <- "filepath"
    expected.error  <- paste0("Invalid filepath: ", random.filepath, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["Filepath.Invalid"]](random.filepath) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Name.Null']]()",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["Name.Null"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Exceptions()

    expected.error <- "Environment variable name is null, but required."

    # When
    input <- TRUE

    # Then
    input |> exception[["Name.Null"]]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Value.Empty']](name)",{
  it("Then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Exceptions()

    variable.name  <- "name"

    # When
    input <- FALSE

    # Then
    input |> exception[["Value.Empty"]](variable.name) |> expect.no.error()
  })
  it("Then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Exceptions()

    variable.name  <- "name"
    expected.error <- paste0("No value found for provided environment variable:", variable.name, ". Please check .Renviron configuration file.")

    # When
    input <- TRUE

    # Then
    input |> exception[["Value.Empty"]](variable.name) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Value.Null']]()",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["Value.Null"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Exceptions()

    expected.error <- "Value is null. Expected a value for the environment to cache."

    # When
    input <- TRUE

    # Then
    input |> exception[["Value.Null"]]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['NoIDE.InUse']]()",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["NoIDE.InUse"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Exceptions()

    expected.error <- "No IDE in use but required."

    # When
    input <- TRUE

    # Then
    input |> exception[["NoIDE.InUse"]]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['RStudio.API.Unavailable']](ide)",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["RStudio.API.Unavailable"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Exceptions()
    
    ide <- "ide.name"
    expected.error <- paste0("RStudio API is unavailable in ",ide,".")

    # When
    input <- TRUE

    # Then
    input |> exception[["RStudio.API.Unavailable"]](ide) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Filepath.Unavailable']](ide)",{
  it("then no exception is thrown if input is FALSE",{
    # Given
    exception <- Session.Exceptions()

    # When
    input <- FALSE

    # Then
    input |> exception[["Filepath.Unavailable"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE",{
    # Given
    exception <- Session.Exceptions()
    
    ide <- "ide.name"
    expected.error <- paste0("Navigate to File function is unavailable in ",ide,".")

    # When
    input <- TRUE

    # Then
    input |> exception[["Filepath.Unavailable"]](ide) |> expect.error(expected.error)
  })
})