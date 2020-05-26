#' Get state variable TS
#'
#' @param a_dataset a MATSS dataset
#' @param currency individuals or energy
#'
#' @return dataframe of time and aggregate variable
#' @export
#'
get_sv_ts <- function(a_dataset, currency = "individuals") {

  if(currency == "individuals") {

    sv <- rowSums(a_dataset$abundance)

  }

  return(data.frame(time = 1:length(sv),
                    response = sv))

}

#' Get a species level TS
#'
#' @param abund_table for abundance or energy
#' @param species_index which column
#'
#' @return dataframe of time and population
#' @export
#'
get_species_ts <- function(abund_table, species_index) {

  return(data.frame(time = 1:nrow(abund_table),
                    response = unlist(abund_table[, species_index]),
                    species = as.character(colnames(abund_table)[species_index]),
                  stringsAsFactors = F))

}


#' Get species level TSs for a community
#'
#' @param a_dataset a MATSS dataset
#' @param currency individuals or energy
#'
#' @return list of dataframes of time and population
#' @export
#'
get_all_species_ts <- function(a_dataset, currency = "individuals") {

  if(currency == "individuals") {

    ts_s <- lapply(1:ncol(a_dataset$abundance), FUN = get_species_ts, abund_table = a_dataset$abundance)

  }

  return(ts_s)

}
