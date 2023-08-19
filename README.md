# Environment

This R Package is used to Manage Environment Variables and is a [Standard](https://github.com/hassanhabib/The-Standard) compliant package.

`.Renviron` configuration file is part of the R ecosystem and well suited to manage sensitive information.
This `Environment` package makes defining and reading environment variables straightforward.

## Usage

`Utility.Service()` function returns a set of utility functions to define and read environment variables.

1. Load Package

```r
library(Environment)
```

2. Get Utility Functions

```r
utility <- Utility.Service()
```

### Defining Variables

All environment variables are defined in a locally stored `.Renviron` configuration file.
This package does not directly add environment variables into the `.Renviron` configuration file.
To define new variable, simply use the provided utility function to open an existing or a new empty file directly in your IDE.

1 Open `.Renviron` Configuration File

```r
utility[["OpenConfigurationFile"]]()
```

> Note: Add new environment variables as key value pairs directly into the `.Renviron` configuration file.
> Example, adding this: `Username='DefinedUsername'` on a new line, defines a new environment variable with name `Username` and value `DefinedUsername`

### Reading a Variable

1. Get environment variable's value

```r
variable.name <- "Username"

variable.value <- variable.name |> utility[["GetVariableByName"]]()
```

## Installation

At the time of writing this README, this `Environment` R-Package is not available on CRAN.
Either use GitHub or Build and Install Locally:

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

## Contribute

> Note: Developing R-Packages assumes you have devtools installed

Contributions is encouraged and very much welcomed! Given this R-Package is [Standard](https://github.com/hassanhabib/The-Standard) compliant, any contribution is expected to follow the same principles. This package is also developed using a TDD approach. It is therefore expected that a commit with new working functionality is preceded with a commit contain a failing unit test or tests. Lastly, R is flexible and allows for different syntax and techniques to achieve the same outcome. Please stick to the naming and style convention used.

### Running Unit Tests

Some unit tests are not executed during the continuous integration process.

1. Running Unit Tests:

```r
devtools::test()
```
