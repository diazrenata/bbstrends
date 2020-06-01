Summary Report
================
Author
2020-06-01

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

    ## # A tibble: 8 x 6
    ##   currency    signif prop_win prop_lose     n prop_overall
    ##   <chr>       <lgl>     <dbl>     <dbl> <int>        <dbl>
    ## 1 energy      FALSE     0.576     0.424    66        0.66 
    ## 2 energy      TRUE      0.353     0.647    34        0.34 
    ## 3 individuals FALSE     0.357     0.643    56        0.56 
    ## 4 individuals TRUE      0.295     0.705    44        0.44 
    ## 5 mass        FALSE     0.549     0.451    71        0.71 
    ## 6 mass        TRUE      0.552     0.448    29        0.290
    ## 7 mean_e      FALSE     0.5       0.5      56        0.56 
    ## 8 mean_e      TRUE      0.75      0.25     44        0.44

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
    ## 1 energy      FALSE     0.466     0.534  4223        0.756
    ## 2 energy      TRUE      0.433     0.567  1366        0.244
    ## 3 individuals FALSE     0.466     0.532  4203        0.754
    ## 4 individuals TRUE      0.429     0.571  1372        0.246
    ## 5 mass        FALSE     0.465     0.535  4220        0.755
    ## 6 mass        TRUE      0.434     0.566  1369        0.245

Run with 100 communities,

  - 75% of slopes are nonsignificant
  - Of those that are significant, 43% are increasing and 57% are
    decreasing.
