describe("Session.Utility.Processing",{
  it("Exist",{
     Session.Utility.Processing |> expect.exist()
  })
})

describe("When processors <- Session.Utility.Processing()",{
  it("then processors should be a list.", {
    # Given
    processors <- Session.Utility.Processing()

    # Then
    processors |> expect.list()
  })
  it("then processors should contain GetIDEInUse.", {
    # Given
    processors <- Session.Utility.Processing()

    # Then
    processors[["GetIDEInUse"]] |> expect.exist()
  })
  it("then processors should contain OpenConfigFile.", {
    # Given
    processors <- Session.Utility.Processing()

    # Then
    processors[["OpenConfigFile"]] |> expect.exist()
  })
  it("then processors should contain CheckIDEInUse.", {
    # Given
    processors <- Session.Utility.Processing()

    # Then
    processors[["CheckIDEInUse"]] |> expect.exist()
  })
})

describe("When process[['GetIDEInUse']]()",{
  it("then None should be returned in no IDE is in use.", {
    # Given
    broker <- Session.Utility.Broker()
    broker[['IDEInUse']] <- \() FALSE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    expected.result <- "None"

    # When
    result <- process[["GetIDEInUse"]]()

    # Then
    result |> expect.equal(expected.result)
  })
  it("then RStudio should be returned is RStudio is in use.", {
    # Given
    broker <- Session.Utility.Broker()
    broker[['VSCodeInUse']] <- \() FALSE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    expected.result <- "RStudio"

    # When
    result <- process[["GetIDEInUse"]]()

    # Then
    result |> expect.equal(expected.result)
  })
  it("then VSCode should be returned if VSCode is in use.", {
    # Given
    broker <- Session.Utility.Broker()
    broker[['VSCodeInUse']] <- \() TRUE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    expected.result <- "VSCode"

    # When
    result <- process[["GetIDEInUse"]]()

    # Then
    result |> expect.equal(expected.result)
  })
})

describe("When filepath |> process[['OpenFilepath']]()",{
  it("then the filepath should be opened in the IDE in use.",{
    # Given
    expected.filepath <- NULL

    broker <- Session.Utility.Broker()
    broker[['IDEInUse']]          <- \() TRUE
    broker[['HasRStudioAPI']]     <- \() TRUE
    broker[['HasNavigateToFile']] <- \() TRUE

    broker[['NavigateToFile']] <- \(filepath) {
      expected.filepath <<- filepath
    }

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    input.filepath <- "C:/Users/username/Documents/.Renviron"


    # When
    actual.filepath <- input.filepath |> process[['OpenFilepath']]()

    # Then
    actual.filepath |> expect.equal(expected.filepath)
  })
  it("then an exception should be thrown if no IDE in use.",{
    # Given
    broker <- Session.Utility.Broker()
    broker[['IDEInUse']] <- \() FALSE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "No IDE in use but required."
    
    # Then
    filepath |> process[['OpenFilepath']]() |> expect.error(expected.error)
  })
  it("then an exception should be thrown if RStudio API is unavailable in RStudio.",{
    # Given
    broker <- Session.Utility.Broker()
    broker[['IDEInUse']]          <- \() TRUE
    broker[['HasRStudioAPI']]     <- \() FALSE
    broker[['HasNavigateToFile']] <- \() FALSE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "RStudio API is unavailable in RStudio."

    # Then
    filepath |> process[['OpenFilepath']]() |> expect.error(expected.error)
  })
  it("then an exception should be thrown if RStudio API is unavailable in VSCode.",{
    # Given
    broker <- Session.Utility.Broker()
    broker[['IDEInUse']]          <- \() TRUE
    broker[['VSCodeInUse']]       <- \() TRUE
    broker[['HasRStudioAPI']]     <- \() FALSE
    broker[['HasNavigateToFile']] <- \() FALSE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "RStudio API is unavailable in VSCode."

    # Then
    filepath |> process[['OpenFilepath']]() |> expect.error(expected.error)
  })
  it("then an exception should be thrown if Navigate To File function is unavailable in RStudio.",{
    # Given
    broker <- Session.Utility.Broker()
    broker[['IDEInUse']]          <- \() TRUE
    broker[['HasRStudioAPI']]     <- \() TRUE
    broker[['HasNavigateToFile']] <- \() FALSE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "Navigate to File function is unavailable in RStudio."

    # Then
    filepath |> process[['OpenFilepath']]() |> expect.error(expected.error)
  })
  it("then an exception should be thrown if Navigate To File function is unavailable in VSCode.",{
    # Given
    broker <- Session.Utility.Broker()
    broker[['IDEInUse']]          <- \() TRUE
    broker[['VSCodeInUse']]       <- \() TRUE
    broker[['HasRStudioAPI']]     <- \() TRUE
    broker[['HasNavigateToFile']] <- \() FALSE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "Navigate to File function is unavailable in VSCode."

    # Then
    filepath |> process[['OpenFilepath']]() |> expect.error(expected.error)
  })
})

describe("When ide |> process[['CheckIDEInUse']]()",{
  it("then an exception should be thrown if no IDE in use.",{
    # Given
    broker <- Session.Utility.Broker()
    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    ide <- "None"

    expected.error <- "No IDE in use but required."

    # Then
    ide |> process[['CheckIDEInUse']]() |> expect.error(expected.error)
  })
  it("then an exception should be thrown if RStudioAPI is unavailable in RStudio.",{
    # Given
    broker <- Session.Utility.Broker()
    broker[['HasRStudioAPI']]     <- \() FALSE
    broker[['HasNavigateToFile']] <- \() TRUE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    ide <- "RStudio"

    expected.error <- "RStudio API is unavailable in RStudio."

    # Then
    ide |> process[['CheckIDEInUse']]() |> expect.error(expected.error)
  })
  it("then an exception should be thrown if RStudioAPI is unavailable in VSCode.",{
    # Given
    broker <- Session.Utility.Broker()
    broker[['HasRStudioAPI']]     <- \() FALSE
    broker[['HasNavigateToFile']] <- \() TRUE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    ide <- "VSCode"

    expected.error <- "RStudio API is unavailable in VSCode."

    # Then
    ide |> process[['CheckIDEInUse']]() |> expect.error(expected.error)
  })
  it("then an exception should be thrown if Navigate To File function is unavailable in RStudio.",{
    # Given
    broker <- Session.Utility.Broker()
    broker[['HasRStudioAPI']]     <- \() TRUE
    broker[['HasNavigateToFile']] <- \() FALSE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    ide <- "RStudio"

    expected.error <- "Navigate to File function is unavailable in RStudio."

    # Then
    ide |> process[['CheckIDEInUse']]() |> expect.error(expected.error)
  })
  it("then an exception should be thrown if Navigate To File function is unavailable in VSCode.",{
    # Given
    broker <- Session.Utility.Broker()
    broker[['HasRStudioAPI']]     <- \() TRUE
    broker[['HasNavigateToFile']] <- \() FALSE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    ide <- "VSCode"

    expected.error <- "Navigate to File function is unavailable in VSCode."

    # Then
    ide |> process[['CheckIDEInUse']]() |> expect.error(expected.error)
  })
})