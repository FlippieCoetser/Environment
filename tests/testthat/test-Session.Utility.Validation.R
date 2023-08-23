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
  it("then validators should contain Filepath validator.", {
    # Given
    validators <- Session.Utility.Validation()

    # Then
    validators[["Filepath"]] |> expect.exist()
  })
})

describe("When response |> validate[['NavigationResponse']]()",{
  it("then a PathNotFound exception should be thrown is response throws a warning containing path not found",{
    # Given
    validate <- Session.Utility.Validation()
    throw.warning <- \() {
      warning('path[1]="C:/Users/InvalidPath/Documents/.Renviron": The system cannot find the path specified.')
    }

    expected.error <- "Path not found: C:/Users/InvalidPath/Documents/.Renviron."
    
    # Then
    throw.warning() |> validate[["NavigationResponse"]]() |> expect.error(expected.error)
  })
  it("then a FileNotFound exception should be thrown if response throws a warning containing file not found",{
    # Given
    validate <- Session.Utility.Validation()
    throw.warning <- \() {
      warning('path[1]="C:/Users/Analyst/Documents/check.txt": The system cannot find the file specified.')
    }

    expected.error <- "File not found: C:/Users/Analyst/Documents/check.txt."
    
    # Then
    throw.warning() |> validate[["NavigationResponse"]]() |> expect.error(expected.error)
  })
})