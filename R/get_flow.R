#' Get current power flow information for a plant
#'
#' @param token Authorisation token.
#' @param plant_id Plant id.
#'
#' @return List.
#' @export
#'
#' @examples
get_flow <- function(token, 
                     plant_id) {
  
  url <- paste0("https://api.sunsynk.net/api/v1/plant/energy/", 
                plant_id, 
                "/flow")
  
  req <- httr2::request(url) |> 
    httr2::req_headers(authorization = paste0("Bearer ", 
                                              token$data$access_token))
  
  res <- req |> 
    httr2::req_perform()
  
  res <- res |> 
    httr2::resp_body_json()
  
  class(res) <- "sunsynkr_flow"
  
  res
}
