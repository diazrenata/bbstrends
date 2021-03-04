BBS route that goes by Hartland
================

### Load specific route

The New Hartford route goes up and down Riverton Road and was started in
1994. It feels pretty auspicious. It is route 102, region 18.

    ## Loading in data version 2.49.0

## ISD

Using the logarithm of mass.

![](gam_on_isd_overlap_portal_files/figure-gfm/isd-1.png)<!-- -->![](gam_on_isd_overlap_portal_files/figure-gfm/isd-2.png)<!-- -->![](gam_on_isd_overlap_portal_files/figure-gfm/isd-3.png)<!-- -->

    ## Loading required package: nlme

    ## 
    ## Attaching package: 'nlme'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     collapse

    ## This is mgcv 1.8-33. For overview type 'help("mgcv-package")'.

![](gam_on_isd_overlap_portal_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->![](gam_on_isd_overlap_portal_files/figure-gfm/unnamed-chunk-1-2.png)<!-- -->![](gam_on_isd_overlap_portal_files/figure-gfm/unnamed-chunk-1-3.png)<!-- -->![](gam_on_isd_overlap_portal_files/figure-gfm/unnamed-chunk-1-4.png)<!-- -->![](gam_on_isd_overlap_portal_files/figure-gfm/unnamed-chunk-1-5.png)<!-- -->![](gam_on_isd_overlap_portal_files/figure-gfm/unnamed-chunk-1-6.png)<!-- -->

Questions:

1.  There’s a *significant* difference but what is the magnitude of it?

<!-- end list -->

    ## Joining, by = "row"

![](gam_on_isd_overlap_portal_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->![](gam_on_isd_overlap_portal_files/figure-gfm/unnamed-chunk-2-2.png)<!-- -->![](gam_on_isd_overlap_portal_files/figure-gfm/unnamed-chunk-2-3.png)<!-- -->

<div class="kable-table">

| draw |   overlap |
| :--- | --------: |
| 1    | 0.4000986 |
| 2    | 0.4148040 |
| 3    | 0.4080404 |
| 4    | 0.4057805 |
| 5    | 0.4428706 |
| 6    | 0.4163015 |
| 7    | 0.4057705 |
| 8    | 0.3704419 |
| 9    | 0.4030555 |
| 10   | 0.4002783 |

</div>

![](gam_on_isd_overlap_portal_files/figure-gfm/unnamed-chunk-2-4.png)<!-- -->

<div class="kable-table">

|  overlap |
| -------: |
| 0.607919 |

</div>

    ## `summarise()` has grouped output by 'log_size'. You can override using the `.groups` argument.

![](gam_on_isd_overlap_portal_files/figure-gfm/unnamed-chunk-2-5.png)<!-- -->![](gam_on_isd_overlap_portal_files/figure-gfm/unnamed-chunk-2-6.png)<!-- -->

    ## [1] 0.5947542
