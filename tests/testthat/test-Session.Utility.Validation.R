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
  it("then validators should contain NavigationResponse validator.", {
    # Given
    validators <- Session.Utility.Validation()

    # Then
    validators[["NavigationResponse"]] |> expect.exist()
  })
})

describe("When response |> validate[['NavigationResponse']]()",{
  it("then a PathNotFound exception should be thrown is response throws a warning containing path not found",{
    # Given
    validate <- Session.Utility.Validation()
    response <- \() {
      warning('path[1]="C:/Users/InvalidPath/Documents/.Renviron": The system cannot find the path specified.')
    }

    expected.error <- "Path not found: C:/Users/InvalidPath/Documents/.Renviron."
    
    # Then
    response() |> validate[["NavigationResponse"]]() |> expect.error(expected.error)
  })
})