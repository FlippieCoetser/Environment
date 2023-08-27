describe('Utility.Service', {
  it('Exist',{
    # Then
    Utility.Service |> expect.exist()
  })
})

describe("When services <- Utility.Service()", {
  it("then services is a list.", {
    # Given
    services <- Utility.Service()

    # Then
    services |> expect.list()
  })
  it("then services contains OpenConfigurationFile service.", {
    # Given
    services <- Utility.Service()

    # Then
    services[["OpenConfigurationFile"]] |> expect.exist()
  })
  it("then services contains GetVariableByName service.", {
    # Given
    services <- Utility.Service()

    # Then
    services[["OpenConfigurationFile"]] |> expect.exist()
  })
})