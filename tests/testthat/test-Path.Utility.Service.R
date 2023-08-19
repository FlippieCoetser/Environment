describe('Path.Utility.Service', {
  it('Exist',{
    # Then
    Path.Utility.Service |> expect.exist()
  })
})

describe("When services <- Path.Utility.Service()", {
  it("then services should be a list.", {
    # Given
    services <- Path.Utility.Broker()

    # Then
    services |> expect.list()
  })
  it("then services should contain GetUserHomePath service.", {
    # Given
    services <- Path.Utility.Broker()

    # Then
    services[["GetUserHomePath"]] |> expect.exist()
  })
  it("then services should contain GetConfigFilename service.", {
    # Given
    services <- Path.Utility.Broker()

    # Then
    services[["GetConfigFilename"]] |> expect.exist()
  })
  it("then services should contain NormalizePath service.", {
    # Given
    services <- Path.Utility.Broker()

    # Then
    services[["NormalizePath"]] |> expect.exist()
  })
  it("then services should contain CombinePath service.", {
    # Given
    services <- Path.Utility.Broker()

    # Then
    services[["CombinePath"]] |> expect.exist()
  })
  it("then services should contain FilepathExists service.", {
    # Given
    services <- Path.Utility.Broker()

    # Then
    services[["FilepathExists"]] |> expect.exist()
  })
  it("then services should contain CreateFilepath service.", {
    # Given
    services <- Path.Utility.Broker()

    # Then
    services[["CreateFilepath"]] |> expect.exist()
  })
})

describe("When service[['GetUserHomePath']]()", {
  it("then broker[['GetUserHomePath']]() should be returned.", {
    # Given
    broker  <- Path.Utility.Broker()
    service <- broker |> Path.Utility.Service()

    expected.path <- broker[['GetUserHomePath']]()

    # When
    actual.path <- service[["GetUserHomePath"]]()

    # Then
    expected.path |> expect.equal(expected.path)
  })
})

describe("When service[['GetConfigFilename']]()", {
  it("then broker[['GetConfigFilename']]() should be returned.", {
    # Given
    broker  <- Path.Utility.Broker()
    service <- broker |> Path.Utility.Service()

    expected.filename <- broker[['GetConfigFilename']]()

    # When
    actual.filename <- service[["GetConfigFilename"]]()

    # Then
    expected.filename |> expect.equal(expected.filename)
  })
})

describe("Then path |> service[['NormalizePath']]()",{
  it("then all double backslashes are replaced with single forwardslash.",{
    # Given
    broker  <- Path.Utility.Broker()
    service <- broker |> Path.Utility.Service()

    input.path    <- "C:\\Users\\username\\Documents"
    expected.path <- "C:/Users/username/Documents"

    # When
    actual.path <- input.path |> service[["NormalizePath"]]()

    # Then
    actual.path |> expect.equal(expected.path)
  })
})