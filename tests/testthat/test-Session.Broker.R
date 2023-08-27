describe('Session.Broker', {
  it('Exist',{
    # Then
    Session.Broker |> expect.exist()
  })
})

describe("When operations <- Session.Broker()", {
  it("then operations should be a list.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations |> expect.list()
  })
  it("then operations should contain HasRStudioAPI operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["HasRStudioAPI"]] |> expect.exist()
  })
  it("then operations should contain HasNavigateToFile operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["HasNavigateToFile"]] |> expect.exist()
  })
  it("then operations should contain NavigateToFile operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["NavigateToFile"]] |> expect.exist()
  })
  it("then operations should contain IDEInUse operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["IDEInUse"]] |> expect.exist()
  })
  it("then operations should contain VSCodeInUse operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["VSCodeInUse"]] |> expect.exist()
  })
  it("then operations should contains GetEnvVariable operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["GetEnvVariable"]] |> expect.exist()
  })
  it("then operations should contains CacheEnvVariable operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["CacheEnvVariable"]] |> expect.exist()
  })
})

describe("When name |> operation[['GetEnvVariable']]()",{
  it("then the value of name stored in .Renviron file should be returned.", {
    skip_if_not(environment == 'local')
    # Given
    operations <- Session.Broker()

    name           <- "ENVIRONMENT"
    expected.value <- name |> Sys.getenv()

    # When
    actual.value <- name |> operations[["GetEnvVariable"]]()

    # Then
    actual.value |> expect.equal(expected.value)
  })
  it("then an empty string is returned if the name is not defined in .Renviron file.", {
    skip_if_not(environment == 'local')
    # Given
    operations <- Session.Broker()

    name           <- "NOT_DEFINED"
    expected.value <- ""

    # When
    actual.value <- name |> operations[["GetEnvVariable"]]()

    # Then
    actual.value |> expect.equal(expected.value)
  })
})

describe("When name |> operation[['CacheEnvVariable']](value)",{
  it("then the value for name is cached.", {
    # Given
    operations <- Session.Broker()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    # When
    name |> operations[["CacheEnvVariable"]](value)

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
})