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

describe("When process[['OpenConfigFile']]()",{
  it("then an exception should be thrown if no IDE in use.",{
    # Given
    broker <- Session.Utility.Broker()
    broker[['IDEInUse']] <- \() FALSE

    service <- broker |> Session.Utility.Service()
    process <- service |> Session.Utility.Processing()

    filepath <- "C:/Users/username/Documents/.Renviron"

    expected.error <- "No IDE in use but required."
    
    # Then
    filepath |> process[['OpenConfigFile']]() |> expect.error(expected.error)
  })
})