State variable level
================
Renata Diaz
2020-05-22

``` r
annualrats = read.csv(here::here("analysis", "portal_pilot_work", "data", "portal_rats_sv.csv"), stringsAsFactors = F)

ggplot(annualrats, aes(x = year, y = total_abund, group = treatment, color = treatment)) +
  geom_line() +
  geom_smooth(method = "lm", se = F) +
  facet_wrap(vars(treatment), scales = "free_y") +
  theme_bw()
```

    ## `geom_smooth()` using formula 'y ~ x'

![](rats_files/figure-gfm/portal%20rodents%20ts-1.png)<!-- -->

``` r
ggplot(annualrats, aes(x = year, y = total_energy, group = treatment, color = treatment)) +
  geom_line() +
  geom_smooth(method = "lm", se = F) +
  facet_wrap(vars(treatment), scales = "free_y") +
  theme_bw()
```

    ## `geom_smooth()` using formula 'y ~ x'

![](rats_files/figure-gfm/portal%20rodents%20ts-2.png)<!-- -->
