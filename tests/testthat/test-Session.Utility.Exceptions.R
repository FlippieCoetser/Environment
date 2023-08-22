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
  it("then exceptions should contain NavigateToFileExceptions.", {
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["NavigateToFileExceptions"]] |> expect.exist()
  })
})