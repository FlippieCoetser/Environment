describe("Session.Processor",{
  it("Exist",{
     Session.Processor |> expect.exist()
  })
})

describe("When processes <- Session.Processor()",{
  it("then processes is a list.", {
    # When
    processes <- Session.Processor()

    # Then
    processes |> expect.list()
  })
  it("then processes contains 'get.active.IDE' process.", {
    # When
    processes <- Session.Processor()

    # Then
    processes[['get.active.IDE']] |> expect.exist()
  })
  it("then processes contains 'open.filepath' process.", {
    # When
    processes <- Session.Processor()

    # Then
    processes[['open.filepath']] |> expect.exist()
  })
  it("then processes contains 'check.active.IDE' process.", {
    # When
    processes <- Session.Processor()

    # Then
    processes[['check.active.IDE']] |> expect.exist()
  })
  it("then processes contains 'get.env.variable' process.", {
    # When
    processes <- Session.Processor()

    # Then
    processes[['get.env.variable']] |> expect.exist()
  })
  it("then processes contains 'cache.env.variable' process.", {
    # When
    processes <- Session.Processor()

    # Then
    processes[['cache.env.variable']] |> expect.exist()
  })
  it("then processes contains 'clear.env.variable' process.", {
    # When
    processes <- Session.Processor()

    # Then
    processes[['clear.env.variable']] |> expect.exist()
  })
})

describe("When process[['get.active.IDE']]()",{
  it("then None is returned in no IDE is in use.", {
    # Given
    broker <- Session.Broker()
    broker[['IDE.active']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.result <- "None"

    # When
    result <- process[['get.active.IDE']]()

    # Then
    result |> expect.equal(expected.result)
  })
  it("then RStudio is returned if RStudio is in use.", {
    # Given
    broker <- Session.Broker()
    broker[['IDE.active']]    <- \() TRUE
    broker[['VSCode.active']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.result <- "RStudio"

    # When
    result <- process[['get.active.IDE']]()

    # Then
    result |> expect.equal(expected.result)
  })
  it("then VSCode is returned if VSCode is in use.", {
    # Given
    broker <- Session.Broker()
    broker[['IDE.active']]    <- \() TRUE
    broker[['VSCode.active']] <- \() TRUE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.result <- "VSCode"

    # When
    result <- process[['get.active.IDE']]()

    # Then
    result |> expect.equal(expected.result)
  })
})

describe("When filepath |> process[['open.filepath']]()",{
  it("then the filepath is opened in the IDE in use.",{
    # Given
    expected.filepath <- NULL

    broker <- Session.Broker()
    broker[['IDE.active']]          <- \() TRUE
    broker[['has.RStudio.api']]     <- \() TRUE
    broker[['has.navigate.to.file']] <- \() TRUE

    broker[['navigate.to.file']] <- \(filepath) {
      expected.filepath <<- filepath
    }

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    input.filepath <- "C:/Users/username/Documents/.Renviron"


    # When
    actual.filepath <- input.filepath |> process[['open.filepath']]()

    # Then
    actual.filepath |> expect.equal(expected.filepath)
  })
  it("then an exception is thrown if no IDE in use.",{
    # Given
    broker <- Session.Broker()
    broker[['IDE.active']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "No IDE in use but required."
    
    # Then
    filepath |> process[['open.filepath']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudio API is unavailable in RStudio.",{
    # Given
    broker <- Session.Broker()
    broker[['IDE.active']]          <- \() TRUE
    broker[['VSCode.active']]       <- \() FALSE
    broker[['has.RStudio.api']]     <- \() FALSE
    broker[['has.navigate.to.file']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "RStudio API is unavailable in RStudio."

    # Then
    filepath |> process[['open.filepath']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudio API is unavailable in VSCode.",{
    # Given
    broker <- Session.Broker()
    broker[['IDE.active']]          <- \() TRUE
    broker[['VSCode.active']]       <- \() TRUE
    broker[['has.RStudio.api']]     <- \() FALSE
    broker[['has.navigate.to.file']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "RStudio API is unavailable in VSCode."

    # Then
    filepath |> process[['open.filepath']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is unavailable in RStudio.",{
    # Given
    broker <- Session.Broker()
    broker[['IDE.active']]          <- \() TRUE
    broker[['VSCode.active']]       <- \() FALSE
    broker[['has.RStudio.api']]     <- \() TRUE
    broker[['has.navigate.to.file']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "Navigate to File function is unavailable in RStudio."

    # Then
    filepath |> process[['open.filepath']]() |> expect_error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is unavailable in VSCode.",{
    # Given
    broker <- Session.Broker()
    broker[['IDE.active']]          <- \() TRUE
    broker[['VSCode.active']]       <- \() TRUE
    broker[['has.RStudio.api']]     <- \() TRUE
    broker[['has.navigate.to.file']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "Navigate to File function is unavailable in VSCode."

    # Then
    filepath |> process[['open.filepath']]() |> expect.error(expected.error)
  })
})

describe("When ide |> process[['check.active.IDE']]()",{
  it("then an exception is thrown if no IDE in use.",{
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "None"

    expected.error <- "No IDE in use but required."

    # Then
    ide |> process[['check.active.IDE']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudioAPI is unavailable in RStudio.",{
    # Given
    broker <- Session.Broker()
    broker[['has.RStudio.api']]     <- \() FALSE
    broker[['has.navigate.to.file']] <- \() TRUE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "RStudio"

    expected.error <- "RStudio API is unavailable in RStudio."

    # Then
    ide |> process[['check.active.IDE']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudioAPI is unavailable in VSCode.",{
    # Given
    broker <- Session.Broker()
    broker[['has.RStudio.api']]     <- \() FALSE
    broker[['has.navigate.to.file']] <- \() TRUE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "VSCode"

    expected.error <- "RStudio API is unavailable in VSCode."

    # Then
    ide |> process[['check.active.IDE']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is unavailable in RStudio.",{
    # Given
    broker <- Session.Broker()
    broker[['has.RStudio.api']]     <- \() TRUE
    broker[['has.navigate.to.file']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "RStudio"

    expected.error <- "Navigate to File function is unavailable in RStudio."

    # Then
    ide |> process[['check.active.IDE']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is unavailable in VSCode.",{
    # Given
    broker <- Session.Broker()
    broker[['has.RStudio.api']]     <- \() TRUE
    broker[['has.navigate.to.file']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "VSCode"

    expected.error <- "Navigate to File function is unavailable in VSCode."

    # Then
    ide |> process[['check.active.IDE']]() |> expect.error(expected.error)
  })
})

describe("When name |> process[['get.env.variable']]()",{
  it("then the value for variable with name is returned.", {
    skip_if_not(environment == 'local')
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    name  <- "ENVIRONMENT"

    # When
    value <- name |> process[['get.env.variable']]()

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
  it("then an exception is thrown is name is NULL",{
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.error <- "Environment variable name is null, but required."

    # When
    name <- NULL

    # Then
    name |> process[['get.env.variable']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if no value for variable is found",{
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    name           <- "INVALID"
    expected.error <- "No value found for provided environment variable:INVALID. Please check .Renviron configuration file."

    # Then
    name |> process[['get.env.variable']]() |> expect.error(expected.error)
  })
})

describe("When name |> service[['cache.env.variable']](value)",{
  it("then the value of variable with name is cached.", {
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    # When
    name |> process[['cache.env.variable']](value)

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.error <- "Environment variable name is null, but required."

    # When
    name  <- NULL
    value <- "new_value"

    # Then
    name |> process[['cache.env.variable']](value) |> expect.error(expected.error)
  })
  it("then an exception is thrown if value is NULL",{
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.error <- "Value is null. Expected a value for the environment to cache."

    # When
    name  <- "NEW_VARIABLE"
    value <- NULL

    # Then
    name |> process[['cache.env.variable']](value) |> expect.error(expected.error)
  })
})

describe("When name |> service[['clear.env.variable']]()",{
  it("then the value of variable with name is cleared.", {
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    name |> broker[['cache.env.variable']](value)

    # When
    name |> process[['clear.env.variable']]()

    # Then
    name |> broker[['get.env.variable']]() |> expect.empty()
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.error <- "Environment variable name is null, but required."

    # When
    name  <- NULL

    # Then
    name |> process[['clear.env.variable']]() |> expect.error(expected.error)
  })
})