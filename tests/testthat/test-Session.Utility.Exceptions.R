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
})