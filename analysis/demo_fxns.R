#' Make scaled kde
#'
#' @param sbsd Wgt vector
#' @param min_size minimum range for kde
#' @param max_size max range for kde
#' @param npoints nb eval points, specify to powers of 2
#'
#' @return scaled probability density
#' @export
#'
make_kde <- function(sbsd, min_size, max_size, npoints) {

  raw_kde <- density(sbsd, from = min_size, to = max_size, n = npoints)$y

  scaled_kde <- raw_kde / sum(raw_kde)

  return(scaled_kde)

}

pair_overlap <- function(species_vects, min_size, max_size, npoints) {

  kdes <- lapply(species_vects, FUN = make_kde, npoints = npoints, min_size = min_size, max_size = max_size)

  kdes_df <- dplyr::bind_cols(kdes) %>%
    dplyr::mutate(index = dplyr::row_number())  %>%
    dplyr:: group_by(index) %>%
    dplyr::mutate(min_density = min(sp1, sp2)) %>%
    dplyr::ungroup() %>%
    dplyr::select(-index)

  overlap_val <- sum(kdes_df$min_density)

  return(overlap_val)

}
