Summary Report
================
Author
2020-06-01

## Aggregate

``` r
loadd(all_lin)
```

``` r
all_lin_wide <- all_lin %>%
  mutate(rtrg = paste0(route, "_", region)) %>%
  select(slope, p, currency, rtrg) %>%
  tidyr::pivot_wider(names_from = currency, values_from= c(slope, p)) %>%
  mutate(which_signif = NA,
         n_sig = p_individuals < 0.05,
         e_sig = p_energy < 0.05) 

for(i in 1:nrow(all_lin_wide)) {
  
  e_sig <- all_lin_wide$e_sig[i]
  n_sig <- all_lin_wide$n_sig[i] 
  
  if(all(e_sig, n_sig)) {
    all_lin_wide$which_signif[i] <- "both"
  } else if(e_sig) {
    all_lin_wide$which_signif[i] <- "energy"
  } else if(n_sig) {
    all_lin_wide$which_signif[i] <- "individuals"
  } else {
    all_lin_wide$which_signif[i] <- "none"
  }
  
}

ggplot(all_lin_wide, aes(x = slope_individuals, y = slope_energy, color = which_signif)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0) +
  theme_bw() +
  facet_wrap(vars(n_sig))
```

![](report_trades_files/figure-gfm/all%20lin%20wide-1.png)<!-- -->

There’s something here I don’t quite know how to get at.

``` r
# If individuals is changing, how often is energy also changing vs not sig?

all_lin_wide %>%
  group_by(n_sig) %>%
  summarize(prop_e_sig = mean(e_sig)) %>%
  ungroup()
```

    ## # A tibble: 2 x 2
    ##   n_sig prop_e_sig
    ##   <lgl>      <dbl>
    ## 1 FALSE     0.0714
    ## 2 TRUE      0.682

``` r
ggplot(all_lin_wide, aes(x = slope_individuals, y = slope_energy, color = p_mean_e < .05)) +
  geom_point() +
  theme_bw() +
  scale_color_viridis_d() +
  facet_wrap(vars(which_signif))
```

![](report_trades_files/figure-gfm/mean%20e%20stuff-1.png)<!-- -->

``` r
ggplot(all_lin_wide, aes(x = p_individuals, y = p_mean_e)) +
  geom_point() +
  geom_hline(yintercept = .05) +
  geom_vline(xintercept = .05) +
  theme_bw()
```

![](report_trades_files/figure-gfm/mean%20e%20stuff-2.png)<!-- -->
