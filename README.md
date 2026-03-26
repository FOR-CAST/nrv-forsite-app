
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{nrv.forsite.app}`

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Installation

You can install the development version of `{nrv.forsite.app}` like so:

``` r
pak::pkg_install("FOR-CAST/nrv-forsite-app")
#> ℹ Loading metadata database✔ Loading metadata database ... done
#>  
#> ✖ Missing 1 system package. You'll probably need to install it manually:
#> + libabsl-dev  - s2
#> ℹ No downloads are needed
#> ✔ 1 pkg + 104 deps: kept 103 [7.3s]
```

## Run

You can launch the application by running:

``` r
nrv.forsite.app::run_app()
```

## Development

This app is built using the
[`golem`](https://thinkr-open.github.io/golem/index.html) framework.
Before making contributions, please familiarize yourself with that
package:

2.  [Development with
    `{golem}`](https://thinkr-open.github.io/golem/articles/b-develop.html);
3.  [Deployment](https://thinkr-open.github.io/golem/articles/c-deploy.html);

## About

You are reading the doc about version : 0.0.1

This README has been compiled on the

``` r
Sys.time()
#> [1] "2026-03-26 11:34:17 MDT"
```

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> ℹ Loading nrv.forsite.app
#> Registered S3 methods overwritten by 'callr':
#>   method                    from
#>   format.callr_status_error     
#>   print.callr_status_error
#> ── R CMD check results ────────────────────────────── nrv.forsite.app 0.0.1 ────
#> Duration: 1m 50.4s
#> 
#> ❯ checking for future file timestamps ... NOTE
#>   unable to verify current time
#> 
#> 0 errors ✔ | 0 warnings ✔ | 1 note ✖
```

``` r
covr::package_coverage()
#> nrv.forsite.app Coverage: 18.56%
#> R/app_config.R: 0.00%
#> R/app_server.R: 0.00%
#> R/app_ui.R: 0.00%
#> R/fct_map.R: 0.00%
#> R/fct_stats.R: 0.00%
#> R/mod_map.R: 0.00%
#> R/mod_methods.R: 0.00%
#> R/mod_regions.R: 0.00%
#> R/run_app.R: 0.00%
#> R/utils_inputs.R: 0.00%
#> R/utils_placeholder_data.R: 0.00%
#> R/golem_utils_server.R: 100.00%
#> R/golem_utils_ui.R: 100.00%
```
