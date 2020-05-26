
bt_adf <- function(a_ts) {

  if(sum(a_ts$response > 0) < 3) {
    return(NA)
  }

  ts_start <- min(which(a_ts$response > 0))
  ts_stop <- max(which(a_ts$response > 0))

  a_ts <- a_ts[ ts_start:ts_stop, ]

  ts_adf <- tseries::adf.test(a_ts$response)

  ts_p = ts_adf$p.value
  ts_stat = ts_adf$statistic

  return(data.frame(
    p = ts_p,
    stat = ts_stat
  ))
}
