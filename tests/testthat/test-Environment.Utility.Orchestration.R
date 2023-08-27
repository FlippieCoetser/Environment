describe('Environment.Utility.Orchestration', {
  it('Exist',{
    # Then
    Environment.Utility.Orchestration |> expect.exist()
  })
})

describe("When orchestrations <- Environment.Utility.Orchestration()", {
  it("Then orchestrations should be a list", {
    # Given
    orchestrations <- Environment.Utility.Orchestration()

    # Then
    orchestrations |> expect.list()
  })
  it("then orchestrations contains OpenConfigFile orchestration", {
    # Given
    orchestrations <- Environment.Utility.Orchestration()

    # Then
    orchestrations[['OpenConfigFile']] |> expect.exist()
  })
  it("then orchestrations contains GetEnvVariable orchestration", {
    # Given
    orchestrations <- Environment.Utility.Orchestration()

    # Then
    orchestrations[['GetEnvVariable']] |> expect.exist()
  })
})

describe("When orchestrate[['OpenConfigFile']]()",{
  it("Then the .Renviron opens in IDE", {
    # Given
    path <- 
      Path.Utility.Broker()  |> 
      Path.Utility.Service() |> 
      Path.Utility.Processing()

    session <- 
      Session.Utility.Broker()  |> 
      Session.Utility.Service() |> 
      Session.Utility.Processing()

    session[['OpenFilepath']] <- \(filepath) TRUE

    orchestrations <- Environment.Utility.Orchestration(path = path, session = session)

    # When
    result <- orchestrations[['OpenConfigFile']]()

    # Then
    result |> expect.true()
  })
})