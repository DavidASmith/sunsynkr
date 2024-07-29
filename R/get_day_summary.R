#' Get day summary as a list
#'
#' @param token Authorisation token.
#' @param plant_id Plant id.
#' @param date Date in format YYYY-MM-DD
#'
#' @return List
#' @export
#'
#' @examples
get_day_summary <- function(token, plant_id, date) {
  
  url <- paste0("https://api.sunsynk.net/api/v1/plant/energy/", 
                plant_id, 
                "/day?lan=en&date=", 
                date, 
                "&id=", 
                plant_id)
  
  req <- httr2::request(url) |> 
    httr2::req_headers(authorization = paste0("Bearer ", token$data$access_token))
  
  res <- req |> 
    httr2::req_perform()
  
  res <- res |> 
    httr2::resp_body_json()
  
  class(res) <- "sunsynkr_day_summary"
  
  res
  
}