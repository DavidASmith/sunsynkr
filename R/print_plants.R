#' Print Sunsynk API plants
#'
#' @param x Sunsynkr plants
#'
#' @return A tibble of summary details for sunsynkr plants 
#' @export
#'
#' @examples
print_plants <- function(x) {
  plant_info <- x$data$infos
  
  plant_info |> 
    lapply(function(x) tibble::tibble(id = x$id, 
                                      name = x$name, 
                                      address = x$address, 
                                      pac = x$pac, 
                                      etoday = x$etoday, 
                                      etotal = x$etotal, 
                                      update_at = x$updateAt)) |> 
    dplyr::bind_rows()
  
}