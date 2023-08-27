describe('Path.Utility.Validation', {
  it('Exist',{
    # Then
    Path.Utility.Validation |> expect.exist()
  })
})

describe("When validators <- Path.Utility.Validation()", {
  it("then validators should be a list.", {
    # Given
    validators <- Path.Utility.Validation()

    # Then
    validators |> expect.list()
  })
  it("then validators should contain Path service.", {
    # Given
    validators <- Path.Utility.Validation()

    # Then
    validators[["Path"]] |> expect.exist()
  })
  it("then validators should contain Filename validator.", {
    # Given
    validators <- Path.Utility.Validation()

    # Then
    validators[["Filename"]] |> expect.exist()
  })
  it("then validators should contain Normalized validator.", {
    # Given
    validators <- Path.Utility.Validation()

    # Then
    validators[["Normalized"]] |> expect.exist()
  })
  it("then validators should contain Filepath validator.", {
    # Given
    validators <- Path.Utility.Validation()

    # Then
    validators[["Filepath"]] |> expect.exist()
  })
})

describe("When path |> validate[['Path']]()",{
  it("then path should be returned if path is a valid windows style path.",{
    # Given
    validate <- Path.Utility.Validation()

    input.path <- "C:\\Users\\username\\Documents"
    expect.path <- input.path
    
    # When
    actual.path <-  input.path |> validate[["Path"]]()
    
    # Then
    actual.path |> expect.equal(expect.path)
  })
  it("then no exception is thrown if returned path is valid normalized windows style path",{
    # Given
    validate <- Path.Utility.Validation()

    input.path <- "C:/Users/Analyst/Documents"
    expect.path <- input.path

    # Then
    input.path |> validate[["Path"]]() |> expect.no.error()
  })
  it("then on exception is thrown if returned path is valid normalized unix style path",{
    # Given
    validate <- Path.Utility.Validation()

    input.path <- "/home/username/Documents"
    expect.path <- input.path

    # Then
    input.path |> validate[["Path"]]() |> expect.no.error()
  })
  it("then an exception should be thrown if path is not a valid windows style path.",{
    # Given
    validate <- Path.Utility.Validation()

    path <- "C:\\Users\\username/Documents"
    expected.error <- paste0("Invalid path: ", "C:\\\\Users\\\\username/Documents", ".")

    # Then
    path |> validate[["Path"]]() |> expect.error(expected.error)

  })
  it("then path should be returned if path is a valid unix style path.",{
    # Given
    validate <- Path.Utility.Validation()

    input.path <- "/home/username/Documents"
    expect.path <- input.path

    # When
    actual.path <-  input.path |> validate[["Path"]]()
    
    # Then
    actual.path |> expect.equal(expect.path)
  })
  it("then an exception should be thrown if path is not a valid unix style path.",{
    # Given
    validate <- Path.Utility.Validation()

    path <- "/home/username\\Documents"
    expected.error <- paste0("Invalid path: ", "/home/username\\\\Documents", ".")

    # Then
    path |> validate[["Path"]]() |> expect.error(expected.error)
  })
})

describe("When filename |> validate[['Filename']]()",{
  it("then filename should be returned if filename is valid.",{
    # Given
    validate <- Path.Utility.Validation()

    input.filename <- ".Renviron"
    expect.filename <- input.filename

    # When
    actual.filename <-  input.filename |> validate[["Filename"]]()
    
    # Then
    actual.filename |> expect.equal(expect.filename)
  })
  it("then an exception should be thrown if filename is not valid.",{
    # Given
    validate <- Path.Utility.Validation()

    filename <- "filename."
    expected.error <- paste0("Invalid filename: ", filename, ".")

    # Then
    filename |> validate[["Filename"]]() |> expect.error(expected.error)
  })
})

describe("When path |> validate[['Normalized']]()",{
  it("then path should be returned if path is valid.",{
    # Given
    validate <- Path.Utility.Validation()

    input.path <- "C:/Users/username/Documents"
    expect.path <- input.path

    # When
    actual.path <-  input.path |> validate[["Normalized"]]()
    
    # Then
    actual.path |> expect.equal(expect.path)
  })
  it("then an exception should be thrown if path is invalid path.",{
    # Given
    validate <- Path.Utility.Validation()

    path <- "C:\\Users\\username\\Documents"
    expected.error <- paste0("Invalid normalized path: ", "C:\\\\Users\\\\username\\\\Documents", ".")

    # Then
    path |> validate[["Normalized"]]() |> expect.error(expected.error)
  })
})

describe("When filepath |> validate[['Filepath']]()",{
  it("then filepath should be returned if filepath is valid.",{
    # Given
    validate <- Path.Utility.Validation()

    input.filepath <- "C:/Users/username/Documents/.Renviron"
    expect.filepath <- input.filepath

    # When
    actual.filepath <-  input.filepath |> validate[["Filepath"]]()
    
    # Then
    actual.filepath |> expect.equal(expect.filepath)
  })
  it("then an exception should be thrown if filepath is invalid.",{
    # Given
    validate <- Path.Utility.Validation()

    filepath <- "C:\\Users\\username\\Documents\\.Renviron"
    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\.Renviron", ".")

    # Then
    filepath |> validate[["Filepath"]]() |> expect.error(expected.error)
  })
})