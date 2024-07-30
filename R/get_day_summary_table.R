#' Get a daily summary for a plant as a data.frame
#'
#' @param token Authorisation token
#' @param plant_id plant id
#' @param date Date for the summary (YYYY-MM-DD).
#'
#' @return A data.frame
#' @export
#'
#' @examples
#' \dontrun{
#' get_day_summary_table(token, 1, "2024-07-30")
#' }
get_day_summary_table <- function(token, plant_id, date) {
  
  day_summary <- get_day_summary(token, 
                                 plant_id, 
                                 date)
  
  
  infos <- day_summary$data$infos
  
  out <- infos |> 
    lapply(day_summary_info_to_col, 
           date = date) |> 
    purrr::reduce(dplyr::left_join, by = 'dt') |> 
    dplyr::arrange(.data$dt)
  
  class(out) <- append("sunsynkr_day_summary_table", class(out))
  
  out
}
