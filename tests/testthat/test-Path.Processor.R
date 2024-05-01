describe('Path.Processor', {
  it('Exist',{
    Path.Processor |> expect.exist()
  })
})

describe("When processes <- Path.Processor()",{
  it("then processes is a list.", {
    # When
    processes <- Path.Processor()

    # Then
    processes |> expect.list()
  })
  it("then processes contains 'get.config.filepath' process.", {
    # When
    processes <- Path.Processor()

    # Then
    processes[['get.config.filepath']] |> expect.exist()
  })
  it("then processes contains 'ensure.filepath.exist' process.", {
    # When
    processes <- Path.Processor()

    # Then
    processes[['ensure.filepath.exist']] |> expect.exist()
  })
})

describe("When process[['get.config.filepath']]()",{
  it("then the filepath to the users .Renviron file is returned.", {
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()
    process <- service |> Path.Processor()

    path     <- service[['get.user.path']]()
    filename <- service[['get.config.filename']]()

    expected.filepath <- path |> 
      service[['normalize.path']]() |> 
      service[['combine.path']](filename)

    # When
    actual.filepath <- process[['get.config.filepath']]()

    # Then
    actual.filepath |> expect.equal(expected.filepath)
  })
})

describe("When filepath |> process[['ensure.filepath.exist']]()",{
  it("then filepath is returned",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()
    process <- service |> Path.Processor()

    path     <- service[['get.user.path']]()
    filename <- 'new.file'

    input.filepath <- path |> 
      service[['normalize.path']]() |> 
      service[['combine.path']](filename)

    expected.filepath <- input.filepath

    # When
    actual.filepath <- input.filepath |> process[['ensure.filepath.exist']]()

    # Then
    actual.filepath |> expect.equal(expected.filepath)
  })
  it("then a file is created in path if not exist.", {
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()
    process <- service |> Path.Processor()

    path     <- service[['get.user.path']]()
    filename <- 'new.file'

    filepath <- path |> 
      service[['normalize.path']]() |> 
      service[['combine.path']](filename)

    if(filepath |> service[['filepath.exists']]()) {
      filepath |> file.remove()
    }

    # When
    filepath |> process[['ensure.filepath.exist']]()

    # Then
    filepath |> service[['filepath.exists']]() |> expect.true()
  })
})