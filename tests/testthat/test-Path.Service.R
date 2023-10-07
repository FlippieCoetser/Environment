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
  it("then services contains 'Get.User.Path' service.", {
    # When
    services <- Path.Broker()

    # Then
    services[['Get.User.Path']] |> expect.exist()
  })
  it("then services contains 'Get.Config.Filename' service.", {
    # When
    services <- Path.Broker()

    # Then
    services[['Get.User.Path']] |> expect.exist()
  })
  it("then services contains 'Normalize.Path' service.", {
    # When
    services <- Path.Broker()

    # Then
    services[['Normalize.Path']] |> expect.exist()
  })
  it("then services contains 'Combine.Path' service.", {
    # When
    services <- Path.Broker()

    # Then
    services[['Combine.Path']] |> expect.exist()
  })
  it("then services contains 'Filepath.Exists' service.", {
    # When
    services <- Path.Broker()

    # Then
    services[['Filepath.Exists']] |> expect.exist()
  })
  it("then services contains 'Create.Filepath' service.", {
    # When
    services <- Path.Broker()

    # Then
    services[['Create.Filepath']] |> expect.exist()
  })
})

describe("When service[['Get.User.Path']]()", {
  it("then broker[['Get.User.Path']]() is returned.", {
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    expected.path <- broker[['Get.User.Path']]()

    # When
    actual.path <- service[['Get.User.Path']]()

    # Then
    expected.path |> expect.equal(expected.path)
  })
  it("then no exception is thrown if returned path is valid normalized windows style path",{
    # Given
    broker  <- Path.Broker()
    broker[['Get.User.Path']] <- \() "C:/Users/Analyst/Documents"

    service <- broker |> Path.Service()

    # Then
    service[['Get.User.Path']]() |> expect.no.error()
  })
  it("then on exception is thrown if returned path is valid normalized unix style path",{
    # Given
    broker  <- Path.Broker()
    broker[['Get.User.Path']] <- \() "/home/username/Documents"

    service <- broker |> Path.Service()

    # Then
    service[['Get.User.Path']]() |> expect.no.error()
  })
  it("then an exception is thrown if returned path is invalid windows style path.", {
    # Given
    broker  <- Path.Broker()
    broker[['Get.User.Path']] <- \() "C:\\Users\\username/Documents"

    service <- broker |> Path.Service()

    expected.error <- paste0("Invalid path: ", "C:\\\\Users\\\\username/Documents", ".")

    # Then
    service[['Get.User.Path']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if returned path is invalid unix style path.", {
    # Given
    broker  <- Path.Broker()
    broker[['Get.User.Path']] <- \() "/home/username\\Documents"

    service <- broker |> Path.Service()

    expected.error <- paste0("Invalid path: ", "/home/username\\\\Documents", ".")

    # Then
    service[['Get.User.Path']]() |> expect.error(expected.error)
  })
})

describe("When service[['Get.Config.Filename']]()", {
  it("then the configuration filename is returned.", {
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    expected.filename <- broker[['Get.Config.Filename']]()

    # When
    actual.filename <- service[['Get.User.Path']]()

    # Then
    expected.filename |> expect.equal(expected.filename)
  })
  it("then an exception is thrown if returned filename is invalid.", {
    # Given
    broker  <- Path.Broker()
    broker[['Get.Config.Filename']] <- \() "filename."

    service <- broker |> Path.Service()

    expected.error <- paste0("Invalid filename: ", "filename.", ".")

    # Then
    service[['Get.Config.Filename']]() |> expect.error(expected.error)
  })
})

describe("When path |> service[['Normalize.Path']]()",{
  it("then all backslashes are replaced with forwardslash.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path    <- "C:\\Users\\username\\Documents" 

    expected.path <- "C:/Users/username/Documents"

    # When
    actual.path <- input.path |> service[['Normalize.Path']]()

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
    input.path |> service[['Normalize.Path']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if path is invalid unix style path.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path <- "/home/username\\Documents"

    expected.error <- paste0("Invalid path: ", "/home/username\\\\Documents", ".")

    # Then
    input.path |> service[['Normalize.Path']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if returned path is not normalized.",{
    # Given
    broker  <- Path.Broker()
    broker[['Normalize.Path']] <- \(...) "C:\\Users\\username\\Documents"

    service <- broker |> Path.Service()

    input.path    <- "C:\\Users\\username\\Documents"

    expected.error <- paste0("Invalid normalized path: ", "C:\\\\Users\\\\username\\\\Documents", ".")

    # Then
    input.path |> service[['Normalize.Path']]() |> expect.error(expected.error)
  })
})

describe("When path |> service[['Combine.Path']](filename)",{
  it("then path and filename are combined.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path     <- "C:/Users/username/Documents"
    input.filename <- "file.txt"

    expected.path  <- input.path |> broker[['Combine.Path']](input.filename)

    # When
    actual.path <- input.path |> service[['Combine.Path']](input.filename)

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
    input.path |> service[['Combine.Path']](filename) |> expect.error(expected.error)
  })
  it("then an exception is thrown if filename is invalid.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path     <- "C:/Users/username/Documents"
    input.filename <- "file."

    expected.error <- paste0("Invalid filename: ", "file.", ".")

    # Then
    input.path |> service[['Combine.Path']](input.filename) |> expect.error(expected.error)
  })
  it("then an exception is thrown if returned filepath is invalid.",{
    # Given
    broker  <- Path.Broker()
    broker[['Combine.Path']] <- \(...) "C:\\Users\\username\\Documents\\file.txt"

    service <- broker |> Path.Service()

    input.path     <- "C:/Users/username/Documents"
    input.filename <- "file.txt"

    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\file.txt", ".")

    # Then
    input.path |> service[['Combine.Path']](input.filename) |> expect.error(expected.error)
  })
})

describe("When filepath |> service[['Filepath.Exists']]()",{
  it("then FALSE is returned if filepath does not exist.",{
    skip_if_not(environment == 'local')
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.filepath <- "C:/Path.Invalid/.Renviron"

    expected.exists <- input.filepath |> broker[['Filepath.Exists']]()

    # When
    actual.exists <- input.filepath |> service[['Filepath.Exists']]()

    # Then
    actual.exists |> expect.equal(expected.exists)
  })
  it("then TRUE is returned if filepath exists.",{
    skip_if_not(environment == 'local')
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.filepath <- "C:/Users/Analyst/Documents/.Renviron"

    expected.exists <- input.filepath |> broker[['Filepath.Exists']]()

    # When
    actual.exists <- input.filepath |> service[['Filepath.Exists']]()

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
    input.filepath |> service[['Filepath.Exists']]() |> expect.error(expected.error)
  })
})

describe("When filepath |> service[['Create.Filepath']]()",{
  it("then the filepath is created if the path is valid.",{
    skip_if_not(environment == 'local')
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.filepath <- "C:/Users/Analyst/Documents/test.txt"

    expected.exists <- input.filepath |> broker[['Create.Filepath']]()

    # When
    actual.exists <- input.filepath |> service[['Create.Filepath']]()

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
    input.filepath |> service[['Create.Filepath']]() |> expect.error(expected.error)
  })
})