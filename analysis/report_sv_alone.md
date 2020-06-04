Summary Report
================
Ren
2020-06-03

## Aggregate

``` r
loadd(all_lin)
```

``` r
all_lin <- all_lin %>%
  mutate(signif = p <= .05,
         win = slope > 0,
         lose = slope < 0)

ggplot(all_lin, aes(x = slope)) +
  geom_histogram(alpha = .8) + theme_bw() + 
 # geom_density(alpha = 0) +
  facet_wrap(vars(currency), scales = "free_y") +
  geom_vline(xintercept = 0)
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](report_sv_alone_files/figure-gfm/slope%20and%20p%20hists-1.png)<!-- -->

``` r
ggplot(all_lin, aes(x = slope)) +
  geom_histogram() + theme_bw() + 
  facet_wrap(vars(currency, signif), scales = "free_y", ncol = 2) 
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](report_sv_alone_files/figure-gfm/slope%20and%20p%20hists-2.png)<!-- -->

``` r
ggplot(all_lin, aes(x = slope, y = log(p), size = r2)) +
  geom_point() + theme_bw() +
  geom_hline(yintercept = log(.05)) +
  facet_wrap(vars(currency))
```

![](report_sv_alone_files/figure-gfm/slope%20and%20p%20hists-3.png)<!-- -->

``` r
lin_sum <- all_lin %>%
  group_by(currency, signif) %>%
  summarize(prop_win = mean(win),
            prop_lose = mean(lose),
            n = dplyr::n()) %>%
  ungroup() %>%
  group_by(currency) %>%
  mutate(prop_overall = n / sum(n)) %>%
  ungroup()

print(lin_sum)
```

    ## # A tibble: 6 x 6
    ##   currency    signif prop_win prop_lose     n prop_overall
    ##   <chr>       <lgl>     <dbl>     <dbl> <int>        <dbl>
    ## 1 energy      FALSE     0.492     0.508   299        0.598
    ## 2 energy      TRUE      0.373     0.627   201        0.402
    ## 3 individuals FALSE     0.419     0.581   246        0.492
    ## 4 individuals TRUE      0.260     0.740   254        0.508
    ## 5 mass        FALSE     0.520     0.480   323        0.646
    ## 6 mass        TRUE      0.593     0.407   177        0.354

``` r
slope_summ <- all_lin %>%
  group_by(currency, signif, win, lose) %>%
  summarize(mean_slope = mean(slope)) %>%
  ungroup() %>%
  filter(signif)

print(slope_summ)
```

    ## # A tibble: 6 x 5
    ##   currency    signif win   lose  mean_slope
    ##   <chr>       <lgl>  <lgl> <lgl>      <dbl>
    ## 1 energy      TRUE   FALSE TRUE     -0.0976
    ## 2 energy      TRUE   TRUE  FALSE     0.0959
    ## 3 individuals TRUE   FALSE TRUE     -0.106 
    ## 4 individuals TRUE   TRUE  FALSE     0.108 
    ## 5 mass        TRUE   FALSE TRUE     -0.0913
    ## 6 mass        TRUE   TRUE  FALSE     0.0897

Run with **500** communities.

#### Individuals

  - 50% of slopes are not significant to .05
  - Of those that are, **26% are increasing** and **74% are decreasing**

#### Energy

  - 60% not significant
  - Of those that are, 49/52% increasing/decreasing

#### Mass

  - 65% not significant
  - Of those that are, 60% increasing and 40% decreasing
