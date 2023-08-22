describe('Session.Utility.Broker', {
  it('Exist',{
    # Then
    Session.Utility.Broker |> expect.exist()
  })
})

describe("When operations <- Session.Utility.Broker()", {
  it("then operations should be a list.", {
    # Given
    operations <- Session.Utility.Broker()

    # Then
    operations |> expect.list()
  })
  it("then operations should contain HasRStudioAPI operation.", {
    # Given
    operations <- Session.Utility.Broker()

    # Then
    operations[["HasRStudioAPI"]] |> expect.exist()
  })
  it("then operations should contain HasNavigateToFile operation.", {
    # Given
    operations <- Session.Utility.Broker()

    # Then
    operations[["HasNavigateToFile"]] |> expect.exist()
  })
  it("then operations should contain NavigateToFile operation.", {
    # Given
    operations <- Session.Utility.Broker()

    # Then
    operations[["NavigateToFile"]] |> expect.exist()
  })
  it("then operations should contain IDEInUse operation.", {
    # Given
    operations <- Session.Utility.Broker()

    # Then
    operations[["IDEInUse"]] |> expect.exist()
  })
  it("then operations should contain VSCodeInUse operation.", {
    # Given
    operations <- Session.Utility.Broker()

    # Then
    operations[["VSCodeInUse"]] |> expect.exist()
  })
  it("then operations should contains GetEnvVariable operation.", {
    # Given
    operations <- Session.Utility.Broker()

    # Then
    operations[["GetEnvVariable"]] |> expect.exist()
  })
  it("then operations should contains CacheEnvVariable operation.", {
    # Given
    operations <- Session.Utility.Broker()

    # Then
    operations[["CacheEnvVariable"]] |> expect.exist()
  })
})

describe("When variable |> operation[['GetEnvVariable']]()",{
  it("then the value of variable stored in .Renviron file should be returned.", {
    skip_if_not(environment == 'local')
    # Given
    operations <- Session.Utility.Broker()

    variable       <- "ENVIRONMENT"
    expected.value <- variable |> Sys.getenv()

    # When
    actual.value <- variable |> operations[["GetEnvVariable"]]()

    # Then
    actual.value |> expect.equal(expected.value)
  })
  it("then an empty string is returned if the variable is not defined in .Renviron file.", {
    skip_if_not(environment == 'local')
    # Given
    operations <- Session.Utility.Broker()

    variable       <- "NOT_DEFINED"
    expected.value <- ""

    # When
    actual.value <- variable |> operations[["GetEnvVariable"]]()

    # Then
    actual.value |> expect.equal(expected.value)
  })
})

describe("When variable |> operation[['CacheEnvVariable']](value)",{
  it("then the value for variable is cached.", {
    # Given
    operations <- Session.Utility.Broker()

    variable <- "NEW_VARIABLE"
    value    <- "new_value"

    # When
    variable |> operations[["CacheEnvVariable"]](value)

    # Then
    variable |> Sys.getenv() |> expect.equal(value)
  })
})