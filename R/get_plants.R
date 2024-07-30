
#' Get details of power plants associated with a Sunsynk account
#'
#' @param token Authorisation token.
#'
#' @return List.
#' @export
#'
#' @examples
#' \dontrun{
#' get_plants(token)
#' }
get_plants <- function(token) {
  
  url <- "https://api.sunsynk.net/api/v1/plants?page=1&limit=100&name=&status="
  
  req <- httr2::request(url) |> 
    httr2::req_headers(authorization = paste0("Bearer ", 
                                              token$data$access_token))
  
  res <- req |> 
    httr2::req_perform()
  
  res <- res |> 
    httr2::resp_body_json()
  
  class(res) <- "sunsynkr_plants"
  
  res
  
}
