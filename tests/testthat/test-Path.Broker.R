describe('Path.Broker', {
  it('Exist',{
    # Then
    Path.Broker |> expect.exist()
  })
})

describe("When operations <- Path.Broker()", {
  it("then operations is a list.", {
    # Given
    operations <- Path.Broker()

    # Then
    operations |> expect.list()
  })
  it("then operations contains GetUserHomePath operation.", {
    # Given
    operations <- Path.Broker()

    # Then
    operations[["GetUserHomePath"]] |> expect.exist()
  })
  it("then operations contains GetConfigFilename operation.", {
    # Given
    operations <- Path.Broker()

    # Then
    operations[["GetConfigFilename"]] |> expect.exist()
  })
  it("then operations contains NormalizePath operation.", {
    # Given
    operations <- Path.Broker()

    # Then
    operations[["NormalizePath"]] |> expect.exist()
  })
  it("then operations contains CombinePath operation.", {
    # Given
    operations <- Path.Broker()

    # Then
    operations[["CombinePath"]] |> expect.exist()
  })
  it("then operations contains FilepathExists operation.", {
    # Given
    operations <- Path.Broker()

    # Then
    operations[["FilepathExists"]] |> expect.exist()
  })
  it("then operations contains CreateFilepath operation.", {
    # Given
    operations <- Path.Broker()

    # Then
    operations[["CreateFilepath"]] |> expect.exist()
  })
})

describe("When operation[['GetUserHomePath']]()",{
  it("then the user home path is returned.",{
    # Given
    operation <- Path.Broker()

    expected.path <- path.expand('~')

    # When
    actual.path <- operation[["GetUserHomePath"]]()

    # Then
    actual.path |> expect.equal(expected.path)
  })
})

describe("When operation[['GetConfigFilename']]()",{
  it("then the config filename is returned.",{
    # Given
    operation <- Path.Broker()

    expected.filename <- ".Renviron"

    # When
    actual.filename <- operation[["GetConfigFilename"]]()

    # Then
    actual.filename |> expect.equal(expected.filename)
  })
})

describe("When path |> operation[['NormalizePath']]()",{
  it("then all double backslashes are replaced with single forwardslash.",{
    # Given
    operation <- Path.Broker()

    input.path <- "C:\\Users\\user\\Documents\\"
    expected.path <- "C:/Users/user/Documents/"

    # When
    actual.path <- input.path |> operation[["NormalizePath"]]()

    # Then
    actual.path |> expect.equal(expected.path)
  })
})

describe("When path |> operation[['CombinePath']]()",{
  it("then the path and filename are combined.",{
    # Given
    operation <- Path.Broker()

    input.path <- "C:/Users/user/Documents"
    input.filename <- "file.txt"
    expected.path <- "C:/Users/user/Documents/file.txt"

    # When
    actual.path <- input.path |> operation[["CombinePath"]](input.filename)

    # Then
    actual.path |> expect.equal(expected.path)
  })
})

describe("When filepath |> operation[['FilepathExists']]()",{
  it("then FALSE is returned if filepath does not exist.",{
    skip_if_not(environment == 'local')
    # Given
    operation <- Path.Broker()

    input.filepath <- "C:/InvalidPath/.Renviron"
    expected.result <- FALSE

    # When
    actual.result <- input.filepath |> operation[["FilepathExists"]]()

    # Then
    actual.result |> expect.equal(expected.result)
  })
  it("then TRUE is returned if filepath exists.",{
    skip_if_not(environment == 'local')
    # Given
    operation <- Path.Broker()

    input.filepath <- "C:/Users/Analyst/Documents/.Renviron"
    expected.result <- TRUE

    # When
    actual.result <- input.filepath |> operation[["FilepathExists"]]()

    # Then
    actual.result |> expect.equal(expected.result)
  })
})

describe("When filepath |> operation[['CreateFilepath']]()",{
  it("then the filepath is created if the path is valid.",{
    skip_if_not(environment == 'local')
    # Given
    operation <- Path.Broker()

    input.filepath <- "C:/Users/Analyst/Documents/test.txt"
    expected.result <- TRUE

    # When
    actual.result <- input.filepath |> operation[["CreateFilepath"]]()

    # Then
    actual.result |> expect.equal(expected.result)
  })
  it("then a warning is thrown if filepath is is invalid.",{
    skip_if_not(environment == 'local')
    # Given
    operation <- Path.Broker()

    input.filepath <- "C:/Users/Analyst/Invalid/test.txt"

    # Then
    input.filepath |> operation[["CreateFilepath"]]() |> expect.warning()
  })
})