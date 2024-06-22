#' Converts a daily summary 'infos' item to a dataframe 
#'
#' @param x Daily summary
#' @param date Date to be pre-pended to the time to form a date/time field. 
#'
#' @return data.frame
#' @export
#'
#' @examples
day_summary_info_to_col <- function(x, date) {
  
  label <- x$label
  unit <- x$unit
  
  col_name <- paste0(label,"_", unit) |> tolower()
  
  out <- x$records |> 
    lapply(function(x) tibble::tibble(dt = x$time, value = x$value)) |>
    dplyr::bind_rows() |>
    dplyr::mutate(dt = paste0(date, " ", dt)) |>
    dplyr::mutate(dt = lubridate::ymd_hm(dt)) |>
    dplyr::mutate(value = as.numeric(value)) |> 
    dplyr::rename(!!rlang::as_name(col_name) := value)
  
  out
  
}
