#' Get state variable TS
#'
#' @param a_dataset a MATSS dataset
#'
#' @return dataframe of time and aggregate variable
#' @export
#'
get_sv_ts <- function(a_dataset) {

if(!is.vector(a_dataset$abundance)) {
    sv <- rowSums(a_dataset$abundance)
} else {
  sv <- a_dataset$abundance
}
  if(!is.character(a_dataset$metadata$currency)) {
    currency <- "individuals"
  } else {
    currency <- a_dataset$metadata$currency
  }

  return(data.frame(time = 1:length(sv),
                    response = sv,
                    currency = currency,
                    route = a_dataset$metadata$route,
                    region = a_dataset$metadata$region,
                    stringsAsFactors = F))

}

#' Get mean E TS
#'
#' @param abund_ts abund
#' @param energy_ts energy
#'
#' @return MATSS dataset of mean variable
#' @export
#'
get_mean_e <- function(abund_ts, energy_ts) {


  n_sv <- rowSums(abund_ts$abundance)
  e_sv <- rowSums(energy_ts$abundance)

  mean_e = e_sv / n_sv

  energy_ts$abundance <- mean_e
  energy_ts$metadata$currency <- "mean_e"

  return(energy_ts)

}


#' Get a species level TS
#'
#' @param abund_table for abundance or energy
#' @param species_index which column
#' @param currency individuals, energy, or mass
#' @param route route
#' @param region region
#'
#' @return dataframe of time and population
#' @export
#'
get_species_ts <- function(abund_table, species_index, currency, route = NA, region = NA) {

  return(data.frame(time = 1:nrow(abund_table),
                    response = unlist(abund_table[, species_index]),
                    species = as.character(colnames(abund_table)[species_index]),
                    currency = currency,
                    route = route,
                    region = region,
                  stringsAsFactors = F))

}


#' Get species level TSs for a community
#'
#' @param a_dataset a MATSS dataset
#'
#' @return list of dataframes of time and population
#' @export
#'
get_all_species_ts <- function(a_dataset) {


  if(!is.character(a_dataset$metadata$currency)) {
    currency <- "individuals"
  } else {
    currency <- a_dataset$metadata$currency
  }

  route <- a_dataset$metadata$route
  region <- a_dataset$metadata$region

    ts_s <- lapply(1:ncol(a_dataset$abundance), FUN = get_species_ts,
                   abund_table = a_dataset$abundance,
                   currency = currency,
                   route = route,
                   region = region)


  return(ts_s)

}
