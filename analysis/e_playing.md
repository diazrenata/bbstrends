Summary Report
================
Ren
2020-06-08

``` r
loadd(sv_bbs_rtrg_1_4)
loadd(sv_energy_bbs_rtrg_1_4)

head(sv_energy_bbs_rtrg_1_4)
```

    ##   time response currency route region
    ## 1    1 142382.2   energy     1      4
    ## 2    2 133722.1   energy     1      4
    ## 3    3 149624.2   energy     1      4
    ## 4    4 177016.3   energy     1      4
    ## 5    5 181000.7   energy     1      4
    ## 6    6 271055.6   energy     1      4

``` r
energy <- sv_energy_bbs_rtrg_1_4 %>%
  rename(energy = response) %>%
  select(time, energy)

abund <- sv_bbs_rtrg_1_4 %>%
  rename(abund = response) %>%
  select(time, abund)

both <- left_join(energy, abund) %>%
  mutate(mean_e = energy / abund) %>%
  mutate(energy = scale((energy)),
         abund = scale((abund)),
         mean_e = scale(mean_e))
```

    ## Joining, by = "time"

``` r
ggplot(both, aes(time, abund)) +
  geom_line() +
  geom_line(aes(time, energy), color = "blue")
```

![](e_playing_files/figure-gfm/load%20a%20ts-1.png)<!-- -->

``` r
ggplot(both, aes(time, mean_e)) +
  geom_line()
```

![](e_playing_files/figure-gfm/load%20a%20ts-2.png)<!-- -->

``` r
n_lm <- lm(abund ~ time, both)
summary(n_lm)
```

    ## 
    ## Call:
    ## lm(formula = abund ~ time, data = both)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -1.1748 -0.6026 -0.2838  0.4227  1.9234 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept)  0.93424    0.44619   2.094   0.0537 .
    ## time        -0.10380    0.04354  -2.384   0.0308 *
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.8795 on 15 degrees of freedom
    ## Multiple R-squared:  0.2748, Adjusted R-squared:  0.2264 
    ## F-statistic: 5.683 on 1 and 15 DF,  p-value: 0.03078

``` r
plot(n_lm)
```

![](e_playing_files/figure-gfm/load%20a%20ts-3.png)<!-- -->![](e_playing_files/figure-gfm/load%20a%20ts-4.png)<!-- -->![](e_playing_files/figure-gfm/load%20a%20ts-5.png)<!-- -->![](e_playing_files/figure-gfm/load%20a%20ts-6.png)<!-- -->

``` r
e_lm <- lm(energy ~ time, both)
plot(e_lm)
```

![](e_playing_files/figure-gfm/load%20a%20ts-7.png)<!-- -->![](e_playing_files/figure-gfm/load%20a%20ts-8.png)<!-- -->![](e_playing_files/figure-gfm/load%20a%20ts-9.png)<!-- -->![](e_playing_files/figure-gfm/load%20a%20ts-10.png)<!-- -->

``` r
summary(e_lm)
```

    ## 
    ## Call:
    ## lm(formula = energy ~ time, data = both)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -0.9989 -0.5941 -0.1251  0.4018  2.5607 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept)  0.82556    0.46434   1.778   0.0957 .
    ## time        -0.09173    0.04531  -2.024   0.0611 .
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.9153 on 15 degrees of freedom
    ## Multiple R-squared:  0.2146, Adjusted R-squared:  0.1622 
    ## F-statistic: 4.098 on 1 and 15 DF,  p-value: 0.06113

``` r
mean_e_lm <- lm(mean_e ~ time, both) 
plot(mean_e_lm)
```

![](e_playing_files/figure-gfm/load%20a%20ts-11.png)<!-- -->![](e_playing_files/figure-gfm/load%20a%20ts-12.png)<!-- -->![](e_playing_files/figure-gfm/load%20a%20ts-13.png)<!-- -->![](e_playing_files/figure-gfm/load%20a%20ts-14.png)<!-- -->

``` r
summary(mean_e_lm)
```

    ## 
    ## Call:
    ## lm(formula = mean_e ~ time, data = both)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.77552 -0.68236  0.06128  0.49232  1.72301 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)
    ## (Intercept) -0.38988    0.51125  -0.763    0.458
    ## time         0.04332    0.04989   0.868    0.399
    ## 
    ## Residual standard error: 1.008 on 15 degrees of freedom
    ## Multiple R-squared:  0.04785,    Adjusted R-squared:  -0.01562 
    ## F-statistic: 0.7539 on 1 and 15 DF,  p-value: 0.3989

``` r
compare <- both %>%
  select(time, energy, abund) %>%
  tidyr::pivot_longer(-time, names_to = "currency")

head(compare)
```

    ## # A tibble: 6 x 3
    ##    time currency value[,1]
    ##   <int> <chr>        <dbl>
    ## 1     1 energy     -0.118 
    ## 2     1 abund       0.228 
    ## 3     2 energy     -0.316 
    ## 4     2 abund      -0.448 
    ## 5     3 energy      0.0485
    ## 6     3 abund      -0.0342

``` r
ggplot(compare, aes(time, value, color =  currency)) +
  geom_line() +
  geom_smooth(method = "lm")
```

    ## `geom_smooth()` using formula 'y ~ x'

![](e_playing_files/figure-gfm/compare%20currency%20slopes-1.png)<!-- -->

``` r
c_lm <- lm(value ~ time * currency, compare)

plot(c_lm)
```

![](e_playing_files/figure-gfm/compare%20currency%20slopes-2.png)<!-- -->![](e_playing_files/figure-gfm/compare%20currency%20slopes-3.png)<!-- -->![](e_playing_files/figure-gfm/compare%20currency%20slopes-4.png)<!-- -->![](e_playing_files/figure-gfm/compare%20currency%20slopes-5.png)<!-- -->

``` r
summary(c_lm)
```

    ## 
    ## Call:
    ## lm(formula = value ~ time * currency, data = compare)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -1.1748 -0.6005 -0.2601  0.4175  2.5607 
    ## 
    ## Coefficients:
    ##                     Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept)          0.93424    0.45535   2.052   0.0490 *
    ## time                -0.10380    0.04444  -2.336   0.0264 *
    ## currencyenergy      -0.10868    0.64397  -0.169   0.8671  
    ## time:currencyenergy  0.01208    0.06284   0.192   0.8489  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.8976 on 30 degrees of freedom
    ## Multiple R-squared:  0.2447, Adjusted R-squared:  0.1691 
    ## F-statistic: 3.239 on 3 and 30 DF,  p-value: 0.03586

## Rats

``` r
annualrats = read.csv(here::here("analysis", "portal_pilot_work", "data", "portal_rats_sv.csv"), stringsAsFactors = F)

annualrats <- filter(annualrats, treatment == "control") %>%
  mutate(time = row_number(),
         energy = scale(total_energy),
         abund = scale(total_abund)) %>%
  select(time, energy, abund) %>%
  tidyr::pivot_longer(-time, names_to = "currency")

head(annualrats)
```

    ## # A tibble: 6 x 3
    ##    time currency value[,1]
    ##   <int> <chr>        <dbl>
    ## 1     1 energy      -1.51 
    ## 2     1 abund       -1.60 
    ## 3     2 energy       0.604
    ## 4     2 abund       -0.254
    ## 5     3 energy       0.669
    ## 6     3 abund       -0.217

``` r
ggplot(annualrats, aes(time, value, color =  currency)) +
  geom_line() +
  geom_smooth(method = "lm")
```

    ## `geom_smooth()` using formula 'y ~ x'

![](e_playing_files/figure-gfm/load%20rats-1.png)<!-- -->

``` r
ar_lm <- lm(value ~ time * currency, annualrats)

plot(ar_lm)
```

![](e_playing_files/figure-gfm/load%20rats-2.png)<!-- -->![](e_playing_files/figure-gfm/load%20rats-3.png)<!-- -->![](e_playing_files/figure-gfm/load%20rats-4.png)<!-- -->![](e_playing_files/figure-gfm/load%20rats-5.png)<!-- -->

``` r
summary(ar_lm)
```

    ## 
    ## Call:
    ## lm(formula = value ~ time * currency, data = annualrats)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -1.6382 -0.7040 -0.1915  0.5754  2.8001 
    ## 
    ## Coefficients:
    ##                     Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept)         -0.57643    0.31751  -1.815   0.0734 .
    ## time                 0.02812    0.01350   2.083   0.0406 *
    ## currencyenergy       0.59609    0.44903   1.328   0.1883  
    ## time:currencyenergy -0.02908    0.01909  -1.524   0.1318  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.9853 on 76 degrees of freedom
    ## Multiple R-squared:  0.05409,    Adjusted R-squared:  0.01675 
    ## F-statistic: 1.449 on 3 and 76 DF,  p-value: 0.2353
