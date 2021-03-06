
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/connectapi)](https://cran.r-project.org/package=connectapi)
[![Travis build
status](https://travis-ci.org/rstudio/connectapi.svg?branch=master)](https://travis-ci.org/rstudio/connectapi)
<!-- badges: end -->

# connectapi <img src='man/figures/logo.svg' align="right" height="139" />

This package is an **experimental WIP**. The package provides an R
client for the [RStudio Connect Server
API](https://docs.rstudio.com/connect/api/) as well as helpful functions
that utilize the client. The package is based on the `rsconnnect`
[package](https://rstudio.github.io/rsconnect/), but is publicly
exported to be easier to use, is extensible via an R6 class, and is
separated from the `rsconnect` package for easier support and
maintenance.

## Disclaimer

Because many of these functions are experimental, it is advisable to be
cautious about (1) upgrading the package, (2) upgrading RStudio Connect
when you care about the reproducibility of workflows that use
`connectapi`. As a result, we would advise:

  - managing package versions with
    [`renv`](https://rstudio.github.io/renv/)
  - test your dependent content before and after upgrading RStudio
    Connect

## Installation

To get started:

``` r
devtools::install_github('rstudio/connectapi')
```

## Client

To create a client:

``` r
library(connectapi)
client <- connect(
  host = 'https://connect.example.com',
  api_key = '<SUPER SECRET API KEY>'
)
```

You can also define the following environment variables (in a
`.Renviron` file, for instance):

    CONNECT_SERVER  = https://connect.example.com
    CONNECT_API_KEY = my-secret-api-key

These environment variable values will be used automatically if defined
in your R session.

``` r
library(connectapi)
client <- connect()
```

## Getting Started

Once a client is defined, you can use it to interact with RStudio
Connect.

### Exploring Data

These are experimental `lazy_tbl`s that allow you to retrieve data from
the Connect Server API much like using `dplyr`, `dbplyr`, or `dtplyr`.
Use `collect()` to retrieve data when finished.

NOTE: `filter` is not yet supported with this `tbl_connect`
implementation.

``` r
library(connectapi)
client <- connect()

# preview data
users <- tbl_connect(client, "users")
groups <- tbl_connect(client, "groups")
usage_shiny <- tbl_connect(client, "usage_shiny")
usage_static <- tbl_connect(client, "usage_static")
all_content <- tbl_connect(client, "content")

# page through all of the data
all_shiny_usage <- usage_shiny %>% collect()
```

### Deployment

The `rsconnect` package is usually used for deploying content to
Connect. However, if you want to use programmatic deployment with the
RStudio Connect Server API, then these `connectapi` helpers should be
useful\!

``` r
library(connectapi)
client <- connect()

# deploying content

bundle <- bundle_dir("./path/to/directory")
content <- client %>% 
  deploy(bundle, name = "my-app-name") %>% 
  poll_task()

# set an image for content

content %>% 
  set_image_path("./my/local/image.png")

content %>% 
  set_image_url("http://url.example.com/image.png")

# set image and a vanity URL

content %>%
  set_image_path("./my/local/image.png") %>%
  set_vanity_url("/my-awesome-app")
  
# edit another piece of content

client %>%
  content_item("the-content-guid") %>%
  set_vanity_url("/another-awesome-app")
  
# migrate content to another server

client_prod <- connect(
  host = "prod.example.com",
  api_key = "my-secret-key"
)

prod_bnd <- client %>%
  content_item("the-guid-to-promote") %>%
  download_bundle()

client_prod %>%
  deploy(prod_bnd, title = "Now in Production") %>%
  set_vanity_url("/my-app")
```

# Code of Conduct

Please note that the `connectapi` project is released with a
[Contributor Code of Conduct](.github/CODE_OF_CONDUCT.md). By
contributing to this project, you agree to abide by its terms.
