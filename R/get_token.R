#' Get a token for authenticating to the Sunsynk API
#'
#' @return List
#' @export
#'
#' @examples get_token()
get_token <- function() {
  username <- Sys.getenv("SUNSYNK_USER")
  password <- Sys.getenv("SUNSYNK_PASS")
  
  url <- "https://api.sunsynk.net/oauth/token"
  
  # TODO? Headers to set before posting the request.
  #accept: application/json
  #content-type: application/json
  
  req_body <- list(areaCode = "sunsynk",
                   client_id =  "csp-web",
                   grant_type = "password",
                   password = password,
                   source = "sunsynk",
                   username = username)
  
  req <- httr2::request(url) |> 
    httr2::req_body_json(req_body)
  
  res <- req |> 
    httr2::req_perform()
  
  res <- res |> 
    httr2::resp_body_json()
  
  res
  
}
