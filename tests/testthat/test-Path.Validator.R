describe('Path.Validator', {
  it('Exist',{
    Path.Validator |> expect.exist()
  })
})

describe("When validations <- Path.Validator()", {
  it("then validations is a list.", {
    # When
    validations <- Path.Validator()

    # Then
    validations |> expect.list()
  })
  it("then validations contains 'Path' validator.", {
    # When
    validations <- Path.Validator()

    # Then
    validations[['Path']] |> expect.exist()
  })
  it("then validations contains 'Filename' validator.", {
    # When
    validations <- Path.Validator()

    # Then
    validations[['Filename']] |> expect.exist()
  })
  it("then validations contains 'Normalized' validator.", {
    # When
    validations <- Path.Validator()

    # Then
    validations[['Normalized']] |> expect.exist()
  })
  it("then validations contains 'Filepath' validator.", {
    # When
    validations <- Path.Validator()

    # Then
    validations[['Filepath']] |> expect.exist()
  })
})

describe("When path |> validate[['Path']]()",{
  it("then path is returned if path is a valid windows style path.",{
    # Given
    validate <- Path.Validator()

    input.path  <- "C:\\Users\\username\\Documents"
    
    expect.path <- input.path
    
    # When
    actual.path <-  input.path |> validate[['Path']]()
    
    # Then
    actual.path |> expect.equal(expect.path)
  })
  it("then no exception is thrown if returned path is valid normalized windows style path",{
    # Given
    validate <- Path.Validator()

    input.path  <- "C:/Users/Analyst/Documents"

    expect.path <- input.path

    # Then
    input.path |> validate[['Path']]() |> expect.no.error()
  })
  it("then on exception is thrown if returned path is valid normalized unix style path",{
    # Given
    validate <- Path.Validator()

    input.path  <- "/home/username/Documents"

    expect.path <- input.path

    # Then
    input.path |> validate[['Path']]() |> expect.no.error()
  })
  it("then an exception is thrown if path is not a valid windows style path.",{
    # Given
    validate <- Path.Validator()

    path <- "C:\\Users\\username/Documents"

    expected.error <- paste0("Invalid path: ", "C:\\\\Users\\\\username/Documents", ".")

    # Then
    path |> validate[['Path']]() |> expect.error(expected.error)

  })
  it("then path is returned if path is a valid unix style path.",{
    # Given
    validate <- Path.Validator()

    input.path  <- "/home/username/Documents"

    expect.path <- input.path

    # When
    actual.path <-  input.path |> validate[['Path']]()
    
    # Then
    actual.path |> expect.equal(expect.path)
  })
  it("then an exception is thrown if path is not a valid unix style path.",{
    # Given
    validate <- Path.Validator()

    path <- "/home/username\\Documents"

    expected.error <- paste0("Invalid path: ", "/home/username\\\\Documents", ".")

    # Then
    path |> validate[['Path']]() |> expect.error(expected.error)
  })
})

describe("When filename |> validate[['Filename']]()",{
  it("then filename is returned if filename is valid.",{
    # Given
    validate <- Path.Validator()

    input.filename  <- ".Renviron"

    expect.filename <- input.filename

    # When
    actual.filename <-  input.filename |> validate[['Filename']]()
    
    # Then
    actual.filename |> expect.equal(expect.filename)
  })
  it("then an exception is thrown if filename is invalid.",{
    # Given
    validate <- Path.Validator()

    filename <- "filename."

    expected.error <- paste0("Invalid filename: ", filename, ".")

    # Then
    filename |> validate[['Filename']]() |> expect.error(expected.error)
  })
})

describe("When path |> validate[['Normalized']]()",{
  it("then path is returned if path is valid.",{
    # Given
    validate <- Path.Validator()

    input.path  <- "C:/Users/username/Documents"

    expect.path <- input.path

    # When
    actual.path <-  input.path |> validate[['Normalized']]()
    
    # Then
    actual.path |> expect.equal(expect.path)
  })
  it("then an exception is thrown if path is invalid.",{
    # Given
    validate <- Path.Validator()

    path <- "C:\\Users\\username\\Documents"

    expected.error <- paste0("Invalid normalized path: ", "C:\\\\Users\\\\username\\\\Documents", ".")

    # Then
    path |> validate[['Normalized']]() |> expect.error(expected.error)
  })
})

describe("When filepath |> validate[['Filepath']]()",{
  it("then filepath is returned if filepath is valid.",{
    # Given
    validate <- Path.Validator()

    input.filepath  <- "C:/Users/username/Documents/.Renviron"

    expect.filepath <- input.filepath

    # When
    actual.filepath <-  input.filepath |> validate[['Filepath']]()
    
    # Then
    actual.filepath |> expect.equal(expect.filepath)
  })
  it("then an exception is thrown if filepath is invalid.",{
    # Given
    validate <- Path.Validator()

    filepath <- "C:\\Users\\username\\Documents\\.Renviron"

    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\.Renviron", ".")

    # Then
    filepath |> validate[['Filepath']]() |> expect.error(expected.error)
  })
})