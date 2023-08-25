describe('Path.Utility.Processing', {
  it('Exist',{
    # Then
    Path.Utility.Processing |> expect.exist()
  })
})

describe("When processors <- Path.Utility.Processing()",{
  it("then processors should be a list.", {
    # Given
    processors <- Path.Utility.Processing()

    # Then
    processors |> expect.list()
  })
  it("then processors contains GetConfigFilepath", {
    # Given
    processors <- Path.Utility.Processing()

    # Then
    processors[['GetConfigFilepath']] |> expect.exist()
  })
  it("then processors contains EnsureFilepathExist", {
    # Given
    processors <- Path.Utility.Processing()

    # Then
    processors[['EnsureFilepathExist']] |> expect.exist()
  })
})

describe("When process[['GetConfigFilepath']]()",{
  it("then the filepath to the users .Renviron file should be returned.", {
    # Given
    broker  <- Path.Utility.Broker()
    service <- broker |> Path.Utility.Service()
    process <- service |> Path.Utility.Processing()

    path     <- service[['GetUserHomePath']]()
    filename <- service[['GetConfigFilename']]()

    expected.filepath <- path |> 
      service[['NormalizePath']]() |> 
      service[['CombinePath']](filename)

    # When
    actual.filepath <- process[['GetConfigFilepath']]()

    # Then
    actual.filepath |> expect.equal(expected.filepath)
  })
})