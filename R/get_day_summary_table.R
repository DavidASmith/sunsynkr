#' Get a daily summary for a plant as a data.frame
#'
#' @param token Authorisation token
#' @param plant_id plant id
#' @param date Date for the summary (YYYY-MM-DD).
#' @param tz Timezone for the output time. Note that time returned by the API 
#' is in local time (including DST). It's likely that you'll want this set to 
#' your local timezone (the default). However, you can specify any timezone as 
#' required (use `OlsonNames()` to return all valid timezones for your system). 
#'
#' @return A data.frame
#' @export
#'
#' @examples
#' \dontrun{
#' get_day_summary_table(token, 1, "2024-07-30")
#' }
get_day_summary_table <- function(token, plant_id, date, tz = Sys.timezone()) {
  
  day_summary <- get_day_summary(token, 
                                 plant_id, 
                                 date)
  
  
  infos <- day_summary$data$infos
  
  out <- infos |> 
    lapply(day_summary_info_to_col, 
           date = date, 
           tz = tz) |> 
    purrr::reduce(dplyr::left_join, by = 'dt') |> 
    dplyr::arrange(.data$dt)
  
  class(out) <- append("sunsynkr_day_summary_table", class(out))
  
  out
}
