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
  it("then exceptions should contain PathNotFound Exception.", {
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["PathNotFound"]] |> expect.exist()
  })
  it("then exceptions should contain FileNotFound Exception.", {
    # Given
    exceptions <- Session.Utility.Exceptions()

    # Then
    exceptions[["FileNotFound"]] |> expect.exist()
  })
})

describe("When input |> exception[['PathNotFound']](path)",{
  it("then no exception should be thrown if input is FALSE.",{
    # Given
    exception <- Session.Utility.Exceptions()

    # When
    validation.input <- FALSE

    # Then
    validation.input |> exception[["PathNotFound"]]() |> expect.no.error()
  })
})