describe('Session.Utility.Exceptions', {
  it('Exist',{
    # Then
    Session.Utility.Exceptions |> expect.exist()
  })
})

describe("When exceptions <- Session.Utility.Exceptions()",{
  it("then exceptions should be a list.", {
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions |> expect.list()
  })
})