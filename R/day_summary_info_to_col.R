#' Converts a daily summary 'infos' item to a dataframe 
#'
#' @param x Daily summary
#' @param date Date to be pre-pended to the time to form a date/time field. 
#' @param tz Timezone for the output time. Note that time returned by the API 
#' is in local time (including DST). It's likely that you'll want this set to 
#' your local timezone (the default). However, you can specify any timezone as 
#' required (use `OlsonNames()` to return all valid timezones for your system). 
#'
#' @return data.frame
#' @export
#'
#' @examples
#' \dontrun{
#' day_summary_info_to_col(x, "2024-07-30")
#' }
#' @importFrom rlang .data
#' @importFrom rlang := 
day_summary_info_to_col <- function(x, date, tz = Sys.timezone()) {
  
  label <- x$label
  unit <- x$unit
  
  col_name <- paste0(label,"_", unit) |> 
    tolower()
  
  out <- x$records |> 
    lapply(function(x) tibble::tibble(dt = x$time, value = x$value)) |>
    dplyr::bind_rows() |>
    dplyr::mutate(dt = paste0(date, " ", .data$dt)) |>
    dplyr::mutate(dt = lubridate::ymd_hm(.data$dt, tz = tz)) |>
    dplyr::mutate(value = as.numeric(.data$value)) |> 
    dplyr::rename(!!rlang::as_name(col_name) := .data$value)
  
  out
  
}
