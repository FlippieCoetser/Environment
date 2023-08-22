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
