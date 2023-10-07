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
  it("then processes contains 'Get.Config.Filepath' process.", {
    # When
    processes <- Path.Processor()

    # Then
    processes[['Get.Config.Filepath']] |> expect.exist()
  })
  it("then processes contains 'Ensure.Filepath.Exist' process.", {
    # When
    processes <- Path.Processor()

    # Then
    processes[['Ensure.Filepath.Exist']] |> expect.exist()
  })
})

describe("When process[['Get.Config.Filepath']]()",{
  it("then the filepath to the users .Renviron file is returned.", {
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()
    process <- service |> Path.Processor()

    path     <- service[['Get.User.Path']]()
    filename <- service[['Get.Config.Filename']]()

    expected.filepath <- path |> 
      service[['Normalize.Path']]() |> 
      service[['Combine.Path']](filename)

    # When
    actual.filepath <- process[['Get.Config.Filepath']]()

    # Then
    actual.filepath |> expect.equal(expected.filepath)
  })
})

describe("When filepath |> process[['Ensure.Filepath.Exist']]()",{
  it("then filepath is returned",{
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()
    process <- service |> Path.Processor()

    path     <- service[['Get.User.Path']]()
    filename <- 'new.file'

    input.filepath <- path |> 
      service[['Normalize.Path']]() |> 
      service[['Combine.Path']](filename)

    expected.filepath <- input.filepath

    # When
    actual.filepath <- input.filepath |> process[['Ensure.Filepath.Exist']]()

    # Then
    actual.filepath |> expect.equal(expected.filepath)
  })
  it("then a file is created in path if not exist.", {
    # Given
    broker  <- Path.Broker()
    service <- broker |> Path.Service()
    process <- service |> Path.Processor()

    path     <- service[['Get.User.Path']]()
    filename <- 'new.file'

    filepath <- path |> 
      service[['Normalize.Path']]() |> 
      service[['Combine.Path']](filename)

    if(filepath |> service[['Filepath.Exists']]()) {
      filepath |> file.remove()
    }

    # When
    filepath |> process[['Ensure.Filepath.Exist']]()

    # Then
    filepath |> service[['Filepath.Exists']]() |> expect.true()
  })
})