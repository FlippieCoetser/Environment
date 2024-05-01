describe('Path.Broker', {
  it('Exist',{
    Path.Broker |> expect.exist()
  })
})

describe("When operations <- Path.Broker()", {
  it("then operations is a list.", {
    # When
    operations <- Path.Broker()

    # Then
    operations |> expect.list()
  })
  it("then operations contains 'get.user.path' operation.", {
    # When
    operations <- Path.Broker()

    # Then
    operations[['get.user.path']] |> expect.exist()
  })
  it("then operations contains 'get.config.filename' operation.", {
    # When
    operations <- Path.Broker()

    # Then
    operations[['get.config.filename']] |> expect.exist()
  })
  it("then operations contains 'normalize.path' operation.", {
    # When
    operations <- Path.Broker()

    # Then
    operations[['normalize.path']] |> expect.exist()
  })
  it("then operations contains 'combine.path' operation.", {
    # When
    operations <- Path.Broker()

    # Then
    operations[['combine.path']] |> expect.exist()
  })
  it("then operations contains 'filepath.exists' operation.", {
    # When
    operations <- Path.Broker()

    # Then
    operations[['filepath.exists']] |> expect.exist()
  })
  it("then operations contains 'create.filepath' operation.", {
    # When
    operations <- Path.Broker()

    # Then
    operations[['create.filepath']] |> expect.exist()
  })
})

describe("When operation[['get.user.path']]()",{
  it("then the user home path is returned.",{
    # Given
    operation <- Path.Broker()

    expected.path <- path.expand('~')

    # When
    actual.path <- operation[['get.user.path']]()

    # Then
    actual.path |> expect.equal(expected.path)
  })
})

describe("When operation[['get.config.filename']]()",{
  it("then the configuration filename is returned.",{
    # Given
    operation <- Path.Broker()

    expected.filename <- ".Renviron"

    # When
    actual.filename <- operation[['get.config.filename']]()

    # Then
    actual.filename |> expect.equal(expected.filename)
  })
})

describe("When path |> operation[['normalize.path']]()",{
  it("then all double backslashes are replaced with a single forwardslash.",{
    # Given
    operation <- Path.Broker()

    input.path    <- "C:\\Users\\user\\Documents\\"
    expected.path <- "C:/Users/user/Documents/"

    # When
    actual.path <- input.path |> operation[['normalize.path']]()

    # Then
    actual.path |> expect.equal(expected.path)
  })
})

describe("When path |> operation[['combine.path']]()",{
  it("then the path and filename are combined.",{
    # Given
    operation <- Path.Broker()

    input.path     <- "C:/Users/user/Documents"
    input.filename <- "file.txt"

    expected.path <- "C:/Users/user/Documents/file.txt"

    # When
    actual.path <- input.path |> operation[['combine.path']](input.filename)

    # Then
    actual.path |> expect.equal(expected.path)
  })
})

describe("When filepath |> operation[['filepath.exists']]()",{
  it("then FALSE is returned if filepath does not exist.",{
    skip_if_not(environment == 'local')
    # Given
    operation <- Path.Broker()

    filepath  <- "C:/path.invalid/.Renviron"

    # When
    result <- filepath |> operation[['filepath.exists']]()

    # Then
    result |> expect.false()
  })
  it("then TRUE is returned if filepath exists.",{
    skip_if_not(environment == 'local')
    # Given
    operation <- Path.Broker()

    input.filepath  <- "C:/Users/Analyst/Documents/.Renviron"

    # When
    actual.result <- input.filepath |> operation[['filepath.exists']]()

    # Then
    actual.result |> expect.true()
  })
})

describe("When filepath |> operation[['create.filepath']]()",{
  it("then the filepath is created if filepath is valid.",{
    skip_if_not(environment == 'local')
    # Given
    operation <- Path.Broker()

    filepath <- "C:/Users/Analyst/Documents/test.txt"

    # When
    result <- filepath |> operation[['create.filepath']]()

    # Then
    result |> expect.true()
  })
  it("then a warning is thrown if filepath is is invalid.",{
    # Given
    operation <- Path.Broker()

    # When
    filepath <- "C:/Users/Analyst/Invalid/test.txt"

    # Then
    filepath |> operation[['create.filepath']]() |> expect.warning()
  })
})