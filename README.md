# Environment

This R Package is used to Manage Environment Variables using the `.Renviron` file. `.Renviron` configuration file is part of the R ecosystem and well suited to manage sensitive information.

This `Environment` package makes defining, reading and clearing environment variables straightforward by providing four utility functions:

1. `OpenConfigFile` - Opens the `.Renviron` configuration file in the IDE: RStudio or VSCode.
2. `GetEnvVariable` - Gets the value of an environment variable by name, as stored in `.Renviron`
3. `CacheEnvVariable` - Caches the value of an environment variable by name, for current R session.
4. `ClearEnvVariable` - Clears the value of an environment variable by name, for current R session.

> Note: This package is [Standard](https://github.com/hassanhabib/The-Standard) compliant package.

## Installation

At the time of writing this README, this `Environment` R-Package is not available on CRAN.
Use `devtools` to either install from GitHub or Build and Install Locally:

### Install via GitHub

1. Use Devtools

```r
devtools::install_github("https://github.com/FlippieCoetser/Environment")
```

### Build and Install Locally

1. Generate `.tar.gz` file

```r
devtools::build()
```

2. Install `.tar.gz` file

```r
install.packages("path_to_file/tar_gz_file", repos = NULL, type="source")
```

## Loading the Package

There are two ways to access the four utility functions:

1. Use the library function to load the four utility functions into the global namespace
2. Create an instance of the Environment component using the package namespace

### Use Global Namespace

When using the library function to load the package the four utility functions are automatically loaded into the global namespace.

1. Load Package

```r
library(Environment)
```

### Use Package Namespace

When using the package namespace to create a new instance of the Environment component, the four utility functions will be available as member of the instance.

1. Create new instance of Environment component

```r
environment <- Environment::Environment()
```

2. Access the three utility functions, by name, on the instance

```r
environment[[name]]()
```

## Usage

### Define an environment

All environment variables are defined in a locally stored `.Renviron` configuration file.
This package does not directly add environment variables into the `.Renviron` configuration file.
To define new variable, simply use the provided utility function to open an existing or a new empty file directly in your IDE. This function requires either RStudio or VSCode.

1. Open `.Renviron` configuration file

```r
OpenConfigFile()
```

or

```r
environment[['OpenConfigFile']]()
```

> Note: Add new environment variables as key value pairs directly into the `.Renviron` configuration file. Example, adding this: `Username='DefinedUsername'` on a new line, defines a new environment variable with name `Username` and value `DefinedUsername`

### Get an environment variable's value

Reading environment variables is the most common use case of this package. Attempting to read an environment variable that is not defined will throw an exception with useful details.

1. Get environment variable's value

```r
name <- "Username"

value <- name |> GetEnvVariable()
```

or

```r
name <- "Username"

value <- name |> environment[['GetEnvVariable']]()
```

### Cache an environment variable's value

This package provides a way to cache an environment variable with value for the current R session. This is useful when the value of an environment variable is used multiple times in the same R session.

1. Cache the value of an environment variable

```r
name  <- "Username"
value <- "DefinedUsername"

name |> CacheEnvVariable(value)
```

or

```r
name  <- "Username"
value <- "DefinedUsername"

name |> environment[['CacheEnvVariable']](value)
```

### Clear an environment variable's value

This package provides a way to clear an environment variable for the current R session. This is useful when testing packages which relies on this package.

1. Clear the value of an environment variable

```r
name  <- "Username"

name |> ClearEnvVariable()
```

or

```r
name  <- "Username"

name |> environment[['ClearEnvVariable']]()
```

## Contribute

> Note: Developing R-Packages assumes you have devtools installed

Contributions is encouraged and very much welcome! Given this R-Package is [Standard](https://github.com/hassanhabib/The-Standard) compliant, any contribution is expected to follow the same principles. This package is also developed using a TDD approach. It is therefore expected that commits happen in pairs: One commit with a failing test and one with a passing test. Lastly, R is flexible and allows for different syntax. Please stick to the naming and style convention used. For example `dot.case` is used as naming convention, and `[['']]` is preferred over `$` as subset operator.

### Running Unit Tests

> Note: Some unit tests are not executed during the continuous integration process.

1. Running Unit Tests:

```r
devtools::test()
```
