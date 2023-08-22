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