describe("Session.Utility.Processing",{
  it("Exist",{
     Session.Utility.Processing |> expect.exist()
  })
})

describe("When processors <- Session.Utility.Processing()",{
  it("then processors should be a list.", {
    # Given
    processors <- Session.Utility.Processing()

    # Then
    processors |> expect.list()
  })
  it("then processors should contain GetIDEInUse.", {
    # Given
    processors <- Session.Utility.Processing()

    # Then
    processors[["GetIDEInUse"]] |> expect.exist()
  })
})