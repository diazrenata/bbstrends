get_bbs_totalabund <- function(a_bbs) {
  return(data.frame(
    timestep = a_bbs$covariates[ , a_bbs$metadata$timename],
    totalabund = rowSums(a_bbs$abundance),
    route = a_bbs$metadata$route,
    region = a_bbs$metadata$region
  ))
}
