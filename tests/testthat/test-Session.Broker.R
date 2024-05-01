describe('Session.Broker', {
  it('Exist',{
    Session.Broker |> expect.exist()
  })
})

describe("When operations <- Session.Broker()", {
  it("then operations is a list.", {
    # When
    operations <- Session.Broker()

    # Then
    operations |> expect.list()
  })
  it("then operations contains 'has.RStudio.api' operation.", {
    # When
    operations <- Session.Broker()

    # Then
    operations[['has.RStudio.api']] |> expect.exist()
  })
  it("then operations contains 'has.navigate.to.file' operation.", {
    # When
    operations <- Session.Broker()

    # Then
    operations[['has.navigate.to.file']] |> expect.exist()
  })
  it("then operations contains 'navigate.to.file' operation.", {
    # When
    operations <- Session.Broker()

    # Then
    operations[['navigate.to.file']] |> expect.exist()
  })
  it("then operations contains 'IDE.active' operation.", {
    # When
    operations <- Session.Broker()

    # Then
    operations[['IDE.active']] |> expect.exist()
  })
  it("then operations contains 'VSCode.active' operation.", {
    # Given
    operations <- Session.Broker()

    # Then
    operations[['VSCode.active']] |> expect.exist()
  })
  it("then operations contains 'get.env.variable' operation.", {
    # When
    operations <- Session.Broker()

    # Then
    operations[['get.env.variable']] |> expect.exist()
  })
  it("then operations contains 'cache.env.variable' operation.", {
    # When
    operations <- Session.Broker()

    # Then
    operations[['cache.env.variable']] |> expect.exist()
  })
  it("then operations contains 'clear.env.variable' operation.", {
    # When
    operations <- Session.Broker()

    # Then
    operations[['clear.env.variable']] |> expect.exist()
  })
})

describe("When name |> operation[['get.env.variable']]()",{
  it("then the value of name stored in .Renviron file is returned.", {
    # Given
    operations <- Session.Broker()

    name  <- "VARIABLE"
    value <- "VALUE"

    name |> set.env.variable(value)

    expected.value <- name |> Sys.getenv()

    # When
    actual.value <- name |> operations[['get.env.variable']]()

    # Then
    actual.value |> expect.equal(expected.value)
  })
  it("then an empty string is returned if the name is not defined in .Renviron file.", {
    # Given
    operations <- Session.Broker()

    name           <- "NOT_DEFINED"
    expected.value <- ""

    # When
    actual.value <- name |> operations[['get.env.variable']]()

    # Then
    actual.value |> expect.equal(expected.value)
  })
})

describe("When name |> operation[['cache.env.variable']](value)",{
  it("then the value for name is cached.", {
    # Given
    operations <- Session.Broker()

    name  <- "VARIABLE"
    value <- "VALUE"

    # When
    name |> operations[['cache.env.variable']](value)

    # Then
    name |> Sys.getenv() |> expect.equal(value)
  })
})

describe("When name |> operation[['clear.env.variable']]()",{
  it("then the value for name is cleared.", {
    # Given
    operations <- Session.Broker()

    name  <- "VARIABLE"
    value <- "VALUE"

    name |> set.env.variable(value)

    actual.value <- name |> Sys.getenv()
    actual.value |> expect.equal(value)

    # When
    name |> operations[['clear.env.variable']]()

    # Then
    actual.value <- name |> Sys.getenv()
    actual.value |> expect.empty()
  })
})