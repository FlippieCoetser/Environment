describe('Path.Utility.Service', {
  it('Exist',{
    # Then
    Path.Utility.Service |> expect.exist()
  })
})

describe("When services <- Path.Utility.Service()", {
  it("then services should be a list.", {
    # Given
    services <- Path.Utility.Broker()

    # Then
    services |> expect.list()
  })
})