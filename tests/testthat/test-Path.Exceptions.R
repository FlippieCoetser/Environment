describe('Path.Exceptions', {
  it('Exist',{
    # Then
    Path.Exceptions |> expect.exist()
  })
})

describe("When exceptions <- Path.Exceptions()",{
  it("then exceptions is a list.",{
    # Given
    exceptions <- Path.Exceptions()

    # Then
    exceptions |> expect.list()
  })
  it("then exceptions contains InvalidPath exception.",{
    # Given
    exceptions <- Path.Exceptions()

    # Then
    exceptions[["InvalidPath"]] |> expect.exist()
  })
  it("then exceptions contains InvalidFilename exception.",{
    # Given
    exceptions <- Path.Exceptions()

    # Then
    exceptions[["InvalidFilename"]] |> expect.exist()
  })
  it("then exceptions contains InvalidNormalized exception.",{
    # Given
    exceptions <- Path.Exceptions()

    # Then
    exceptions[["InvalidNormalized"]] |> expect.exist()
  })
  it("then exceptions contains InvalidFilepath exception.",{
    # Given
    exceptions <- Path.Exceptions()

    # Then
    exceptions[["InvalidFilepath"]] |> expect.exist()
  })
})

describe("When input |> exception[['InvalidPath']](path)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Path.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["InvalidPath"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Path.Exceptions()

    random.path    <- "random.path"
    expected.error <- paste0("Invalid path: ", random.path, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["InvalidPath"]](random.path) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['InvalidFilename']](filename)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Path.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["InvalidFilename"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Path.Exceptions()

    random.filename <- "filename."
    expected.error  <- paste0("Invalid filename: ", random.filename, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["InvalidFilename"]](random.filename) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['InvalidNormalized']](path)",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Path.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["InvalidNormalized"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Path.Exceptions()

    random.path    <- "random.path"
    expected.error <- paste0("Invalid normalized path: ", random.path, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["InvalidNormalized"]](random.path) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['InvalidFilepath']]()",{
  it("then no exception is thrown if input is FALSE.",{
    # Given
    exception <- Path.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["InvalidFilepath"]]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE.",{
    # Given
    exception <- Path.Exceptions()

    random.filepath <- "filepath"
    expected.error  <- paste0("Invalid filepath: ", random.filepath, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["InvalidFilepath"]](random.filepath) |> expect.error(expected.error)
  })
})