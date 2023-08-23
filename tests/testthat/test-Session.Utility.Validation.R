describe('Session.Utility.Validation', {
  it('Exist',{
    # Then
    Session.Utility.Validation |> expect.exist()
  })
})

describe("When validators <- Session.Utility.Validation()",{
  it("then validators should be a list.", {
    # Given
    validators <- Session.Utility.Validation()

    # Then
    validators |> expect.list()
  })
})