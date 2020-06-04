#' Load a dataset from BBSSize
#'
#' @param dataset_name eg "bbs_rtrg_101_4"
#' @param datasets_dir where they are
#' @param currency "size" or "energy"
#'
#' @return dataset if it exists
#' @export
#'
get_size_dataset <- function(dataset_name, datasets_dir = "C:/Users/diaz.renata/Documents/GitHub/BBSsize/analysis/isd_data", currency) {


  dataset_file_name <- paste0(currency, "_", dataset_name, ".Rds")

  dataset_path <- file.path(datasets_dir, dataset_file_name)

  if(file.exists(dataset_path)) {
    return(readRDS(dataset_path))
  } else {
    return()
  }

}

#' Make a plan to get size datasets
#'
#' @param datasets_plan abund plan
#' @param datasets_dir where the size datasets live
#'
#' @return a plan
#' @export
#'
#' @importFrom drake drake_plan
#' @importFrom dplyr bind_rows
build_size_datasets_plan <- function(datasets_plan, datasets_dir =  "C:/Users/diaz.renata/Documents/GitHub/BBSsize/analysis/isd_data") {

  dataset_names <- datasets_plan$target

  size_files_exist <- vector(length = length(dataset_names))

  for(i in 1:length(dataset_names)) {

    energy_name <- file.path(datasets_dir, paste0( "energy_", dataset_names[i], ".Rds"))
    size_name <- file.path(datasets_dir, paste0( "size_", dataset_names[i], ".Rds"))


    size_files_exist[i] <- (
      file.exists(energy_name) && file.exists(size_name)
    )

  }

  dataset_names <- dataset_names[ which(size_files_exist)]

  new_datasets <- drake::drake_plan(
    size = target(get_size_dataset(dataset_name,
                                   datasets_dir = "C:/Users/diaz.renata/Documents/GitHub/BBSsize/analysis/isd_data",
                                   currency = "size"),
                  transform = map(
                    dataset_name =!!dataset_names
                  )),
    energy = target(get_size_dataset(dataset_name = dataset_name,
                                     datasets_dir = "C:/Users/diaz.renata/Documents/GitHub/BBSsize/analysis/isd_data",
                                     currency = "energy"),
                    transform = map(
                      dataset_name = !!dataset_names
                    ))
  )

  datasets_plan <- dplyr::bind_rows(
    datasets_plan[ which(size_files_exist), ],
    new_datasets
  )

  return(datasets_plan)
}

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


#' Scale state variable TS
#'
#' @param a_dataset a svS dataset
#'
#' @return dataframe of time and aggregate variable
#' @export
#'
scale_sv_ts <- function(a_dataset) {

 # a_dataset$response <- sqrt(a_dataset$response)
  a_dataset$response <- scale(a_dataset$response)

  return(a_dataset)

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
