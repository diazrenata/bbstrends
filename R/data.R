#' Get state variable TS
#'
#' @param a_dataset a MATSS dataset
#'
#' @return dataframe of time and aggregate variable
#' @export
#'
get_sv_ts <- function(a_dataset) {


    sv <- rowSums(a_dataset$abundance)

  if(!is.character(a_dataset$metadata$currency)) {
    currency <- "individuals"
  } else {
    currency <- a_dataset$metadata$currency
  }

  return(data.frame(time = 1:length(sv),
                    response = sv,
                    currency = currency,
                    stringsAsFactors = F))

}

#' Get a species level TS
#'
#' @param abund_table for abundance or energy
#' @param species_index which column
#' @param currency individuals, energy, or mass
#'
#' @return dataframe of time and population
#' @export
#'
get_species_ts <- function(abund_table, species_index, currency) {

  return(data.frame(time = 1:nrow(abund_table),
                    response = unlist(abund_table[, species_index]),
                    species = as.character(colnames(abund_table)[species_index]),
                    currency = currency,
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
    ts_s <- lapply(1:ncol(a_dataset$abundance), FUN = get_species_ts, abund_table = a_dataset$abundance, currency = currency)


  return(ts_s)

}
