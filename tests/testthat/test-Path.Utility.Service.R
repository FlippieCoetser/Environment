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
})