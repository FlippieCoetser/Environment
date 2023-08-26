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
})

describe("When process[['GetIDEInUse']]()",{
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
})