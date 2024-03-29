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
  it("then operations contains 'Get.User.Path' operation.", {
    # When
    operations <- Path.Broker()

    # Then
    operations[['Get.User.Path']] |> expect.exist()
  })
  it("then operations contains 'Get.Config.Filename' operation.", {
    # When
    operations <- Path.Broker()

    # Then
    operations[['Get.Config.Filename']] |> expect.exist()
  })
  it("then operations contains 'Normalize.Path' operation.", {
    # When
    operations <- Path.Broker()

    # Then
    operations[['Normalize.Path']] |> expect.exist()
  })
  it("then operations contains 'Combine.Path' operation.", {
    # When
    operations <- Path.Broker()

    # Then
    operations[['Combine.Path']] |> expect.exist()
  })
  it("then operations contains 'Filepath.Exists' operation.", {
    # When
    operations <- Path.Broker()

    # Then
    operations[['Filepath.Exists']] |> expect.exist()
  })
  it("then operations contains 'Create.Filepath' operation.", {
    # When
    operations <- Path.Broker()

    # Then
    operations[['Create.Filepath']] |> expect.exist()
  })
})

describe("When operation[['Get.User.Path']]()",{
  it("then the user home path is returned.",{
    # Given
    operation <- Path.Broker()

    expected.path <- path.expand('~')

    # When
    actual.path <- operation[['Get.User.Path']]()

    # Then
    actual.path |> expect.equal(expected.path)
  })
})

describe("When operation[['Get.Config.Filename']]()",{
  it("then the configuration filename is returned.",{
    # Given
    operation <- Path.Broker()

    expected.filename <- ".Renviron"

    # When
    actual.filename <- operation[['Get.Config.Filename']]()

    # Then
    actual.filename |> expect.equal(expected.filename)
  })
})

describe("When path |> operation[['Normalize.Path']]()",{
  it("then all double backslashes are replaced with a single forwardslash.",{
    # Given
    operation <- Path.Broker()

    input.path    <- "C:\\Users\\user\\Documents\\"
    expected.path <- "C:/Users/user/Documents/"

    # When
    actual.path <- input.path |> operation[['Normalize.Path']]()

    # Then
    actual.path |> expect.equal(expected.path)
  })
})

describe("When path |> operation[['Combine.Path']]()",{
  it("then the path and filename are combined.",{
    # Given
    operation <- Path.Broker()

    input.path     <- "C:/Users/user/Documents"
    input.filename <- "file.txt"

    expected.path <- "C:/Users/user/Documents/file.txt"

    # When
    actual.path <- input.path |> operation[['Combine.Path']](input.filename)

    # Then
    actual.path |> expect.equal(expected.path)
  })
})

describe("When filepath |> operation[['Filepath.Exists']]()",{
  it("then FALSE is returned if filepath does not exist.",{
    skip_if_not(environment == 'local')
    # Given
    operation <- Path.Broker()

    filepath  <- "C:/Path.Invalid/.Renviron"

    # When
    result <- filepath |> operation[['Filepath.Exists']]()

    # Then
    result |> expect.false()
  })
  it("then TRUE is returned if filepath exists.",{
    skip_if_not(environment == 'local')
    # Given
    operation <- Path.Broker()

    input.filepath  <- "C:/Users/Analyst/Documents/.Renviron"

    # When
    actual.result <- input.filepath |> operation[['Filepath.Exists']]()

    # Then
    actual.result |> expect.true()
  })
})

describe("When filepath |> operation[['Create.Filepath']]()",{
  it("then the filepath is created if filepath is valid.",{
    skip_if_not(environment == 'local')
    # Given
    operation <- Path.Broker()

    filepath <- "C:/Users/Analyst/Documents/test.txt"

    # When
    result <- filepath |> operation[['Create.Filepath']]()

    # Then
    result |> expect.true()
  })
  it("then a warning is thrown if filepath is is invalid.",{
    # Given
    operation <- Path.Broker()

    # When
    filepath <- "C:/Users/Analyst/Invalid/test.txt"

    # Then
    filepath |> operation[['Create.Filepath']]() |> expect.warning()
  })
})