describe('Path.Service', {
  it('Exist',{
    # Then
    Path.Service |> expect.exist()
  })
})

describe("When services <- Path.Service()", {
  it("then services is a list.", {
    # Given
    services <- Path.Broker()

    # Then
    services |> expect.list()
  })
  it("then services contains GetUserHomePath service.", {
    # Given
    services <- Path.Broker()

    # Then
    services[["GetUserHomePath"]] |> expect.exist()
  })
  it("then services contains GetConfigFilename service.", {
    # Given
    services <- Path.Broker()

    # Then
    services[["GetConfigFilename"]] |> expect.exist()
  })
  it("then services contains NormalizePath service.", {
    # Given
    services <- Path.Broker()

    # Then
    services[["NormalizePath"]] |> expect.exist()
  })
  it("then services contains CombinePath service.", {
    # Given
    services <- Path.Broker()

    # Then
    services[["CombinePath"]] |> expect.exist()
  })
  it("then services contains FilepathExists service.", {
    # Given
    services <- Path.Broker()

    # Then
    services[["FilepathExists"]] |> expect.exist()
  })
  it("then services contains CreateFilepath service.", {
    # Given
    services <- Path.Broker()

    # Then
    services[["CreateFilepath"]] |> expect.exist()
  })
})

describe("When service[['GetUserHomePath']]()", {
  it("then broker[['GetUserHomePath']]() is returned.", {
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    expected.path <- broker[['GetUserHomePath']]()

    # When
    actual.path <- service[["GetUserHomePath"]]()

    # Then
    expected.path |> expect.equal(expected.path)
  })
  it("then no exception is thrown if returned path is valid normalized windows style path",{
    # Given
    broker  <- Path.Broker()
    broker[['GetUserHomePath']] <- \() "C:/Users/Analyst/Documents"

    service <- broker |> Path.Service()

    # Then
    service[['GetUserHomePath']]() |> expect.no.error()
  })
  it("then on exception is thrown if returned path is valid normalized unix style path",{
    # Given
    broker  <- Path.Broker()
    broker[['GetUserHomePath']] <- \() "/home/username/Documents"

    service <- broker |> Path.Service()

    # Then
    service[['GetUserHomePath']]() |> expect.no.error()
  })
  it("then an exception is thrown if returned path is invalid windows style path.", {
    # Given
    broker  <- Path.Broker()
    broker[['GetUserHomePath']] <- \() "C:\\Users\\username/Documents"

    service <- broker |> Path.Service()

    expected.error <- paste0("Invalid path: ", "C:\\\\Users\\\\username/Documents", ".")

    # Then
    service[['GetUserHomePath']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if returned path is invalid unix style path.", {
    # Given
    broker  <- Path.Broker()
    broker[['GetUserHomePath']] <- \() "/home/username\\Documents"

    service <- broker |> Path.Service()

    expected.error <- paste0("Invalid path: ", "/home/username\\\\Documents", ".")

    # Then
    service[['GetUserHomePath']]() |> expect.error(expected.error)
  })
})

describe("When service[['GetConfigFilename']]()", {
  it("then the configuration filename is returned.", {
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    expected.filename <- broker[['GetConfigFilename']]()

    # When
    actual.filename <- service[["GetConfigFilename"]]()

    # Then
    expected.filename |> expect.equal(expected.filename)
  })
  it("then an exception is thrown if returned filename is invalid.", {
    # Given
    broker  <- Path.Broker()
    broker[['GetConfigFilename']] <- \() "filename."

    service <- broker |> Path.Service()

    expected.error <- paste0("Invalid filename: ", "filename.", ".")

    # Then
    service[['GetConfigFilename']]() |> expect.error(expected.error)
  })
})

describe("When path |> service[['NormalizePath']]()",{
  it("then all backslashes are replaced with forwardslash.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path    <- "C:\\Users\\username\\Documents"
    expected.path <- "C:/Users/username/Documents"

    # When
    actual.path <- input.path |> service[["NormalizePath"]]()

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
    input.path |> service[["NormalizePath"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if path is invalid unix style path.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path <- "/home/username\\Documents"
    expected.error <- paste0("Invalid path: ", "/home/username\\\\Documents", ".")

    # Then
    input.path |> service[["NormalizePath"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if returned path is not normalized.",{
    # Given
    broker  <- Path.Broker()
    broker[['NormalizePath']] <- \(...) "C:\\Users\\username\\Documents"

    service <- broker |> Path.Service()

    input.path    <- "C:\\Users\\username\\Documents"

    expected.error <- paste0("Invalid normalized path: ", "C:\\\\Users\\\\username\\\\Documents", ".")

    # Then
    input.path |> service[['NormalizePath']]() |> expect.error(expected.error)
  })
})

describe("When path |> service[['CombinePath']](filename)",{
  it("then path and filename are combined.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path     <- "C:/Users/username/Documents"
    input.filename <- "file.txt"
    expected.path  <- input.path |> broker[['CombinePath']](input.filename)

    # When
    actual.path <- input.path |> service[["CombinePath"]](input.filename)

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
    input.path |> service[["CombinePath"]](filename) |> expect.error(expected.error)
  })
  it("then an exception is thrown if filename is invalid.",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.path     <- "C:/Users/username/Documents"
    input.filename <- "file."
    expected.error <- paste0("Invalid filename: ", "file.", ".")

    # Then
    input.path |> service[["CombinePath"]](input.filename) |> expect.error(expected.error)
  })
  it("then an exception is thrown if returned filepath is invalid.",{
    # Given
    broker  <- Path.Broker()
    broker[['CombinePath']] <- \(...) "C:\\Users\\username\\Documents\\file.txt"

    service <- broker |> Path.Service()

    input.path     <- "C:/Users/username/Documents"
    input.filename <- "file.txt"

    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\file.txt", ".")

    # Then
    input.path |> service[['CombinePath']](input.filename) |> expect.error(expected.error)
  })
})

describe("When filepath |> service[['FilepathExists']]()",{
  it("then FALSE is returned if filepath does not exist.",{
    skip_if_not(environment == 'local')
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.filepath <- "C:/InvalidPath/.Renviron"
    expected.exists <- input.filepath |> broker[['FilepathExists']]()

    # When
    actual.exists <- input.filepath |> service[["FilepathExists"]]()

    # Then
    actual.exists |> expect.equal(expected.exists)
  })
  it("then TRUE is returned if filepath exists.",{
    skip_if_not(environment == 'local')
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.filepath <- "C:/Users/Analyst/Documents/.Renviron"
    expected.exists <- input.filepath |> broker[['FilepathExists']]()

    # When
    actual.exists <- input.filepath |> service[["FilepathExists"]]()

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
    input.filepath |> service[["FilepathExists"]]() |> expect.error(expected.error)
  })
})

describe("When filepath |> service[['CreateFilepath']]()",{
  it("then the filepath is created if the path is valid.",{
    skip_if_not(environment == 'local')
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()

    input.filepath <- "C:/Users/Analyst/Documents/test.txt"
    expected.exists <- input.filepath |> broker[['CreateFilepath']]()

    # When
    actual.exists <- input.filepath |> service[["CreateFilepath"]]()

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
    input.filepath |> service[["CreateFilepath"]]() |> expect.error(expected.error)
  })
})