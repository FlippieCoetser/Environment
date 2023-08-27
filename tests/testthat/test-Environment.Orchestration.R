describe('Environment.Orchestration', {
  it('Exist',{
    # Then
    Environment.Orchestration |> expect.exist()
  })
})

describe("When orchestrations <- Environment.Orchestration()", {
  it("Then orchestrations should be a list", {
    # Given
    orchestrations <- Environment.Orchestration()

    # Then
    orchestrations |> expect.list()
  })
  it("then orchestrations contains OpenConfigFile orchestration", {
    # Given
    orchestrations <- Environment.Orchestration()

    # Then
    orchestrations[['OpenConfigFile']] |> expect.exist()
  })
  it("then orchestrations contains GetEnvVariable orchestration", {
    # Given
    orchestrations <- Environment.Orchestration()

    # Then
    orchestrations[['GetEnvVariable']] |> expect.exist()
  })
  it("then orchestrations contains CacheEnvVariable orchestration", {
    # Given
    orchestrations <- Environment.Orchestration()

    # Then
    orchestrations[['CacheEnvVariable']] |> expect.exist()
  })
})

describe("When orchestrate[['OpenConfigFile']]()",{
  it("Then the .Renviron opens in IDE", {
    # Given
    path <- 
      Path.Broker()  |> 
      Path.Service() |> 
      Path.Processor()

    session <- 
      Session.Broker()  |> 
      Session.Service() |> 
      Session.Processing()

    session[['OpenFilepath']] <- \(filepath) TRUE

    orchestrations <- Environment.Orchestration(path = path, session = session)

    # When
    result <- orchestrations[['OpenConfigFile']]()

    # Then
    result |> expect.true()
  })
})

describe("When name |> orchestrate[['GetEnvVariable']]()",{
  it("then the value for variable with name is returned.", {
    # Given
    orchestrate <- Environment.Orchestration()

    name  <- "ENVIRONMENT"

    # When
    value <- name |> orchestrate[["GetEnvVariable"]]()

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
  it("then an exception is thrown is name is NULL",{
    # Given
    orchestrate <- Environment.Orchestration()

    expected.error <- "Name is null. Expected a name for the environment to retrieve its value."

    # When
    name <- NULL

    # Then
    name |> orchestrate[["GetEnvVariable"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if no value for variable is found",{
    # Given
    orchestrate <- Environment.Orchestration()

    name           <- "INVALID"
    expected.error <- "No value found for provided environment variable:INVALID. Please check .Renviron configuration file."

    # Then
    name |> orchestrate[["GetEnvVariable"]]() |> expect.error(expected.error)
  })
})


describe("When name |> orchestrate[['CacheEnvVariable']](value)",{
  it("then the value of variable with name is cached.", {
    # Given
    orchestrate <- Environment.Orchestration()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    # When
    name |> orchestrate[["CacheEnvVariable"]](value)

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    orchestrate <- Environment.Orchestration()

    expected.error <- "Name is null. Expected a name for the environment to retrieve its value."

    # When
    name  <- NULL
    value <- "new_value"

    # Then
    name |> orchestrate[["CacheEnvVariable"]](value) |> expect.error(expected.error)
  })
  it("then an exception is thrown if value is NULL",{
    # Given
    orchestrate <- Environment.Orchestration()

    expected.error <- "Value is null. Expected a value for the environment to cache."

    # When
    name  <- "NEW_VARIABLE"
    value <- NULL

    # Then
    name |> orchestrate[["CacheEnvVariable"]](value) |> expect.error(expected.error)
  })
})