describe('Environment.Orchestrator', {
  it('Exist',{
    Environment.Orchestrator |> expect.exist()
  })
})

describe("When orchestrations <- Environment.Orchestrator()", {
  it("Then orchestrations is a list", {
    # When
    orchestrations <- Environment.Orchestrator()

    # Then
    orchestrations |> expect.list()
  })
  it("then orchestrations contains 'open.config.file' orchestration", {
    # When
    orchestrations <- Environment.Orchestrator()

    # Then
    orchestrations[['open.config.file']] |> expect.exist()
  })
  it("then orchestrations contains 'get.env.variable' orchestration", {
    # When
    orchestrations <- Environment.Orchestrator()

    # Then
    orchestrations[['get.env.variable']] |> expect.exist()
  })
  it("then orchestrations contains 'cache.env.variable' orchestration", {
    # When
    orchestrations <- Environment.Orchestrator()

    # Then
    orchestrations[['cache.env.variable']] |> expect.exist()
  })
  it("then orchestrations contains 'clear.env.variable' orchestration",{
    # When
    orchestrations <- Environment.Orchestrator()

    # Then
    orchestrations[['clear.env.variable']] |> expect.exist()
  })
})

describe("When name |> orchestrate[['get.env.variable']]()",{
  it("then the value for variable with name is returned.", {
    skip_if_not(environment == 'local')
    # Given
    orchestrate <- Environment.Orchestrator()

    name  <- "ENVIRONMENT"

    # When
    value <- name |> orchestrate[['get.env.variable']]()

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    orchestrate <- Environment.Orchestrator()

    expected.error <- "Environment variable name is null, but required."

    # When
    name <- NULL

    # Then
    name |> orchestrate[['get.env.variable']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if no value for variable is found",{
    # Given
    orchestrate <- Environment.Orchestrator()

    name           <- "INVALID"
    expected.error <- "No value found for provided environment variable:INVALID. Please check .Renviron configuration file."

    # Then
    name |> orchestrate[['get.env.variable']]() |> expect.error(expected.error)
  })
})

describe("When name |> orchestrate[['cache.env.variable']](value)",{
  it("then the value of variable with name is cached.", {
    # Given
    orchestrate <- Environment.Orchestrator()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    # When
    name |> orchestrate[['cache.env.variable']](value)

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    orchestrate <- Environment.Orchestrator()

    expected.error <- "Environment variable name is null, but required."

    # When
    name  <- NULL
    value <- "new_value"

    # Then
    name |> orchestrate[['cache.env.variable']](value) |> expect.error(expected.error)
  })
  it("then an exception is thrown if value is NULL",{
    # Given
    orchestrate <- Environment.Orchestrator()

    expected.error <- "Value is null. Expected a value for the environment to cache."

    # When
    name  <- "NEW_VARIABLE"
    value <- NULL

    # Then
    name |> orchestrate[['cache.env.variable']](value) |> expect.error(expected.error)
  })
})

describe("When name |> orchestrate[['clear.env.variable']]()",{
  it("then the value of variable with name is cleared.", {
    # Given
    orchestrate <- Environment.Orchestrator()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    name |> orchestrate[['cache.env.variable']](value)

    # When
    name |> orchestrate[['clear.env.variable']]()

    # Then
    name |> orchestrate[['get.env.variable']]() |> expect.error(NULL)
  })
  it("then an exception is thrown when name is NULL",{
    # Given
    orchestrate <- Environment.Orchestrator()

    expected.error <- "Environment variable name is null, but required."

    # When
    name <- NULL

    # Then
    name |> orchestrate[['clear.env.variable']]() |> expect.error(expected.error)
  })
})