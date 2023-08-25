describe('Path.Utility.Processing', {
  it('Exist',{
    # Then
    Path.Utility.Processing |> expect.exist()
  })
})

describe("When processors <- Path.Utility.Processing()",{
  it("then processors should be a list.", {
    # Given
    processors <- Path.Utility.Processing()

    # Then
    processors |> expect.list()
  })
  it("then processors contains GetConfigFilepath", {
    # Given
    processors <- Path.Utility.Processing()

    # Then
    processors[['GetConfigFilepath']] |> expect.exist()
  })
})