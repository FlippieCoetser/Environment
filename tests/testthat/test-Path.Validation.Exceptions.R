describe('Path.Validation.Exceptions', {
  it('Exist',{
    Path.Validation.Exceptions |> expect.exist()
  })
})

describe("When exceptions <- Path.Validation.Exceptions()",{
  it("then exceptions is a list.",{
    # When
    exceptions <- Path.Validation.Exceptions()

    # Then
    exceptions |> expect.list()
  })
  it("then exceptions contains 'path.invalid' exception.",{
    # When
    exceptions <- Path.Validation.Exceptions()

    # Then
    exceptions[['path.invalid']] |> expect.exist()
  })
  it("then exceptions contains 'filename.invalid' exception.",{
    # When
    exceptions <- Path.Validation.Exceptions()

    # Then
    exceptions[['filename.invalid']] |> expect.exist()
  })
  it("then exceptions contains 'normalized.invalid' exception.",{
    # When
    exceptions <- Path.Validation.Exceptions()

    # Then
    exceptions[['normalized.invalid']] |> expect.exist()
  })
  it("then exceptions contains 'filepath.invalid' exception.",{
    # When
    exceptions <- Path.Validation.Exceptions()

    # Then
    exceptions[['filepath.invalid']] |> expect.exist()
  })
})

describe("When input |> exception[['path.invalid']](path)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Path.Validation.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[['path.invalid']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Path.Validation.Exceptions()

    random.path    <- "random.path"
    expected.error <- paste0("Invalid path: ", random.path, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[['path.invalid']](random.path) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['filename.invalid']](filename)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Path.Validation.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[['filename.invalid']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Path.Validation.Exceptions()

    random.filename <- "filename."
    expected.error  <- paste0("Invalid filename: ", random.filename, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[['filename.invalid']](random.filename) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['normalized.invalid']](path)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Path.Validation.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[['normalized.invalid']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Path.Validation.Exceptions()

    random.path    <- "random.path"
    expected.error <- paste0("Invalid normalized path: ", random.path, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[['normalized.invalid']](random.path) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['filepath.invalid']]()",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Path.Validation.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[['filepath.invalid']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Path.Validation.Exceptions()

    random.filepath <- "filepath"
    expected.error  <- paste0("Invalid filepath: ", random.filepath, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[['filepath.invalid']](random.filepath) |> expect.error(expected.error)
  })
})