State variable level
================
Renata Diaz
2020-05-23

    ## `geom_smooth()` using formula 'y ~ x'

![](sv_files/figure-gfm/portal%20rodents%20ts-1.png)<!-- -->

    ## `geom_smooth()` using formula 'y ~ x'

![](sv_files/figure-gfm/portal%20rodents%20ts-2.png)<!-- -->

BioTIME analyses:

  - Regulation vs. random walk
  - Trends: significance and slope

## Trends: Significance and slope

![](sv_files/figure-gfm/a%20single%20trend-1.png)<!-- -->

## Gleanings

  - All slopes for abundance are significant to .05 and positive; only 2
    are significant for energy.

  - For abundance, all communities have slopes that are positive (but
    not huge - around .05) and significant. This contrasts to findings
    from population-level (see pop.Rmd): there, slopes are concentrated
    around 0. But more variable and sometimes much larger?

  - For energy, control has a near-0 slope and not significant, terrible
    r2. Spectabs has positive slope but not significant. Exclosure and
    removal have positive slopes, significant.

# Regulation

    ## Registered S3 method overwritten by 'quantmod':
    ##   method            from
    ##   as.zoo.data.frame zoo

    ## Warning in tseries::adf.test(a_ts$response): p-value smaller than printed p-
    ## value

![](sv_files/figure-gfm/regulation-1.png)<!-- -->
