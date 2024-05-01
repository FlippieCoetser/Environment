describe('Path.Service', {
  it('Exist',{
    Path.Service |> expect.exist()
  })
})

describe("When services <- Path.Service()", {
  it("then services is a list.", {
    # When
    services <- Path.Broker()

    # Then
    services |> expect.list()
  })
  it("then services contains 'get.user.path' service.", {
    # When
    services <- Path.Broker()

    # Then
    services[['get.user.path']] |> expect.exist()
  })
  it("then services contains 'get.config.filename' service.", {
    # When
    services <- Path.Broker()

    # Then
    services[['get.user.path']] |> expect.exist()
  })
  it("then services contains 'normalize.path' service.", {
    # When
    services <- Path.Broker()

    # Then
    services[['normalize.path']] |> expect.exist()
  })
  it("then services contains 'combine.path' service.", {
    # When
    services <- Path.Broker()

    # Then
    services[['combine.path']] |> expect.exist()
  })
  it("then services contains 'filepath.exists' service.", {
    # When
    services <- Path.Broker()

    # Then
    services[['filepath.exists']] |> expect.exist()
  })
  it("then services contains 'create.filepath' service.", {
    # When
    services <- Path.Broker()

    # Then
    services[['create.filepath']] |> expect.exist()
  })
})

describe("When service[['get.user.path']]()", {
  it("then broker[['get.user.path']]() is returned.", {
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    expected.path <- broker[['get.user.path']]()

    # When
    actual.path <- service[['get.user.path']]()

    # Then
    expected.path |> expect.equal(expected.path)
  })
  it("then no exception is thrown if returned path is valid normalized windows style path",{
    # Given
    broker  <- Path.Broker()
    broker[['get.user.path']] <- \() "C:/Users/Analyst/Documents"

    service <- broker |> Path.Service()

    # Then
    service[['get.user.path']]() |> expect.no.error()
  })
  it("then on exception is thrown if returned path is valid normalized unix style path",{
    # Given
    broker  <- Path.Broker()
    broker[['get.user.path']] <- \() "/home/username/Documents"

    service <- broker |> Path.Service()

    # Then
    service[['get.user.path']]() |> expect.no.error()
  })
  it("then an exception is thrown if returned path is invalid windows style path.", {
    # Given
    broker  <- Path.Broker()
    broker[['get.user.path']] <- \() "C:\\Users\\username/Documents"

    service <- broker |> Path.Service()

    expected.error <- paste0("Invalid path: ", "C:\\\\Users\\\\username/Documents", ".")

    # Then
    service[['get.user.path']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if returned path is invalid unix style path.", {
    # Given
    broker  <- Path.Broker()
    broker[['get.user.path']] <- \() "/home/username\\Documents"

    service <- broker |> Path.Service()

    expected.error <- paste0("Invalid path: ", "/home/username\\\\Documents", ".")

    # Then
    service[['get.user.path']]() |> expect.error(expected.error)
  })
})

describe("When service[['get.config.filename']]()", {
  it("then the configuration filename is returned.", {
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    expected.filename <- broker[['get.config.filename']]()

    # When
    actual.filename <- service[['get.user.path']]()

    # Then
    expected.filename |> expect.equal(expected.filename)
  })
  it("then an exception is thrown if returned filename is invalid.", {
    # Given
    broker  <- Path.Broker()
    broker[['get.config.filename']] <- \() "filename."

    service <- broker |> Path.Service()

    expected.error <- paste0("Invalid filename: ", "filename.", ".")

    # Then
    service[['get.config.filename']]() |> expect.error(expected.error)
  })
})

describe("When path |> service[['normalize.path']]()",{
  it("then all backslashes are replaced with forwardslash.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path    <- "C:\\Users\\username\\Documents" 

    expected.path <- "C:/Users/username/Documents"

    # When
    actual.path <- input.path |> service[['normalize.path']]()

    # Then
    actual.path |> expect.equal(expected.path)
  })
  it("then an exception is thrown if path is invalid windows style path.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path <- "C:\\Users\\username/Documents"

    expected.error <- paste0("Invalid path: ", "C:\\\\Users\\\\username/Documents", ".")

    # Then
    input.path |> service[['normalize.path']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if path is invalid unix style path.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path <- "/home/username\\Documents"

    expected.error <- paste0("Invalid path: ", "/home/username\\\\Documents", ".")

    # Then
    input.path |> service[['normalize.path']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if returned path is not normalized.",{
    # Given
    broker  <- Path.Broker()
    broker[['normalize.path']] <- \(...) "C:\\Users\\username\\Documents"

    service <- broker |> Path.Service()

    input.path    <- "C:\\Users\\username\\Documents"

    expected.error <- paste0("Invalid normalized path: ", "C:\\\\Users\\\\username\\\\Documents", ".")

    # Then
    input.path |> service[['normalize.path']]() |> expect.error(expected.error)
  })
})

describe("When path |> service[['combine.path']](filename)",{
  it("then path and filename are combined.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path     <- "C:/Users/username/Documents"
    input.filename <- "file.txt"

    expected.path  <- input.path |> broker[['combine.path']](input.filename)

    # When
    actual.path <- input.path |> service[['combine.path']](input.filename)

    # Then
    actual.path |> expect.equal(expected.path)
  })
  it("then an exception is thrown if path is invalid.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path     <- "C:\\Users\\username\\Documents"
    input.filename <- "file.txt"

    expected.error <- paste0("Invalid normalized path: ", "C:\\\\Users\\\\username\\\\Documents", ".")

    # Then
    input.path |> service[['combine.path']](filename) |> expect.error(expected.error)
  })
  it("then an exception is thrown if filename is invalid.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path     <- "C:/Users/username/Documents"
    input.filename <- "file."

    expected.error <- paste0("Invalid filename: ", "file.", ".")

    # Then
    input.path |> service[['combine.path']](input.filename) |> expect.error(expected.error)
  })
  it("then an exception is thrown if returned filepath is invalid.",{
    # Given
    broker  <- Path.Broker()
    broker[['combine.path']] <- \(...) "C:\\Users\\username\\Documents\\file.txt"

    service <- broker |> Path.Service()

    input.path     <- "C:/Users/username/Documents"
    input.filename <- "file.txt"

    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\file.txt", ".")

    # Then
    input.path |> service[['combine.path']](input.filename) |> expect.error(expected.error)
  })
})

describe("When filepath |> service[['filepath.exists']]()",{
  it("then FALSE is returned if filepath does not exist.",{
    skip_if_not(environment == 'local')
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.filepath <- "C:/path.invalid/.Renviron"

    expected.exists <- input.filepath |> broker[['filepath.exists']]()

    # When
    actual.exists <- input.filepath |> service[['filepath.exists']]()

    # Then
    actual.exists |> expect.equal(expected.exists)
  })
  it("then TRUE is returned if filepath exists.",{
    skip_if_not(environment == 'local')
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.filepath <- "C:/Users/Analyst/Documents/.Renviron"

    expected.exists <- input.filepath |> broker[['filepath.exists']]()

    # When
    actual.exists <- input.filepath |> service[['filepath.exists']]()

    # Then
    actual.exists |> expect.equal(expected.exists)
  })
  it("then an exception is thrown if filepath is invalid.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.filepath <- "C:\\Users\\username\\Documents\\.Renviron"

    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\.Renviron", ".")

    # Then
    input.filepath |> service[['filepath.exists']]() |> expect.error(expected.error)
  })
})

describe("When filepath |> service[['create.filepath']]()",{
  it("then the filepath is created if the path is valid.",{
    skip_if_not(environment == 'local')
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.filepath <- "C:/Users/Analyst/Documents/test.txt"

    expected.exists <- input.filepath |> broker[['create.filepath']]()

    # When
    actual.exists <- input.filepath |> service[['create.filepath']]()

    # Then
    actual.exists |> expect.equal(expected.exists)
  })
  it("then an exception is thrown if filepath is invalid.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.filepath <- "C:\\Users\\username\\Documents\\test.txt"

    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\test.txt", ".")

    # Then
    input.filepath |> service[['create.filepath']]() |> expect.error(expected.error)
  })
})