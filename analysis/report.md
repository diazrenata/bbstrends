Summary Report
================
Author
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

![](report_files/figure-gfm/slope%20and%20p%20hists-1.png)<!-- -->

``` r
ggplot(all_lin, aes(x = slope)) +
  geom_histogram() + theme_bw() + 
  facet_wrap(vars(currency, signif), scales = "free_y", ncol = 2) 
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](report_files/figure-gfm/slope%20and%20p%20hists-2.png)<!-- -->

``` r
# 
# ggplot(all_lin, aes(x = slope, y = p, size = r2)) +
#   geom_point() + theme_bw() + 
#   geom_hline(yintercept = .05) +
#   facet_wrap(vars(currency))
```

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

Run with 100 communities,

  - About 50% of slopes are significantly different from zero
  - Of those that are significantly different from zero, 70% are
    decreasing and 30% increasing.

## Populations

``` r
loadd(all_pop_lin)


all_pop_lin <- all_pop_lin %>%
  mutate(signif = p <= .05,
         win = slope > 0,
         lose = slope < 0)

ggplot(all_pop_lin, aes(x = slope)) +
  geom_histogram() + theme_bw() + 
  geom_density(alpha = 0) +
  facet_wrap(vars(currency), scales = "free_y")
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](report_files/figure-gfm/load%20pop-1.png)<!-- -->

``` r
ggplot(all_pop_lin, aes(x = slope)) +
  geom_histogram() + theme_bw() + 
  facet_wrap(vars(currency, signif), scales = "free_y", ncol = 2)
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](report_files/figure-gfm/load%20pop-2.png)<!-- -->

``` r
# 
# ggplot(all_pop_lin, aes(x = slope, y = p, size = r2)) +
#   geom_point() + theme_bw() + 
#   geom_hline(yintercept = .05) +
#   facet_wrap(vars(currency), scales = "free_y")

lin_pop_sum <- all_pop_lin %>%
  group_by(currency, signif) %>%
  summarize(prop_win = mean(win),
            prop_lose = mean(lose),
            n = dplyr::n()) %>%
  ungroup() %>%
  group_by(currency) %>%
  mutate(prop_overall = n / sum(n)) %>%
  ungroup()

print(lin_pop_sum)
```

    ## # A tibble: 6 x 6
    ##   currency    signif prop_win prop_lose     n prop_overall
    ##   <chr>       <lgl>     <dbl>     <dbl> <int>        <dbl>
    ## 1 energy      FALSE     0.475     0.525 24439        0.711
    ## 2 energy      TRUE      0.438     0.562  9939        0.289
    ## 3 individuals FALSE     0.472     0.526 24351        0.710
    ## 4 individuals TRUE      0.439     0.561  9970        0.290
    ## 5 mass        FALSE     0.475     0.525 24446        0.711
    ## 6 mass        TRUE      0.438     0.562  9932        0.289

Run with 100 communities,

  - 75% of slopes are nonsignificant
  - Of those that are significant, 43% are increasing and 57% are
    decreasing.
