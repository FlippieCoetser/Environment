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
  it("then orchestrations contains 'Open.Config.File' orchestration", {
    # When
    orchestrations <- Environment.Orchestrator()

    # Then
    orchestrations[['Open.Config.File']] |> expect.exist()
  })
  it("then orchestrations contains 'Get.Env.Variable' orchestration", {
    # When
    orchestrations <- Environment.Orchestrator()

    # Then
    orchestrations[['Get.Env.Variable']] |> expect.exist()
  })
  it("then orchestrations contains 'Cache.Env.Variable' orchestration", {
    # When
    orchestrations <- Environment.Orchestrator()

    # Then
    orchestrations[['Cache.Env.Variable']] |> expect.exist()
  })
  it("then orchestrations contains 'Clear.Env.Variable' orchestration",{
    # When
    orchestrations <- Environment.Orchestrator()

    # Then
    orchestrations[['Clear.Env.Variable']] |> expect.exist()
  })
})

describe("When orchestrate[['Open.Config.File']]()",{
  it("Then the .Renviron configuration file opens in IDE", {
    # Given
    path <- 
      Path.Broker()  |> 
      Path.Service() |> 
      Path.Processor()

    session <- 
      Session.Broker()  |> 
      Session.Service() |> 
      Session.Processor()

    session[['Open.Filepath']] <- \(filepath) TRUE

    orchestrations <- Environment.Orchestrator(path = path, session = session)

    # When
    result <- orchestrations[['Open.Config.File']]()

    # Then
    result |> expect.true()
  })
})

describe("When name |> orchestrate[['Get.Env.Variable']]()",{
  it("then the value for variable with name is returned.", {
    skip_if_not(environment == 'local')
    # Given
    orchestrate <- Environment.Orchestrator()

    name  <- "ENVIRONMENT"

    # When
    value <- name |> orchestrate[['Get.Env.Variable']]()

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
    name |> orchestrate[['Get.Env.Variable']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if no value for variable is found",{
    # Given
    orchestrate <- Environment.Orchestrator()

    name           <- "INVALID"
    expected.error <- "No value found for provided environment variable:INVALID. Please check .Renviron configuration file."

    # Then
    name |> orchestrate[['Get.Env.Variable']]() |> expect.error(expected.error)
  })
})

describe("When name |> orchestrate[['Cache.Env.Variable']](value)",{
  it("then the value of variable with name is cached.", {
    # Given
    orchestrate <- Environment.Orchestrator()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    # When
    name |> orchestrate[['Cache.Env.Variable']](value)

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
    name |> orchestrate[['Cache.Env.Variable']](value) |> expect.error(expected.error)
  })
  it("then an exception is thrown if value is NULL",{
    # Given
    orchestrate <- Environment.Orchestrator()

    expected.error <- "Value is null. Expected a value for the environment to cache."

    # When
    name  <- "NEW_VARIABLE"
    value <- NULL

    # Then
    name |> orchestrate[['Cache.Env.Variable']](value) |> expect.error(expected.error)
  })
})

describe("When name |> orchestrate[['Clear.Env.Variable']]()",{
  it("then the value of variable with name is cleared.", {
    # Given
    orchestrate <- Environment.Orchestrator()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    name |> orchestrate[['Cache.Env.Variable']](value)

    # When
    name |> orchestrate[['Clear.Env.Variable']]()

    # Then
    name |> orchestrate[['Get.Env.Variable']]() |> expect.error(NULL)
  })
  it("then an exception is thrown when name is NULL",{
    # Given
    orchestrate <- Environment.Orchestrator()

    expected.error <- "Environment variable name is null, but required."

    # When
    name <- NULL

    # Then
    name |> orchestrate[['Clear.Env.Variable']]() |> expect.error(expected.error)
  })
})