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
  it("then processes contains GetIDE.InUse process.", {
    # Given
    processes <- Session.Processor()

    # Then
    processes[["GetIDE.InUse"]] |> expect.exist()
  })
  it("then processes contains Open.Filepath process.", {
    # Given
    processes <- Session.Processor()

    # Then
    processes[["Open.Filepath"]] |> expect.exist()
  })
  it("then processes contains CheckIDE.InUse process.", {
    # Given
    processes <- Session.Processor()

    # Then
    processes[["CheckIDE.InUse"]] |> expect.exist()
  })
  it("then processes contains Get.Env.Variable process.", {
    # Given
    processes <- Session.Processor()

    # Then
    processes[["Get.Env.Variable"]] |> expect.exist()
  })
  it("then processes contains Cache.Env.Variable process.", {
    # Given
    processes <- Session.Processor()

    # Then
    processes[["Cache.Env.Variable"]] |> expect.exist()
  })
  it("then processes contains Clear.Env.Variable process.", {
    # Given
    processes <- Session.Processor()

    # Then
    processes[["Clear.Env.Variable"]] |> expect.exist()
  })
})

describe("When process[['GetIDE.InUse']]()",{
  it("then None is returned in no IDE is in use.", {
    # Given
    broker <- Session.Broker()
    broker[['IDE.InUse']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.result <- "None"

    # When
    result <- process[["GetIDE.InUse"]]()

    # Then
    result |> expect.equal(expected.result)
  })
  it("then RStudio is returned if RStudio is in use.", {
    # Given
    broker <- Session.Broker()
    broker[['IDE.InUse']]    <- \() TRUE
    broker[['VSCode.InUse']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.result <- "RStudio"

    # When
    result <- process[["GetIDE.InUse"]]()

    # Then
    result |> expect.equal(expected.result)
  })
  it("then VSCode is returned if VSCode is in use.", {
    # Given
    broker <- Session.Broker()
    broker[['IDE.InUse']]    <- \() TRUE
    broker[['VSCode.InUse']] <- \() TRUE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    expected.result <- "VSCode"

    # When
    result <- process[["GetIDE.InUse"]]()

    # Then
    result |> expect.equal(expected.result)
  })
})

describe("When filepath |> process[['Open.Filepath']]()",{
  it("then the filepath is opened in the IDE in use.",{
    # Given
    expected.filepath <- NULL

    broker <- Session.Broker()
    broker[['IDE.InUse']]          <- \() TRUE
    broker[['Has.RStudio.API']]     <- \() TRUE
    broker[['Has.NavigateToFilepath']] <- \() TRUE

    broker[['Navigate.To.Filepath']] <- \(filepath) {
      expected.filepath <<- filepath
    }

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    input.filepath <- "C:/Users/username/Documents/.Renviron"


    # When
    actual.filepath <- input.filepath |> process[['Open.Filepath']]()

    # Then
    actual.filepath |> expect.equal(expected.filepath)
  })
  it("then an exception is thrown if no IDE in use.",{
    # Given
    broker <- Session.Broker()
    broker[['IDE.InUse']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "No IDE in use but required."
    
    # Then
    filepath |> process[['Open.Filepath']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudio API is unavailable in RStudio.",{
    # Given
    broker <- Session.Broker()
    broker[['IDE.InUse']]          <- \() TRUE
    broker[['VSCode.InUse']]       <- \() FALSE
    broker[['Has.RStudio.API']]     <- \() FALSE
    broker[['Has.NavigateToFilepath']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "RStudio API is unavailable in RStudio."

    # Then
    filepath |> process[['Open.Filepath']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudio API is unavailable in VSCode.",{
    # Given
    broker <- Session.Broker()
    broker[['IDE.InUse']]          <- \() TRUE
    broker[['VSCode.InUse']]       <- \() TRUE
    broker[['Has.RStudio.API']]     <- \() FALSE
    broker[['Has.NavigateToFilepath']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "RStudio API is unavailable in VSCode."

    # Then
    filepath |> process[['Open.Filepath']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is unavailable in RStudio.",{
    # Given
    broker <- Session.Broker()
    broker[['IDE.InUse']]          <- \() TRUE
    broker[['VSCode.InUse']]       <- \() FALSE
    broker[['Has.RStudio.API']]     <- \() TRUE
    broker[['Has.NavigateToFilepath']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "Navigate to File function is unavailable in RStudio."

    # Then
    filepath |> process[['Open.Filepath']]() |> expect_error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is unavailable in VSCode.",{
    # Given
    broker <- Session.Broker()
    broker[['IDE.InUse']]          <- \() TRUE
    broker[['VSCode.InUse']]       <- \() TRUE
    broker[['Has.RStudio.API']]     <- \() TRUE
    broker[['Has.NavigateToFilepath']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "Navigate to File function is unavailable in VSCode."

    # Then
    filepath |> process[['Open.Filepath']]() |> expect.error(expected.error)
  })
})

describe("When ide |> process[['CheckIDE.InUse']]()",{
  it("then an exception is thrown if no IDE in use.",{
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "None"

    expected.error <- "No IDE in use but required."

    # Then
    ide |> process[['CheckIDE.InUse']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudioAPI is unavailable in RStudio.",{
    # Given
    broker <- Session.Broker()
    broker[['Has.RStudio.API']]     <- \() FALSE
    broker[['Has.NavigateToFilepath']] <- \() TRUE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "RStudio"

    expected.error <- "RStudio API is unavailable in RStudio."

    # Then
    ide |> process[['CheckIDE.InUse']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if RStudioAPI is unavailable in VSCode.",{
    # Given
    broker <- Session.Broker()
    broker[['Has.RStudio.API']]     <- \() FALSE
    broker[['Has.NavigateToFilepath']] <- \() TRUE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "VSCode"

    expected.error <- "RStudio API is unavailable in VSCode."

    # Then
    ide |> process[['CheckIDE.InUse']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is unavailable in RStudio.",{
    # Given
    broker <- Session.Broker()
    broker[['Has.RStudio.API']]     <- \() TRUE
    broker[['Has.NavigateToFilepath']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "RStudio"

    expected.error <- "Navigate to File function is unavailable in RStudio."

    # Then
    ide |> process[['CheckIDE.InUse']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if Navigate To File function is unavailable in VSCode.",{
    # Given
    broker <- Session.Broker()
    broker[['Has.RStudio.API']]     <- \() TRUE
    broker[['Has.NavigateToFilepath']] <- \() FALSE

    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    ide <- "VSCode"

    expected.error <- "Navigate to File function is unavailable in VSCode."

    # Then
    ide |> process[['CheckIDE.InUse']]() |> expect.error(expected.error)
  })
})

describe("When name |> process[['Get.Env.Variable']]()",{
  it("then the value for variable with name is returned.", {
    skip_if_not(environment == 'local')
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    name  <- "ENVIRONMENT"

    # When
    value <- name |> process[["Get.Env.Variable"]]()

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
    name |> process[["Get.Env.Variable"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if no value for variable is found",{
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    name           <- "INVALID"
    expected.error <- "No value found for provided environment variable:INVALID. Please check .Renviron configuration file."

    # Then
    name |> process[["Get.Env.Variable"]]() |> expect.error(expected.error)
  })
})

describe("When name |> service[['Cache.Env.Variable']](value)",{
  it("then the value of variable with name is cached.", {
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    # When
    name |> process[["Cache.Env.Variable"]](value)

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
    name |> process[["Cache.Env.Variable"]](value) |> expect.error(expected.error)
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
    name |> process[["Cache.Env.Variable"]](value) |> expect.error(expected.error)
  })
})

describe("When name |> service[['Clear.Env.Variable']]()",{
  it("then the value of variable with name is cleared.", {
    # Given
    broker <- Session.Broker()
    service <- broker |> Session.Service()
    process <- service |> Session.Processor()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    name |> broker[["Cache.Env.Variable"]](value)

    # When
    name |> process[["Clear.Env.Variable"]]()

    # Then
    name |> broker[['Get.Env.Variable']]() |> expect.empty()
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
    name |> process[["Clear.Env.Variable"]]() |> expect.error(expected.error)
  })
})