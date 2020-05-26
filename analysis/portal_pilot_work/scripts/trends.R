
pull_sv_ts <- function(some_ts, treat = "control", currency = "total_abund") {
  a_ts = filter(some_ts, treatment ==  treat) %>%
    select(year, eval(currency)) %>%
    rename(time = year,
           response =  eval(currency))
}

pull_pop_ts <-  function(some_ts, currency = "total_abund", sp = "BA") {
  a_ts = filter(some_ts, species == sp) %>%
    select(year, eval(currency)) %>%
    rename(time = year,
           response =  eval(currency))
}

bt_trend <- function(a_ts) {

  if(sum(a_ts$response > 0) < 3) {
    return(NA)
  }

  ts_start <- min(which(a_ts$response > 0))
  ts_stop <- max(which(a_ts$response > 0))

  a_ts <- a_ts[ ts_start:ts_stop, ]


  a_ts = a_ts %>%
    mutate(response = scale(sqrt(response)))

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

nonlinear_trend <- function(a_ts) {

  if(sum(a_ts$response > 0) < 3) {
    return(NA)
  }

  ts_start <- min(which(a_ts$response > 0))
  ts_stop <- max(which(a_ts$response > 0))

  a_ts <- a_ts[ ts_start:ts_stop, ]


  a_ts = a_ts %>%
    mutate(response = scale(sqrt(response)))

  ts_nls = nls(data = a_ts, formula = response ~ time)

  ts_slope = ts_lm$coefficients[2]
  ts_p = unlist(anova(ts_lm)[[5]])[1]
  ts_r2 = summary(ts_lm)$r.squared

  return(data.frame(
    slope = ts_slope,
    p = ts_p,
    r2 = ts_r2,
    method = "nonlinear"
  ))
}
