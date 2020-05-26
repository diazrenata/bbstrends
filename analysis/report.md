Summary Report
================
Author
2020-05-26

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
  geom_histogram() + theme_bw() + 
  geom_density(alpha = 0)
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](report_files/figure-gfm/slope%20and%20p%20hists-1.png)<!-- -->

``` r
ggplot(all_lin, aes(x = slope)) +
  geom_histogram() + theme_bw() + 
  facet_wrap(vars(signif))
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](report_files/figure-gfm/slope%20and%20p%20hists-2.png)<!-- -->

``` r
ggplot(all_lin, aes(x = slope, y = p, size = r2)) +
  geom_point() + theme_bw() + 
  geom_hline(yintercept = .05)
```

![](report_files/figure-gfm/slope%20and%20p%20hists-3.png)<!-- -->

``` r
lin_sum <- all_lin %>%
  group_by(signif) %>%
  summarize(prop_win = mean(win),
            prop_lose = mean(lose),
            n = dplyr::n()) %>%
  ungroup() %>%
  mutate(prop_overall = n / sum(n))

print(lin_sum)
```

    ## # A tibble: 2 x 5
    ##   signif prop_win prop_lose     n prop_overall
    ##   <lgl>     <dbl>     <dbl> <int>        <dbl>
    ## 1 FALSE     0.357     0.643    56         0.56
    ## 2 TRUE      0.295     0.705    44         0.44

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
  geom_density(alpha = 0)
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](report_files/figure-gfm/load%20pop-1.png)<!-- -->

``` r
ggplot(all_pop_lin, aes(x = slope)) +
  geom_histogram() + theme_bw() + 
  facet_wrap(vars(signif), scales = "free_y")
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](report_files/figure-gfm/load%20pop-2.png)<!-- -->

``` r
ggplot(all_pop_lin, aes(x = slope, y = p, size = r2)) +
  geom_point() + theme_bw() + 
  geom_hline(yintercept = .05)
```

![](report_files/figure-gfm/load%20pop-3.png)<!-- -->

``` r
lin_pop_sum <- all_pop_lin %>%
  group_by(signif) %>%
  summarize(prop_win = mean(win),
            prop_lose = mean(lose),
            n = dplyr::n()) %>%
  ungroup() %>%
  mutate(prop_overall = n / sum(n))

print(lin_pop_sum)
```

    ## # A tibble: 2 x 5
    ##   signif prop_win prop_lose     n prop_overall
    ##   <lgl>     <dbl>     <dbl> <int>        <dbl>
    ## 1 FALSE     0.466     0.532  4203        0.754
    ## 2 TRUE      0.429     0.571  1372        0.246

Run with 100 communities,

  - 75% of slopes are nonsignificant
  - Of those that are significant, 43% are increasing and 57% are
    decreasing.
