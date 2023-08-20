describe('Path.Utility.Exceptions', {
  it('Exist',{
    # Then
    Path.Utility.Exceptions |> expect.exist()
  })
})

describe("When exceptions <- Path.Utility.Exceptions()",{
  it("then exceptions should be a list.",{
    # Given
    exceptions <- Path.Utility.Exceptions()

    # Then
    exceptions |> expect.list()
  })
  it("then exceptions should contains InvalidPath exception.",{
    # Given
    exceptions <- Path.Utility.Exceptions()

    # Then
    exceptions[["InvalidPath"]] |> expect.exist()
  })
  it("then exceptions should contains InvalidFilename exception.",{
    # Given
    exceptions <- Path.Utility.Exceptions()

    # Then
    exceptions[["InvalidFilename"]] |> expect.exist()
  })
  it("then exceptions should contains InvalidNormalized exception.",{
    # Given
    exceptions <- Path.Utility.Exceptions()

    # Then
    exceptions[["InvalidNormalized"]] |> expect.exist()
  })
})

describe("When input |> exception[['InvalidPath']](path)",{
  it("then no exception should be thrown if input is FALSE.",{
    # Given
    exception <- Path.Utility.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["InvalidPath"]]() |> expect.no.error()
  })
  it("then an exception should be thrown if input is TRUE.",{
    # Given
    exception <- Path.Utility.Exceptions()

    random.path    <- "random.path"
    expected.error <- paste0("Invalid path: ", random.path, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["InvalidPath"]](random.path) |> expect.error(expected.error)
  })
})

describe("When input |> exception[['InvalidFilename']](filename)",{
  it("then no exception should be thrown if input is FALSE.",{
    # Given
    exception <- Path.Utility.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["InvalidFilename"]]() |> expect.no.error()
  })
  it("then an exception should be thrown if input is TRUE.",{
    # Given
    exception <- Path.Utility.Exceptions()

    random.filename <- "filename."
    expected.error  <- paste0("Invalid filename: ", random.filename, ".")

    # When
    validation.input <- TRUE

    # Then
    validation.input |> exception[["InvalidFilename"]](random.filename) |> expect.error(expected.error)
  })
})