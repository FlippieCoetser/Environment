describe('Utility.Service', {
  it('Exist',{
    # Then
    Utility.Service |> expect.exist()
  })
})

describe("When services <- Utility.Service()", {
  it("then services should be a list.", {
    # Given
    services <- Utility.Service()

    # Then
    services |> expect.list()
  })
  it("then services should contain OpenConfigurationFile service.", {
    # Given
    services <- Utility.Service()

    # Then
    services[["OpenConfigurationFile"]] |> expect.exist()
  })
  it("then services should contain GetVariableByName service.", {
    # Given
    services <- Utility.Service()

    # Then
    services[["OpenConfigurationFile"]] |> expect.exist()
  })
})