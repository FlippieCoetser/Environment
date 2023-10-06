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
  it("then services contains Has.RStudio.API service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["Has.RStudio.API"]] |> expect.exist()
  })
  it("then services contains Has.NavigateToFilepath service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["Has.NavigateToFilepath"]] |> expect.exist()
  })
  it("then services contains Navigate.To.Filepath service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["Navigate.To.Filepath"]] |> expect.exist()
  })
  it("then services contains IDE.InUse service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["IDE.InUse"]] |> expect.exist()
  })
  it("then services contains VSCode.InUse service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["VSCode.InUse"]] |> expect.exist()
  })
  it("then services contains Get.Env.Variable service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["Get.Env.Variable"]] |> expect.exist()
  })
  it("then services contains Cache.Env.Variable service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["Cache.Env.Variable"]] |> expect.exist()
  })
  it("then services contains Clear.Env.Variable service.", {
    # Given
    services <- Session.Service()

    # Then
    services[["Clear.Env.Variable"]] |> expect.exist()
  })
})

describe("When service[['Has.RStudio.API']]()",{
  it("then TRUE is returned if RStudioAPI is available.", {
    # Given
    broker   <- Session.Broker()
    broker[['Has.RStudio.API']] <- \() { TRUE }

    service <- broker |> Session.Service()

    # When
    result <- service[["Has.RStudio.API"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if RStudioAPI is not available.", {
    # Given
    broker   <- Session.Broker()
    broker[['Has.RStudio.API']] <- \() { FALSE }

    service <- broker |> Session.Service()

    # When
    result <- service[["Has.RStudio.API"]]()

    # Then
    result |> expect.false()
  })
})

describe("When service[['Has.NavigateToFilepath']]()",{
  it("then TRUE is returned if navigateToFile function is available.", {
    # Given
    broker   <- Session.Broker()
    broker[['Has.NavigateToFilepath']] <- \() { TRUE }

    service <- broker |> Session.Service()

    # When
    result <- service[["Has.NavigateToFilepath"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if navigateToFile function is not available.", {
    # Given
    broker   <- Session.Broker()
    broker[['Has.NavigateToFilepath']] <- \() { FALSE }

    service <- broker |> Session.Service()

    # When
    result <- service[["Has.NavigateToFilepath"]]()

    # Then
    result |> expect.false()
  })
})

describe("When filepath |> service[['Navigate.To.Filepath']]()",{
  it("then an exception is thrown if path not found.", {
    # Given
    broker  <- Session.Broker()
    broker[['Navigate.To.Filepath']] <- \(filepath) {
      warning('path[1]="C:/Users/Path.Invalid/Documents/.Renviron": The system cannot find the path specified.')
    }
    service <- broker |> Session.Service()

    expected.error <- "Path not found: C:/Users/Path.Invalid/Documents/.Renviron."

    # When
    invalid.path <- "C:/Users/Path.Invalid/Documents/.Renviron"

    # Then
    invalid.path |> service[["Navigate.To.Filepath"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if file not found.",{
    # Given
    broker  <- Session.Broker()
    broker[['Navigate.To.Filepath']] <- \(filepath) {
      warning('path[1]="C:/Users/Analyst/Documents/check.txt": The system cannot find the file specified.')
    }
    service <- broker |> Session.Service()

    expected.error <- "File not found: C:/Users/Analyst/Documents/check.txt."

    # When
    invalid.file <- "C:/Users/Analyst/Documents/check.txt"

    # Then
    invalid.file |> service[["Navigate.To.Filepath"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if filepath is invalid.",{
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    input.filepath <- "C:\\Users\\username\\Documents\\.Renviron"
    expected.error <- paste0("Invalid filepath: ", "C:\\\\Users\\\\username\\\\Documents\\\\.Renviron", ".")

    # Then
    input.filepath |> service[['Navigate.To.Filepath']]() |> expect.error(expected.error)
  })
})

describe("When service[['IDE.InUse']]()",{
  it("then TRUE is returned if IDE is in use.", {
    # Given
    broker   <- Session.Broker()
    broker[['IDE.InUse']] <- \() { TRUE }

    service <- broker |> Session.Service()

    # When
    result <- service[["IDE.InUse"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if IDE is not in use.", {
    # Given
    broker   <- Session.Broker()
    broker[['IDE.InUse']] <- \() { FALSE }

    service <- broker |> Session.Service()

    # When
    result <- service[["IDE.InUse"]]()

    # Then
    result |> expect.false()
  })
})

describe("When service[['VSCode.InUse']]()",{
  it("then TRUE is returned if VS Code is in use.", {
    # Given
    broker   <- Session.Broker()
    broker[['VSCode.InUse']] <- \() { TRUE }

    service <- broker |> Session.Service()

    # When
    result <- service[["VSCode.InUse"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE is returned if VS Code is not in use.", {
    # Given
    broker   <- Session.Broker()
    broker[['VSCode.InUse']] <- \() { FALSE }

    service <- broker |> Session.Service()

    # When
    result <- service[["VSCode.InUse"]]()

    # Then
    result |> expect.false()
  })
})

describe("When name |> service[['Get.Env.Variable']]()",{
  it("then the value for variable with name is returned.", {
    skip_if_not(environment == 'local')
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    name  <- "ENVIRONMENT"

    # When
    value <- name |> service[["Get.Env.Variable"]]()

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    expected.error <- "Environment variable name is null, but required."

    # When
    name <- NULL

    # Then
    name |> service[["Get.Env.Variable"]]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if no value for variable is found",{
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    name           <- "INVALID"
    expected.error <- "No value found for provided environment variable:INVALID. Please check .Renviron configuration file."

    # Then
    name |> service[["Get.Env.Variable"]]() |> expect.error(expected.error)
  })
})

describe("When name |> service[['Cache.Env.Variable']](value)",{
  it("then the value of variable with name is cached.", {
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    # When
    name |> service[["Cache.Env.Variable"]](value)

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    expected.error <- "Environment variable name is null, but required."

    # When
    name  <- NULL
    value <- "new_value"

    # Then
    name |> service[["Cache.Env.Variable"]](value) |> expect.error(expected.error)
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
    name |> service[["Cache.Env.Variable"]](value) |> expect.error(expected.error)
  })
})

describe("When name |> service[['Clear.Env.Variable']]()",{
  it("then the value of variable with name is cleared.", {
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    name |> broker[["Cache.Env.Variable"]](value)

    # When
    name |> service[["Clear.Env.Variable"]]()

    # Then
    name |> broker[['Get.Env.Variable']]() |> expect.empty()
  })
  it("then an exception is thrown if name is NULL",{
    # Given
    broker  <- Session.Broker()
    service <- broker |> Session.Service()

    expected.error <- "Environment variable name is null, but required."

    # When
    name <- NULL

    # Then
    name |> service[["Clear.Env.Variable"]]() |> expect.error(expected.error)
  })
})