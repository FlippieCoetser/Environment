describe('Session.Utility.Service', {
  it('Exist',{
    # Then
    Session.Utility.Service |> expect.exist()
  })
})

describe("When services <- Session.Utility.Service()",{
  it("then services should be a list.", {
    # Given
    services <- Session.Utility.Service()

    # Then
    services |> expect.list()
  })
  it("then services should contain HasRStudioAPI service.", {
    # Given
    services <- Session.Utility.Service()

    # Then
    services[["HasRStudioAPI"]] |> expect.exist()
  })
  it("then services should contain HasNavigateToFile service.", {
    # Given
    services <- Session.Utility.Service()

    # Then
    services[["HasNavigateToFile"]] |> expect.exist()
  })
  it("then services should contain NavigateToFile service.", {
    # Given
    services <- Session.Utility.Service()

    # Then
    services[["NavigateToFile"]] |> expect.exist()
  })
  it("then services should contain IDEInUse service.", {
    # Given
    services <- Session.Utility.Service()

    # Then
    services[["IDEInUse"]] |> expect.exist()
  })
  it("then services should contain VSCodeInUse service.", {
    # Given
    services <- Session.Utility.Service()

    # Then
    services[["VSCodeInUse"]] |> expect.exist()
  })
  it("then services should contain GetEnvVariable service.", {
    # Given
    services <- Session.Utility.Service()

    # Then
    services[["GetEnvVariable"]] |> expect.exist()
  })
})

describe("When service[['HasRStudioAPI']]()",{
  it("then TRUE is returned if RStudioAPI is available.", {
    # Given
    broker   <- Session.Utility.Broker()
    broker[['HasRStudioAPI']] <- \() { TRUE }

    service <- broker |> Session.Utility.Service()

    # When
    result <- service[["HasRStudioAPI"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if RStudioAPI is not available.", {
    # Given
    broker   <- Session.Utility.Broker()
    broker[['HasRStudioAPI']] <- \() { FALSE }

    service <- broker |> Session.Utility.Service()

    # When
    result <- service[["HasRStudioAPI"]]()

    # Then
    result |> expect.false()
  })
})

describe("When service[['HasNavigateToFile']]()",{
  it("then TRUE is returned if navigateToFile function is available.", {
    # Given
    broker   <- Session.Utility.Broker()
    broker[['HasNavigateToFile']] <- \() { TRUE }

    service <- broker |> Session.Utility.Service()

    # When
    result <- service[["HasNavigateToFile"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if navigateToFile function is not available.", {
    # Given
    broker   <- Session.Utility.Broker()
    broker[['HasNavigateToFile']] <- \() { FALSE }

    service <- broker |> Session.Utility.Service()

    # When
    result <- service[["HasNavigateToFile"]]()

    # Then
    result |> expect.false()
  })
})

describe("When filepath |> service[['NavigateToFile']]()",{
  it("then an exception is thrown if path not found.", {
    # Given
    broker  <- Session.Utility.Broker()
    broker[['NavigateToFile']] <- \(filepath) {
      warning('path[1]="C:/Users/InvalidPath/Documents/.Renviron": The system cannot find the path specified.')
    }
    service <- broker |> Session.Utility.Service()

    expected.error <- "Path not found: C:/Users/InvalidPath/Documents/.Renviron."

    # When
    invalid.path <- "C:/Users/InvalidPath/Documents/.Renviron"

    # Then
    invalid.path |> service[["NavigateToFile"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if file not found.",{
    # Given
    broker  <- Session.Utility.Broker()
    broker[['NavigateToFile']] <- \(filepath) {
      warning('path[1]="C:/Users/Analyst/Documents/check.txt": The system cannot find the file specified.')
    }
    service <- broker |> Session.Utility.Service()

    expected.error <- "File not found: C:/Users/Analyst/Documents/check.txt."

    # When
    invalid.file <- "C:/Users/Analyst/Documents/check.txt"

    # Then
    invalid.file |> service[["NavigateToFile"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if filepath is invalid.",{
    # Given
    broker  <- Session.Utility.Broker()
    service <- broker |> Session.Utility.Service()

    input.filepath <- "C:\\Users\\username\\Documents\\.Renviron"
    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\.Renviron", ".")

    # Then
    input.filepath |> service[['NavigateToFile']]() |> expect.error(expected.error)
  })
})

describe("When service[['IDEInUse']]()",{
  it("then TRUE is returned if IDE is in use.", {
    # Given
    broker   <- Session.Utility.Broker()
    broker[['IDEInUse']] <- \() { TRUE }

    service <- broker |> Session.Utility.Service()

    # When
    result <- service[["IDEInUse"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if IDE is not in use.", {
    # Given
    broker   <- Session.Utility.Broker()
    broker[['IDEInUse']] <- \() { FALSE }

    service <- broker |> Session.Utility.Service()

    # When
    result <- service[["IDEInUse"]]()

    # Then
    result |> expect.false()
  })
})

describe("When service[['VSCodeInUse']]()",{
  it("then TRUE is returned if VS Code is in use.", {
    # Given
    broker   <- Session.Utility.Broker()
    broker[['VSCodeInUse']] <- \() { TRUE }

    service <- broker |> Session.Utility.Service()

    # When
    result <- service[["VSCodeInUse"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if VS Code is not in use.", {
    # Given
    broker   <- Session.Utility.Broker()
    broker[['VSCodeInUse']] <- \() { FALSE }

    service <- broker |> Session.Utility.Service()

    # When
    result <- service[["VSCodeInUse"]]()

    # Then
    result |> expect.false()
  })
})

describe("When name |> service[['GetEnvVariable']]()",{
  it("then the value for name is cached.", {
    # Given
    broker  <- Session.Utility.Broker()
    service <- broker |> Session.Utility.Service()

    name  <- "ENVIRONMENT"

    # When
    value <- name |> service[["GetEnvVariable"]]()

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
})