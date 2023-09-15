describe('Session.Service', {
  it('Exist',{
    # Then
    Session.Service |> expect.exist()
  })
})

describe("When services <- Session.Service()",{
  it("then services is a list.", {
    # Given
    services <- Session.Service()

    # Then
    services |> expect.list()
  })
  it("then services contains HasRStudioAPI service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["HasRStudioAPI"]] |> expect.exist()
  })
  it("then services contains HasNavigateToFile service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["HasNavigateToFile"]] |> expect.exist()
  })
  it("then services contains NavigateToFile service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["NavigateToFile"]] |> expect.exist()
  })
  it("then services contains IDEInUse service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["IDEInUse"]] |> expect.exist()
  })
  it("then services contains VSCodeInUse service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["VSCodeInUse"]] |> expect.exist()
  })
  it("then services contains GetEnvVariable service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["GetEnvVariable"]] |> expect.exist()
  })
  it("then services contains CacheEnvVariable service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["CacheEnvVariable"]] |> expect.exist()
  })
  it("then services contains ClearEnvVariable service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["ClearEnvVariable"]] |> expect.exist()
  })
})

describe("When service[['HasRStudioAPI']]()",{
  it("then TRUE is returned if RStudioAPI is available.", {
    # Given
    broker   <- Session.Broker()
    broker[['HasRStudioAPI']] <- \() { TRUE }

    service <- broker |> Session.Service()

    # When
    result <- service[["HasRStudioAPI"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if RStudioAPI is not available.", {
    # Given
    broker   <- Session.Broker()
    broker[['HasRStudioAPI']] <- \() { FALSE }

    service <- broker |> Session.Service()

    # When
    result <- service[["HasRStudioAPI"]]()

    # Then
    result |> expect.false()
  })
})

describe("When service[['HasNavigateToFile']]()",{
  it("then TRUE is returned if navigateToFile function is available.", {
    # Given
    broker   <- Session.Broker()
    broker[['HasNavigateToFile']] <- \() { TRUE }

    service <- broker |> Session.Service()

    # When
    result <- service[["HasNavigateToFile"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if navigateToFile function is not available.", {
    # Given
    broker   <- Session.Broker()
    broker[['HasNavigateToFile']] <- \() { FALSE }

    service <- broker |> Session.Service()

    # When
    result <- service[["HasNavigateToFile"]]()

    # Then
    result |> expect.false()
  })
})

describe("When filepath |> service[['NavigateToFile']]()",{
  it("then an exception is thrown if path not found.", {
    # Given
    broker  <- Session.Broker()
    broker[['NavigateToFile']] <- \(filepath) {
      warning('path[1]="C:/Users/InvalidPath/Documents/.Renviron": The system cannot find the path specified.')
    }
    service <- broker |> Session.Service()

    expected.error <- "Path not found: C:/Users/InvalidPath/Documents/.Renviron."

    # When
    invalid.path <- "C:/Users/InvalidPath/Documents/.Renviron"

    # Then
    invalid.path |> service[["NavigateToFile"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if file not found.",{
    # Given
    broker  <- Session.Broker()
    broker[['NavigateToFile']] <- \(filepath) {
      warning('path[1]="C:/Users/Analyst/Documents/check.txt": The system cannot find the file specified.')
    }
    service <- broker |> Session.Service()

    expected.error <- "File not found: C:/Users/Analyst/Documents/check.txt."

    # When
    invalid.file <- "C:/Users/Analyst/Documents/check.txt"

    # Then
    invalid.file |> service[["NavigateToFile"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if filepath is invalid.",{
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    input.filepath <- "C:\\Users\\username\\Documents\\.Renviron"
    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\.Renviron", ".")

    # Then
    input.filepath |> service[['NavigateToFile']]() |> expect.error(expected.error)
  })
})

describe("When service[['IDEInUse']]()",{
  it("then TRUE is returned if IDE is in use.", {
    # Given
    broker   <- Session.Broker()
    broker[['IDEInUse']] <- \() { TRUE }

    service <- broker |> Session.Service()

    # When
    result <- service[["IDEInUse"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if IDE is not in use.", {
    # Given
    broker   <- Session.Broker()
    broker[['IDEInUse']] <- \() { FALSE }

    service <- broker |> Session.Service()

    # When
    result <- service[["IDEInUse"]]()

    # Then
    result |> expect.false()
  })
})

describe("When service[['VSCodeInUse']]()",{
  it("then TRUE is returned if VS Code is in use.", {
    # Given
    broker   <- Session.Broker()
    broker[['VSCodeInUse']] <- \() { TRUE }

    service <- broker |> Session.Service()

    # When
    result <- service[["VSCodeInUse"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if VS Code is not in use.", {
    # Given
    broker   <- Session.Broker()
    broker[['VSCodeInUse']] <- \() { FALSE }

    service <- broker |> Session.Service()

    # When
    result <- service[["VSCodeInUse"]]()

    # Then
    result |> expect.false()
  })
})

describe("When name |> service[['GetEnvVariable']]()",{
  it("then the value for variable with name is returned.", {
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    name  <- "ENVIRONMENT"

    # When
    value <- name |> service[["GetEnvVariable"]]()

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    expected.error <- "Name is null. Expected a name for the environment to retrieve its value."

    # When
    name <- NULL

    # Then
    name |> service[["GetEnvVariable"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if no value for variable is found",{
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    name           <- "INVALID"
    expected.error <- "No value found for provided environment variable:INVALID. Please check .Renviron configuration file."

    # Then
    name |> service[["GetEnvVariable"]]() |> expect.error(expected.error)
  })
})

describe("When name |> service[['CacheEnvVariable']](value)",{
  it("then the value of variable with name is cached.", {
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    # When
    name |> service[["CacheEnvVariable"]](value)

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    expected.error <- "Name is null. Expected a name for the environment to retrieve its value."

    # When
    name  <- NULL
    value <- "new_value"

    # Then
    name |> service[["CacheEnvVariable"]](value) |> expect.error(expected.error)
  })
  it("then an exception is thrown if value is NULL",{
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    expected.error <- "Value is null. Expected a value for the environment to cache."

    # When
    name  <- "NEW_VARIABLE"
    value <- NULL

    # Then
    name |> service[["CacheEnvVariable"]](value) |> expect.error(expected.error)
  })
})

describe("When name |> service[['ClearEnvVariable']]()",{
  it("then the value of variable with name is cleared.", {
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    name |> broker[["CacheEnvVariable"]](value)

    # When
    name |> service[["ClearEnvVariable"]]()

    # Then
    name |> broker[['GetEnvVariable']]() |> expect.empty()
  })
})