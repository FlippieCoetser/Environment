describe('Session.Broker', {
  it('Exist',{
    # Then
    Session.Broker |> expect.exist()
  })
})

describe("When operations <- Session.Broker()", {
  it("then operations is a list.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations |> expect.list()
  })
  it("then operations contains HasRStudioAPI operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["HasRStudioAPI"]] |> expect.exist()
  })
  it("then operations contains HasNavigateToFile operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["HasNavigateToFile"]] |> expect.exist()
  })
  it("then operations contains NavigateToFile operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["NavigateToFile"]] |> expect.exist()
  })
  it("then operations contains IDEInUse operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["IDEInUse"]] |> expect.exist()
  })
  it("then operations contains VSCodeInUse operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["VSCodeInUse"]] |> expect.exist()
  })
  it("then operations contains GetEnvVariable operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["GetEnvVariable"]] |> expect.exist()
  })
  it("then operations contains CacheEnvVariable operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["CacheEnvVariable"]] |> expect.exist()
  })
  it("then operations contains ClearEnvVariable operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["ClearEnvVariable"]] |> expect.exist()
  })
})

describe("When name |> operation[['GetEnvVariable']]()",{
  it("then the value of name stored in .Renviron file is returned.", {
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

describe("When name |> operation[['ClearEnvVariable']]()",{
  it("then the value for name is cleared.", {
    # Given
    operations <- Session.Broker()

    name  <- "NEW_VARIABLE"
    value <- "value"

    entry <- list()
    entry[[name]] <- value
    "Sys.setenv" |> do.call(entry)

    actual.value <- name |> Sys.getenv()
    actual.value |> expect.equal(value)

    # When
    name |> operations[["ClearEnvVariable"]]()

    # Then
    actual.value <- name |> Sys.getenv()
    actual.value |> expect.empty()
  })
})