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
})

describe("When services[['HasRStudioAPI']]()",{
  it("then TRUE should be returned if RStudioAPI is available.", {
    # Given
    broker   <- Session.Utility.Broker()
    broker[['HasRStudioAPI']] <- \() { TRUE }

    services <- broker |> Session.Utility.Service()

    # When
    result <- services[["HasRStudioAPI"]]()

    # Then
    result |> expect.true()
  })
  it("then FALSE should be returned if RStudioAPI is not available.", {
    # Given
    broker   <- Session.Utility.Broker()
    broker[['HasRStudioAPI']] <- \() { FALSE }

    services <- broker |> Session.Utility.Service()

    # When
    result <- services[["HasRStudioAPI"]]()

    # Then
    result |> expect.false()
  })
})