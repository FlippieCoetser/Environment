describe('Path.Processor', {
  it('Exist',{
    # Then
    Path.Processor |> expect.exist()
  })
})

describe("When processes <- Path.Processor()",{
  it("then processes should be a list.", {
    # Given
    processes <- Path.Processor()

    # Then
    processes |> expect.list()
  })
  it("then processes contains GetConfigFilepath", {
    # Given
    processes <- Path.Processor()

    # Then
    processes[['GetConfigFilepath']] |> expect.exist()
  })
  it("then processes contains EnsureFilepathExist", {
    # Given
    processes <- Path.Processor()

    # Then
    processes[['EnsureFilepathExist']] |> expect.exist()
  })
})

describe("When process[['GetConfigFilepath']]()",{
  it("then the filepath to the users .Renviron file should be returned.", {
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()
    process <- service |> Path.Processor()

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

describe("When filepath |> process[['EnsureFilepathExist']]()",{
  it("then filepath is returned",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()
    process <- service |> Path.Processor()

    path     <- service[['GetUserHomePath']]()
    filename <- 'new.file'

    input.filepath <- path |> 
      service[['NormalizePath']]() |> 
      service[['CombinePath']](filename)

    expected.filepath <- input.filepath

    # When
    actual.filepath <- input.filepath |> process[['EnsureFilepathExist']]()

    # Then
    actual.filepath |> expect.equal(expected.filepath)
  })
  it("then file created in path if not exist.", {
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()
    process <- service |> Path.Processor()

    path     <- service[['GetUserHomePath']]()
    filename <- 'new.file'

    filepath <- path |> 
      service[['NormalizePath']]() |> 
      service[['CombinePath']](filename)

    if(filepath |> service[['FilepathExists']]()) {
      filepath |> file.remove()
    }

    # When
    filepath |> process[['EnsureFilepathExist']]()

    # Then
    filepath |> service[['FilepathExists']]() |> expect.true()
  })
})