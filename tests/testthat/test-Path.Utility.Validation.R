describe('Path.Utility.Validation', {
  it('Exist',{
    # Then
    Path.Utility.Validation |> expect.exist()
  })
})

describe("When validators <- Path.Utility.Validation()", {
  it("then validators should be a list.", {
    # Given
    validators <- Path.Utility.Validation()

    # Then
    validators |> expect.list()
  })
  it("then validators should contain Path service.", {
    # Given
    validators <- Path.Utility.Validation()

    # Then
    validators[["Path"]] |> expect.exist()
  })
})