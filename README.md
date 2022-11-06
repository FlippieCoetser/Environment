# Environment
R Package used to Manage Environment Variables

`.Renviron` configuration file is part of the R ecosytem and well suited to management sensitive information.
This `Environment` package makes defining and reading environment variables straightforward.

This R-Package is also [Standard](https://github.com/hassanhabib/The-Standard) compliant.

## Installation
At the time of writing this README, this `Environment` R-Package is not yet available on CRAN.
Either use GitHub or Build and Install Localy:

### Install via GitHub

### Build and Install Locally



## Contibute
> Note: Developing R-Packages assumes you have devtools installed

Contributions is encouraged and very much welcomed! Given this R-Package is [Standard](https://github.com/hassanhabib/The-Standard) compliant. Any contribution is expected to follow the same principles. This package is also developed using a TDD approach. It is therefore expected that a commit with new working funtionality is preceeded with a commit contain a failing unit test or tests. Lastly, R is flexible and allows for different syntax and techniques to achieve the same outcome. Please stick to the naming and style convention used.

### Running Unit Tests
> Note: One Unit test assumes `.Renviron` file contains an key value for `Username`. If no `Username` key value defined, see usage section to learn how to define a new key value pair.

1. Running Unit Tests:
```r
devtools::test()
```
