#' Print a representation of the power flow to the console
#'
#' @param x sunsynkr power flow
#'
#' @return
#' @export
#'
#' @examples
print.sunsynkr_flow <- function(x) {

  # Get battery details
  batt_w <- x$data$battPower |> 
    stringr::str_pad(4, "left")
  
  batt_flow <- dplyr::case_when( x$data$toBat ~ "<", 
                                 !x$data$toBat ~ ">",
                                 .default   = "-")
  
  
  soc <- x$data$soc
  
  # Get PV details
  pv_w <- x$data$pvPower |> 
    stringr::str_pad(4, "left")
  
  pv_flow <- dplyr::case_when(x$data$pvTo ~ ">", 
                              .default = "-")
  
  
  # Get grid details
  grid_w <- x$data$gridOrMeterPower |> 
    stringr::str_pad(4, "left")
  
  grid_flow <- dplyr::case_when( x$data$toGrid ~ ">", 
                                 !x$data$toGrid ~ "<",
                                 .default = "-")
  
  
  # Get load details
  load_w <- x$data$loadOrEpsPower |>
    stringr::str_pad(4, "left")
  
  load_flow <- dplyr::case_when(x$data$toLoad ~ ">", 
                                .default = "-")
  
  
  
  cat("  PV ", 
      pv_w, 
      "W --", 
      pv_flow, 
      "--                --", 
      grid_flow, 
      "-- ", 
      grid_w, 
      "W Grid\n",
      "               |    -------     |\n",
      "               --", 
      pv_flow, 
      "--|     |--", 
      grid_flow, "--\n", 
      "                    | Inv |\n",
      "               --", 
      batt_flow, 
      "--|     |--", 
      load_flow,
      "--\n", 
      "               |    -------     |\n", 
      "BATT ", 
      batt_w, 
      "W --", 
      batt_flow, 
      "--                --", 
      load_flow, 
      "-- ", 
      load_w, 
      "W Load\n", 
      "     (", soc, "%)\n", 
      sep = ""
  )
  
}