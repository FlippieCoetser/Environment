describe('Session.Service', {
  it('Exist',{
    Session.Service |> expect.exist()
  })
})

describe("When services <- Session.Service()",{
  it("then services is a list.", {
    # When
    services <- Session.Service()

    # Then
    services |> expect.list()
  })
  it("then services contains 'has.RStudio.api' service.", {
    # When
    services <- Session.Service()

    # Then
    services[['has.RStudio.api']] |> expect.exist()
  })
  it("then services contains 'has.navigate.to.file' service.", {
    # When
    services <- Session.Service()

    # Then
    services[['has.navigate.to.file']] |> expect.exist()
  })
  it("then services contains 'navigate.to.file' service.", {
    # When
    services <- Session.Service()

    # Then
    services[['navigate.to.file']] |> expect.exist()
  })
  it("then services contains 'IDE.active' service.", {
    # When
    services <- Session.Service()

    # Then
    services[['IDE.active']] |> expect.exist()
  })
  it("then services contains 'VSCode.active' service.", {
    # When
    services <- Session.Service()

    # Then
    services[['VSCode.active']] |> expect.exist()
  })
  it("then services contains 'get.env.variable' service.", {
    # When
    services <- Session.Service()

    # Then
    services[['get.env.variable']] |> expect.exist()
  })
  it("then services contains 'cache.env.variable' service.", {
    # When
    services <- Session.Service()

    # Then
    services[['cache.env.variable']] |> expect.exist()
  })
  it("then services contains 'clear.env.variable' service.", {
    # When
    services <- Session.Service()

    # Then
    services[['clear.env.variable']] |> expect.exist()
  })
})

describe("When service[['has.RStudio.api']]()",{
  it("then TRUE is returned if RStudioAPI is available.", {
    # Given
    broker   <- Session.Broker()
    broker[['has.RStudio.api']] <- \() TRUE

    service <- broker |> Session.Service()

    # When
    result <- service[['has.RStudio.api']]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if RStudioAPI is not available.", {
    # Given
    broker   <- Session.Broker()
    broker[['has.RStudio.api']] <- \() FALSE

    service <- broker |> Session.Service()

    # When
    result <- service[['has.RStudio.api']]()

    # Then
    result |> expect.false()
  })
})

describe("When service[['has.navigate.to.file']]()",{
  it("then TRUE is returned if navigateToFile function is available.", {
    # Given
    broker   <- Session.Broker()
    broker[['has.navigate.to.file']] <- \() TRUE

    service <- broker |> Session.Service()

    # When
    result <- service[['has.navigate.to.file']]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if navigateToFile function is not available.", {
    # Given
    broker   <- Session.Broker()
    broker[['has.navigate.to.file']] <- \() FALSE

    service <- broker |> Session.Service()

    # When
    result <- service[['has.navigate.to.file']]()

    # Then
    result |> expect.false()
  })
})

describe("When filepath |> service[['navigate.to.file']]()",{
  it("then an exception is thrown if path not found.", {
    # Given
    broker  <- Session.Broker()
    broker[['navigate.to.file']] <- \(filepath) {
      warning('path[1]="C:/Users/path.invalid/Documents/.Renviron": The system cannot find the path specified.')
    }
    service <- broker |> Session.Service()

    expected.error <- "Path not found: C:/Users/path.invalid/Documents/.Renviron."

    # When
    invalid.path <- "C:/Users/path.invalid/Documents/.Renviron"

    # Then
    invalid.path |> service[['navigate.to.file']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if file not found.",{
    # Given
    broker  <- Session.Broker()
    broker[['navigate.to.file']] <- \(filepath) {
      warning('path[1]="C:/Users/Analyst/Documents/check.txt": The system cannot find the file specified.')
    }
    service <- broker |> Session.Service()

    expected.error <- "File not found: C:/Users/Analyst/Documents/check.txt."

    # When
    invalid.file <- "C:/Users/Analyst/Documents/check.txt"

    # Then
    invalid.file |> service[['navigate.to.file']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if filepath is invalid.",{
    # Given
    service <- Session.Broker() |> Session.Service()

    input.filepath <- "C:\\Users\\username\\Documents\\.Renviron"
    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\.Renviron", ".")

    # Then
    input.filepath |> service[['navigate.to.file']]() |> expect.error(expected.error)
  })
})

describe("When service[['IDE.active']]()",{
  it("then TRUE is returned if IDE is in use.", {
    # Given
    broker   <- Session.Broker()
    broker[['IDE.active']] <- \() TRUE

    service <- broker |> Session.Service()

    # When
    result <- service[['IDE.active']]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if IDE is not in use.", {
    # Given
    broker   <- Session.Broker()
    broker[['IDE.active']] <- \() FALSE

    service <- broker |> Session.Service()

    # When
    result <- service[['IDE.active']]()

    # Then
    result |> expect.false()
  })
})

describe("When service[['VSCode.active']]()",{
  it("then TRUE is returned if VS Code is in use.", {
    # Given
    broker   <- Session.Broker()
    broker[['VSCode.active']] <- \() TRUE

    service <- broker |> Session.Service()

    # When
    result <- service[['VSCode.active']]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if VS Code is not in use.", {
    # Given
    broker   <- Session.Broker()
    broker[['VSCode.active']] <- \() FALSE

    service <- broker |> Session.Service()

    # When
    result <- service[['VSCode.active']]()

    # Then
    result |> expect.false()
  })
})

describe("When name |> service[['get.env.variable']]()",{
  it("then the value for variable with name is returned.", {
    # Given
    service <- Session.Broker() |> Session.Service()

    name  <- "VARIABLE"
    value <- "VALUE"
    
    name |> set.env.variable(value)

    expected.value <- name |> Sys.getenv()

    # When
    actual.value <- name |> service[['get.env.variable']]()

    # Then
    actual.value |> expect.equal(expected.value)
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    service <- Session.Broker() |> Session.Service()

    expected.error <- "Environment variable name is null, but required."

    # When
    name <- NULL

    # Then
    name |> service[['get.env.variable']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if no value for variable is found",{
    # Given
    service <- Session.Broker() |> Session.Service()

    name           <- "INVALID"
    expected.error <- "No value found for provided environment variable:INVALID. Please check .Renviron configuration file."

    # Then
    name |> service[['get.env.variable']]() |> expect.error(expected.error)
  })
})

describe("When name |> service[['cache.env.variable']](value)",{
  it("then the value of variable with name is cached.", {
    # Given
    service <- Session.Broker() |> Session.Service()

    name  <- "VARIABLE"
    value <- "VALUE"

    expected.value <- value

    # When
    name |> service[['cache.env.variable']](value)

    # Then
    name |> Sys.getenv() |> expect.equal(expected.value)
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    service <- Session.Broker() |> Session.Service()

    expected.error <- "Environment variable name is null, but required."

    # When
    name  <- NULL
    value <- "new_value"

    # Then
    name |> service[['cache.env.variable']](value) |> expect.error(expected.error)
  })
  it("then an exception is thrown if value is NULL",{
    # Given
    service <- Session.Broker() |> Session.Service()

    expected.error <- "Value is null. Expected a value for the environment to cache."

    # When
    name  <- "NEW_VARIABLE"
    value <- NULL

    # Then
    name |> service[['cache.env.variable']](value) |> expect.error(expected.error)
  })
})

describe("When name |> service[['clear.env.variable']]()",{
  it("then the value of variable with name is cleared.", {
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    name  <- "VARIABLE"
    value <- "VALUE"

    name |> broker[['cache.env.variable']](value)

    # When
    name |> service[['clear.env.variable']]()

    # Then
    name |> broker[['get.env.variable']]() |> expect.empty()
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    service <-  Session.Broker() |> Session.Service()

    expected.error <- "Environment variable name is null, but required."

    # When
    name <- NULL

    # Then
    name |> service[['clear.env.variable']]() |> expect.error(expected.error)
  })
})