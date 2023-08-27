describe('Environment.Utility.Orchestration', {
  it('Exist',{
    # Then
    Environment.Utility.Orchestration |> expect.exist()
  })
})

describe("When orchestrations <- Environment.Utility.Orchestration()", {
  it("Then orchestrations should be a list", {
    # Given
    orchestrations <- Environment.Utility.Orchestration()

    # Then
    orchestrations |> expect.list()
  })
})