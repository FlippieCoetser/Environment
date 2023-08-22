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
})