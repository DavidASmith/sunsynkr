#' Print Sunsynk API plants
#'
#' @param x `sunsynkr_plants` object.
#' @param ... Required for S3 generics.
#'
#' @return A tibble of summary details for the `sunsynkr_plants` object.
#' @export
#'
#' @examples
#' \dontrun{
#' print(sunsynkr_plants)
#' }
print.sunsynkr_plants <- function(x, ...) {
  plant_info <- x$data$infos
  
  plant_info |> 
    lapply(function(x) tibble::tibble(id = x$id, 
                                      name = x$name, 
                                      address = x$address, 
                                      pac = x$pac, 
                                      etoday = x$etoday, 
                                      etotal = x$etotal, 
                                      update_at = x$updateAt)) |> 
    dplyr::bind_rows() |> 
    print()
  
}