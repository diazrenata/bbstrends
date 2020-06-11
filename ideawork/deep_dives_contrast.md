A deep dive
================

Here I have loaded the IBD which includes a size estimate and metabolic
rate estimate, and species ID, for every individual at every time point.

    ##   year     id    ind_size      ind_b
    ## 1 1973 sp3370 1115.000379 1562.77475
    ## 2 1973 sp3570  186.318376  436.39685
    ## 3 1973 sp4123  134.462305  345.84499
    ## 4 1973 sp4123  129.936905  337.50529
    ## 5 1973 sp4123  123.839788  326.13591
    ## 6 1973 sp4330    2.653335   21.05489

We can use the IBD to compute aggregate metrics per year.

    ## # A tibble: 6 x 7
    ##    year totalind  nspp totalmass totalenergy meanmass meanenergy
    ##   <int>    <int> <int>     <dbl>       <dbl>    <dbl>      <dbl>
    ## 1  1973      506    48    27603.      78870.     54.6       156.
    ## 2  1974      218    44    14648.      38277.     67.2       176.
    ## 3  1975      252    45    18940.      48732.     75.2       193.
    ## 4  1976      206    41    11523.      31950.     55.9       155.
    ## 5  1977      311    47    22562.      52836.     72.5       170.
    ## 6  1978      363    50    19755.      55317.     54.4       152.

Let’s plot the aggregate metrics over time.

    ## `geom_smooth()` using formula 'y ~ x'

![](deep_dives_contrast_files/figure-gfm/agg%20over%20time-1.png)<!-- -->

    ## `geom_smooth()` using formula 'y ~ x'

![](deep_dives_contrast_files/figure-gfm/agg%20over%20time-2.png)<!-- -->

    ## `geom_smooth()` using formula 'y ~ x'

![](deep_dives_contrast_files/figure-gfm/agg%20over%20time-3.png)<!-- -->

    ## `geom_smooth()` using formula 'y ~ x'

![](deep_dives_contrast_files/figure-gfm/agg%20over%20time-4.png)<!-- -->![](deep_dives_contrast_files/figure-gfm/agg%20over%20time-5.png)<!-- -->

    ## `geom_smooth()` using formula 'y ~ x'

![](deep_dives_contrast_files/figure-gfm/agg%20over%20time-6.png)<!-- -->

    ## `geom_smooth()` using formula 'y ~ x'

![](deep_dives_contrast_files/figure-gfm/agg%20over%20time-7.png)<!-- -->

![](deep_dives_contrast_files/figure-gfm/agg%20lms-1.png)<!-- -->

    ## 
    ## Call:
    ## lm(formula = value ~ year * currency, data = agg_for_lm)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -1.5388 -0.6549 -0.2817  0.2813  3.2330 
    ## 
    ## Coefficients:
    ##                          Estimate Std. Error t value Pr(>|t|)
    ## (Intercept)            -18.111678  23.622752  -0.767    0.445
    ## year                     0.009078   0.011839   0.767    0.445
    ## currencytotalind         3.646231  33.407616   0.109    0.913
    ## currencytotalmass       -8.890488  33.407616  -0.266    0.791
    ## year:currencytotalind   -0.001827   0.016743  -0.109    0.913
    ## year:currencytotalmass   0.004456   0.016743   0.266    0.791
    ## 
    ## Residual standard error: 1.003 on 114 degrees of freedom
    ## Multiple R-squared:  0.01952,    Adjusted R-squared:  -0.02348 
    ## F-statistic: 0.4539 on 5 and 114 DF,  p-value: 0.8097

![](deep_dives_contrast_files/figure-gfm/agg%20lms-2.png)<!-- -->![](deep_dives_contrast_files/figure-gfm/agg%20lms-3.png)<!-- -->![](deep_dives_contrast_files/figure-gfm/agg%20lms-4.png)<!-- -->![](deep_dives_contrast_files/figure-gfm/agg%20lms-5.png)<!-- -->

The story I would tell from this is:

  - General correspondence between currencies. Overall not a pronounced
    trend, but quite a spike in all currencies in the late 20teens. No
    systematic pull in size.

<!-- Let's look at the ISD by year? Will be big!! -->

<!-- ```{r isds, fig.dim = c(20,20)} -->

<!-- ggplot(ibd, aes(x = log(ind_size))) + -->

<!--   geom_density() + -->

<!--   theme_bw() + -->

<!--   facet_wrap(vars(year), scales = "free_y", ncol = 4) -->

<!-- ``` -->

<!-- Just based on intuition, let's contrast this with species histograms by year... -->

<!-- ```{r composition, fig.dim = c(20,20)} -->

<!-- ggplot(ibd, aes(x = id, y = ..count..)) + -->

<!--   geom_bar() + -->

<!--   theme_bw() + -->

<!--   facet_wrap(vars(year), scales = "free_y", ncol = 4) -->

<!-- ``` -->

<!-- So now I would like to see plots of: -->

<!-- * Pairwise ISD overlap (y) against distance in time (x).  -->

<!-- * Euclidean community distance (y) against distance in time (x). -->

<!-- It looks to me almost like the ISDs could be plausibly unordered: not shifting directionally through time. Such that overlap should generally be high, and there should not be a relationship between how far apart years are and how similar they are. But that we might have seen directional change in species composition, meaning that years farther apart will be less similar than adjacent ones. -->

<!-- This isn't what we get from these plots! Not sure if that's cause I'm wrong, or because these plots aren't sophisticated enough to handle autocorrelation etc. -->

<!-- The one piece of this I think is really interesting (and I have some confidence in) is, that Euclidean distance and overlap appear pretty uncorrelated. I *think* this points to a large degree of functional replacement of species: you can have high overlap with large distance, if species 1 has replaced species 2 but they are the same size. -->

    ## Joining, by = "year"

    ## Joining, by = "species"
    ## Joining, by = "species"

![](deep_dives_contrast_files/figure-gfm/overlap%20v%20eucl-1.png)<!-- -->

Similarity in species composition doesn’t appear to predict ISD overlap.

### Scrap

    ## `geom_smooth()` using formula 'y ~ x'

![](deep_dives_contrast_files/figure-gfm/year%20dist%20v%20overlap-1.png)<!-- -->

    ## `geom_smooth()` using formula 'y ~ x'

![](deep_dives_contrast_files/figure-gfm/distance%20v%20eucl-1.png)<!-- -->

    ## `geom_smooth()` using formula 'y ~ x'

![](deep_dives_contrast_files/figure-gfm/since%201972%20overlap-1.png)<!-- -->

**Hugely noisy** and not an obvious decrease in overlap over time.

    ## `geom_smooth()` using formula 'y ~ x'

![](deep_dives_contrast_files/figure-gfm/eucl%20since%201972-1.png)<!-- -->

Somewhat clearer increase in distance in composition, but still super
noisy.

    ## Joining, by = c("year1", "year2")

    ## `geom_smooth()` using formula 'y ~ x'

    ## Warning: Removed 1 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 1 rows containing missing values (geom_point).

![](deep_dives_contrast_files/figure-gfm/consecutive%20overlap-1.png)<!-- -->

    ## `geom_smooth()` using formula 'y ~ x'

    ## Warning: Removed 1 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 1 rows containing missing values (geom_point).

![](deep_dives_contrast_files/figure-gfm/consecutive%20eucl-1.png)<!-- -->

I don’t see an obvious change in how similar consecutive samples are
over time.
