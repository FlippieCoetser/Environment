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
})

describe("When path |> validate[['Path']]()",{
  it("then the path should be returned if path is a valid windows style path.",{
    # Given
    validate <- Path.Utility.Validation()

    input.path <- "C:\\Users\\username\\Documents"
    expect.path <- input.path
    
    # When
    actual.path <-  input.path |> validate[["Path"]]()
    
    # Then
    actual.path |> expect.equal(expect.path)
  })
  it("then an exception should be thrown if path is not a valid windows style path.",{
    # Given
    validate <- Path.Utility.Validation()

    path <- "C:\\Users\\username/Documents"
    expected.error <- paste0("Invalid path: ", "C:\\\\Users\\\\username/Documents", ".")

    # Then
    path |> validate[["Path"]]() |> expect.error(expected.error)

  })
  it("then the path should be returned if path is a valid unix style path.",{
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
  it("then the filename should be returned if filename is valid.",{
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
  it("then the path should be returned if path is valid.",{
    # Given
    validate <- Path.Utility.Validation()

    input.path <- "C:/Users/username/Documents"
    expect.path <- input.path

    # When
    actual.path <-  input.path |> validate[["Normalized"]]()
    
    # Then
    actual.path |> expect.equal(expect.path)
  })
})