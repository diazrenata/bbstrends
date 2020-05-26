#' Fit linear trend
#'
#' @param a_ts columns for time and response
#'
#' @return data frame of slope, p value, and r2 for ols fit to scaled response
#' @export
#'
#' @importFrom dplyr mutate
linear_trend <- function(a_ts) {

  if(sum(a_ts$response > 0) < 3) {
    return(NA)
  }

  ts_start <- min(which(a_ts$response > 0))
  ts_stop <- max(which(a_ts$response > 0))

  a_ts <- a_ts[ ts_start:ts_stop, ]

  if(min(a_ts$response) == max(a_ts$response)) {
    return(NA)
  }


  a_ts = a_ts %>%
    dplyr::mutate(response = scale(sqrt(response)))

  ts_lm = lm(a_ts, formula = response ~ time)

  ts_slope = ts_lm$coefficients[2]
  ts_p = unlist(anova(ts_lm)[[5]])[1]
  ts_r2 = summary(ts_lm)$r.squared

  return(data.frame(
    slope = ts_slope,
    p = ts_p,
    r2 = ts_r2,
    method = "linear"
  ))
}


#' Fit linear trend to all populations in a community
#'
#' @param a_dataset columns for time and response
#' @param currency ind or energy
#'
#' @return data frame of slope, p value, and r2 for ols fit to scaled response for all populations
#' @export
#'
#' @importFrom dplyr bind_rows
linear_trend_populations <- function(a_dataset, currency = "individuals") {

  populations <- get_all_species_ts(a_dataset, currency = currency)

  trends <- lapply(populations, FUN = linear_trend)

  names(trends) <- colnames(a_dataset$abundance)

  trends <- trends[ which(!is.na(trends))]

  trends <- dplyr::bind_rows(trends, .id = 'species')

  return(trends)
}
