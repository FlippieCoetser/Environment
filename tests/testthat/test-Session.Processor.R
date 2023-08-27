describe("Session.Processor",{
  it("Exist",{
     Session.Processor |> expect.exist()
  })
})

describe("When processes <- Session.Processor()",{
  it("then processes is a list.", {
    # Given
    processes <- Session.Processor()

    # Then
    processes |> expect.list()
  })
  it("then processes contains GetIDEInUse process.", {
    # Given
    processes <- Session.Processor()

    # Then
    processes[["GetIDEInUse"]] |> expect.exist()
  })
  it("then processes contains OpenFilepath process.", {
    # Given
    processes <- Session.Processor()

    # Then
    processes[["OpenFilepath"]] |> expect.exist()
  })
  it("then processes contains CheckIDEInUse process.", {
    # Given
    processes <- Session.Processor()

    # Then
    processes[["CheckIDEInUse"]] |> expect.exist()
  })
  it("then processes contains GetEnvVariable process.", {
    # Given
    processes <- Session.Processor()

    # Then
    processes[["GetEnvVariable"]] |> expect.exist()
  })
  it("then processes contains CacheEnvVariable process.", {
    # Given
    processes <- Session.Processor()

    # Then
    processes[["CacheEnvVariable"]] |> expect.exist()
  })
})

describe("When process[['GetIDEInUse']]()",{
  it("then None is returned in no IDE is in use.", {
    # Given
    broker <- Session.Broker()
    broker[['IDEInUse']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.result <- "None"

    # When
    result <- process[["GetIDEInUse"]]()

    # Then
    result |> expect.equal(expected.result)
  })
  it("then RStudio is returned if RStudio is in use.", {
    # Given
    broker <- Session.Broker()
    broker[['IDEInUse']]    <- \() TRUE
    broker[['VSCodeInUse']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.result <- "RStudio"

    # When
    result <- process[["GetIDEInUse"]]()

    # Then
    result |> expect.equal(expected.result)
  })
  it("then VSCode is returned if VSCode is in use.", {
    # Given
    broker <- Session.Broker()
    broker[['IDEInUse']]    <- \() TRUE
    broker[['VSCodeInUse']] <- \() TRUE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.result <- "VSCode"

    # When
    result <- process[["GetIDEInUse"]]()

    # Then
    result |> expect.equal(expected.result)
  })
})

describe("When filepath |> process[['OpenFilepath']]()",{
  it("then the filepath is opened in the IDE in use.",{
    # Given
    expected.filepath <- NULL

    broker <- Session.Broker()
    broker[['IDEInUse']]          <- \() TRUE
    broker[['HasRStudioAPI']]     <- \() TRUE
    broker[['HasNavigateToFile']] <- \() TRUE

    broker[['NavigateToFile']] <- \(filepath) {
      expected.filepath <<- filepath
    }

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    input.filepath <- "C:/Users/username/Documents/.Renviron"


    # When
    actual.filepath <- input.filepath |> process[['OpenFilepath']]()

    # Then
    actual.filepath |> expect.equal(expected.filepath)
  })
  it("then an exception is thrown if no IDE in use.",{
    # Given
    broker <- Session.Broker()
    broker[['IDEInUse']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "No IDE in use but required."
    
    # Then
    filepath |> process[['OpenFilepath']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudio API is unavailable in RStudio.",{
    # Given
    broker <- Session.Broker()
    broker[['IDEInUse']]          <- \() TRUE
    broker[['VSCodeInUse']]       <- \() FALSE
    broker[['HasRStudioAPI']]     <- \() FALSE
    broker[['HasNavigateToFile']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "RStudio API is unavailable in RStudio."

    # Then
    filepath |> process[['OpenFilepath']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudio API is unavailable in VSCode.",{
    # Given
    broker <- Session.Broker()
    broker[['IDEInUse']]          <- \() TRUE
    broker[['VSCodeInUse']]       <- \() TRUE
    broker[['HasRStudioAPI']]     <- \() FALSE
    broker[['HasNavigateToFile']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "RStudio API is unavailable in VSCode."

    # Then
    filepath |> process[['OpenFilepath']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is unavailable in RStudio.",{
    # Given
    broker <- Session.Broker()
    broker[['IDEInUse']]          <- \() TRUE
    broker[['VSCodeInUse']]       <- \() FALSE
    broker[['HasRStudioAPI']]     <- \() TRUE
    broker[['HasNavigateToFile']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "Navigate to File function is unavailable in RStudio."

    # Then
    filepath |> process[['OpenFilepath']]() |> expect_error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is unavailable in VSCode.",{
    # Given
    broker <- Session.Broker()
    broker[['IDEInUse']]          <- \() TRUE
    broker[['VSCodeInUse']]       <- \() TRUE
    broker[['HasRStudioAPI']]     <- \() TRUE
    broker[['HasNavigateToFile']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "Navigate to File function is unavailable in VSCode."

    # Then
    filepath |> process[['OpenFilepath']]() |> expect.error(expected.error)
  })
})

describe("When ide |> process[['CheckIDEInUse']]()",{
  it("then an exception is thrown if no IDE in use.",{
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "None"

    expected.error <- "No IDE in use but required."

    # Then
    ide |> process[['CheckIDEInUse']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudioAPI is unavailable in RStudio.",{
    # Given
    broker <- Session.Broker()
    broker[['HasRStudioAPI']]     <- \() FALSE
    broker[['HasNavigateToFile']] <- \() TRUE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "RStudio"

    expected.error <- "RStudio API is unavailable in RStudio."

    # Then
    ide |> process[['CheckIDEInUse']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudioAPI is unavailable in VSCode.",{
    # Given
    broker <- Session.Broker()
    broker[['HasRStudioAPI']]     <- \() FALSE
    broker[['HasNavigateToFile']] <- \() TRUE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "VSCode"

    expected.error <- "RStudio API is unavailable in VSCode."

    # Then
    ide |> process[['CheckIDEInUse']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is unavailable in RStudio.",{
    # Given
    broker <- Session.Broker()
    broker[['HasRStudioAPI']]     <- \() TRUE
    broker[['HasNavigateToFile']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "RStudio"

    expected.error <- "Navigate to File function is unavailable in RStudio."

    # Then
    ide |> process[['CheckIDEInUse']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is unavailable in VSCode.",{
    # Given
    broker <- Session.Broker()
    broker[['HasRStudioAPI']]     <- \() TRUE
    broker[['HasNavigateToFile']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "VSCode"

    expected.error <- "Navigate to File function is unavailable in VSCode."

    # Then
    ide |> process[['CheckIDEInUse']]() |> expect.error(expected.error)
  })
})

describe("When name |> process[['GetEnvVariable']]()",{
  it("then the value for variable with name is returned.", {
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    name  <- "ENVIRONMENT"

    # When
    value <- name |> process[["GetEnvVariable"]]()

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
  it("then an exception is thrown is name is NULL",{
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.error <- "Name is null. Expected a name for the environment to retrieve its value."

    # When
    name <- NULL

    # Then
    name |> process[["GetEnvVariable"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if no value for variable is found",{
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    name           <- "INVALID"
    expected.error <- "No value found for provided environment variable:INVALID. Please check .Renviron configuration file."

    # Then
    name |> process[["GetEnvVariable"]]() |> expect.error(expected.error)
  })
})

describe("When name |> service[['CacheEnvVariable']](value)",{
  it("then the value of variable with name is cached.", {
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    # When
    name |> process[["CacheEnvVariable"]](value)

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.error <- "Name is null. Expected a name for the environment to retrieve its value."

    # When
    name  <- NULL
    value <- "new_value"

    # Then
    name |> process[["CacheEnvVariable"]](value) |> expect.error(expected.error)
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
    name |> process[["CacheEnvVariable"]](value) |> expect.error(expected.error)
  })
})