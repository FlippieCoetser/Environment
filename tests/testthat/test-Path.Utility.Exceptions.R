describe('Path.Utility.Exceptions', {
  it('Exist',{
    # Then
    Path.Utility.Exceptions |> expect.exist()
  })
})

describe("When exceptions <- Path.Utility.Exceptions()",{
  it("then exceptions should be a list.",{
    # Given
    exceptions <- Path.Utility.Exceptions()

    # Then
    exceptions |> expect.list()
  })
  it("then exceptions should contains InvalidPath exception.",{
    # Given
    exceptions <- Path.Utility.Exceptions()

    # Then
    exceptions[["InvalidPath"]] |> expect.exist()
  })
}) 