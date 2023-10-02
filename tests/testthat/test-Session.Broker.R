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
  it("then operations contains Has.RStudio.API operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["Has.RStudio.API"]] |> expect.exist()
  })
  it("then operations contains Has.NavigateToFilepath operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["Has.NavigateToFilepath"]] |> expect.exist()
  })
  it("then operations contains Navigate.To.Filepath operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["Navigate.To.Filepath"]] |> expect.exist()
  })
  it("then operations contains IDE.InUse operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["IDE.InUse"]] |> expect.exist()
  })
  it("then operations contains VSCode.InUse operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["VSCode.InUse"]] |> expect.exist()
  })
  it("then operations contains Get.Env.Variable operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["Get.Env.Variable"]] |> expect.exist()
  })
  it("then operations contains Cache.Env.Variable operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["Cache.Env.Variable"]] |> expect.exist()
  })
  it("then operations contains Clear.Env.Variable operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[["Clear.Env.Variable"]] |> expect.exist()
  })
})

describe("When name |> operation[['Get.Env.Variable']]()",{
  it("then the value of name stored in .Renviron file is returned.", {
    skip_if_not(environment == 'local')
    # Given
    operations <- Session.Broker()

    name           <- "ENVIRONMENT"
    expected.value <- name |> Sys.getenv()

    # When
    actual.value <- name |> operations[["Get.Env.Variable"]]()

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
    actual.value <- name |> operations[["Get.Env.Variable"]]()

    # Then
    actual.value |> expect.equal(expected.value)
  })
})

describe("When name |> operation[['Cache.Env.Variable']](value)",{
  it("then the value for name is cached.", {
    # Given
    operations <- Session.Broker()

    name  <- "NEW_VARIABLE"
    value <- "new_value"

    # When
    name |> operations[["Cache.Env.Variable"]](value)

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
})

describe("When name |> operation[['Clear.Env.Variable']]()",{
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
    name |> operations[["Clear.Env.Variable"]]()

    # Then
    actual.value <- name |> Sys.getenv()
    actual.value |> expect.empty()
  })
})