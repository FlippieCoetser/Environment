describe('Path.Exceptions', {
  it('Exist',{
    Path.Exceptions |> expect.exist()
  })
})

describe("When exceptions <- Path.Exceptions()",{
  it("then exceptions is a list.",{
    # When
    exceptions <- Path.Exceptions()

    # Then
    exceptions |> expect.list()
  })
  it("then exceptions contains 'Path.Invalid' exception.",{
    # When
    exceptions <- Path.Exceptions()

    # Then
    exceptions[['Path.Invalid']] |> expect.exist()
  })
  it("then exceptions contains 'Filename.Invalid' exception.",{
    # When
    exceptions <- Path.Exceptions()

    # Then
    exceptions[['Filename.Invalid']] |> expect.exist()
  })
  it("then exceptions contains 'Normalized.Invalid' exception.",{
    # When
    exceptions <- Path.Exceptions()

    # Then
    exceptions[['Normalized.Invalid']] |> expect.exist()
  })
  it("then exceptions contains 'Filepath.Invalid' exception.",{
    # When
    exceptions <- Path.Exceptions()

    # Then
    exceptions[['Filepath.Invalid']] |> expect.exist()
  })
})

describe("When input |> exception[['Path.Invalid']](path)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Path.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[['Path.Invalid']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Path.Exceptions()

    random.path    <- "random.path"
    expected.error <- paste0("Invalid path: ", random.path, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[['Path.Invalid']](random.path) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Filename.Invalid']](filename)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Path.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[['Filename.Invalid']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Path.Exceptions()

    random.filename <- "filename."
    expected.error  <- paste0("Invalid filename: ", random.filename, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[['Filename.Invalid']](random.filename) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Normalized.Invalid']](path)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Path.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[['Normalized.Invalid']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Path.Exceptions()

    random.path    <- "random.path"
    expected.error <- paste0("Invalid normalized path: ", random.path, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[['Normalized.Invalid']](random.path) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Filepath.Invalid']]()",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Path.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[['Filepath.Invalid']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Path.Exceptions()

    random.filepath <- "filepath"
    expected.error  <- paste0("Invalid filepath: ", random.filepath, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[['Filepath.Invalid']](random.filepath) |> expect.error(expected.error)
  })
})