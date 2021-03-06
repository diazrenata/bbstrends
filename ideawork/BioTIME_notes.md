__Assemblage time series reveal biodiversity change but not systematic loss - 2014__

“We measured temporal alpha diversity with 10 metrics, including species richness….”

“Surprisingly, we did not detect a consistent negative trend in species richness or in any of the other metrics of alpha diversity. The overall slope (estimated by allowing each study to have a different intercept, but constraining all studies to have the same slope) is statistically indistinguishable from zero. However, not all data sets have constant species richness. In a mixed model in which both the slope and the intercept are allowed to vary for each time series, slopes for species richness differ among assemblages, but do not exhibit systematic deviations. The variation cancels out because there are approximately equal numbers of negative and positive slopes, and the distribution of slopes is centered around zero, with the majority of slopes being statistically very close to zero.”

These are slopes of __species richness.__

__Community-level regulation of temporal trends in biodiversity – 2017__

ADF tests for regulation v. random walk; interpreting based on p-value and z score. Find most communities score as statistically significantly stationary. “Regulation: constant mean and variance in N or S with autocorrelation that decays quickly to 0. The null is an unconstrained random walk leading to nonconstant variance.”

__Stationarity does not mean static__. It means it returns to the trajectory following perturbation, instead of random walking. Trend stationary timeseries can still be moving. They provide a table in the supplement that has qualitatively similar results for ADFs with trends vs. just means, but no description of what the trends are like (magnitude). 

ADF text in supplement: 

"Number of significant (P < 0.05 and non-significant (NS) test results for assemblage-level regulation of species Richness or abundance. The ADF0 test assumes no deterministic trends in the data, whereas the ADF1 test accounts for linear trends. Tests are repeated with the Benjamini and Hochberg (53)adjustment for the False Discovery Rate (FDR). Counts of species and total abundance were untransformed" 

Some interesting logic in the supplement: 

* Suggest no portfolio effect, because the strength (zscore of probability value) of ADF test was uncorrelated with richness, total abundance, or nb observations in the ts
* No real correlation w temperature, which is their best proxy for environmental tracking
* Variance ratio test for compensatory fluctuations in N. “In a regulated assemblage, the variance ratio (variance of the sum of abundances to the sum of the variances of abundances) should be significantly <1 when the average pairwise covariation in abundances is negative. Only 2/59 assemblages showed compensatory fluctuations in N (observed variance ratio smaller than expected by chance). 

* From Box 1: “These measures form the basis for variance ratio tests for compensatory fluctuations, compared to a null hypothesis of species independence (23, 24). These tests are based on randomization of observed abundance or species richness data collected through time, so they assume that the source pool is constant and that population processes (colonization, extinction, and changes in abundance) do not change through time.”
* From discussion: “For most of these communities, the dominant fraction of change came from species turnover, which could lead to stationary distributions of species richness and total abundance (Fig. 2, blue fraction). However, most communities also contained some component of beta diversity attributed to a change in species richness (Fig. 2, green fraction), which may have obscured the signature of regulation in statistical tests for compensatory fluctuations”
* So this is a highly specific and kind of arcane kind of “compensatory fluctuation” and not what I mean by it. I believe this is the “compensatory dynamics” in the 2007 paper, though. 

I do not understand the flowchart in the supplement. 

__A balance of winners and losers in the Anthropocene__

For populations

“With the data on which to calculate a trend line identified for each population, we first applied a square-root transformation to the population data. This transformation stabilizes the variance and is appropriate for models in which population size is determined by some kind of Poisson process. This transformation accommodates 0 s and avoids the distortions that arise from a ln(x + 1) transformation (McArdle & Anderson 2001). Next, we used the ‘scale‘ function in R to rescale each data set so that it had a mean of 0 and a standard deviation of 1. This transformation put all time series into common units that are more appropriate for comparisons of taxa with disparate body sizes, such as vertebrates and plankton. Finally, we fit an ordinary least squares regression line through the transformed data and calculated the slope and its statistical significance (one-tailed test). Note that Pvalues calculated in this way are identical to P-values that would be obtained before the scaling transformation.”


__Some overall commentary on the BioTIME work__

I find it puzzling that they have not put out an analysis of *trends* in total abundance? This would seem a logical thing to ask about, especially since they have published on *population level trends* and *regulation in total abundance*.


