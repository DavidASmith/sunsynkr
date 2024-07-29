#' Plots the sunsynkr daily summary table
#'
#' @param x susynkr daily summary table
#'
#' @return ggplot2 plot
#' @export
#'
#' @examples
plot.sunsynkr_day_summary_table <- function(x) {
  
  x |> 
    tidyr::pivot_longer(-dt) |> 
    ggplot(aes(dt, value)) + 
    geom_line() + 
    facet_wrap(~name, 
               ncol = 1, 
               scales = "free_y")
  
  
}