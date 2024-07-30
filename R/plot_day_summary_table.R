#' Plots the sunsynkr daily summary table
#'
#' @param x susynkr daily summary table.
#' @param ... Required for S3 generics.
#'
#' @return ggplot2 plot
#' @export
#'
#' @examples
#' \dontrun{
#' plot(sunsynkr_day_summary_table)
#' }
plot.sunsynkr_day_summary_table <- function(x, ...) {
  
  x |> 
    tidyr::pivot_longer(-.data$dt) |> 
    ggplot2::ggplot(ggplot2::aes(.data$dt, .data$value)) + 
    ggplot2::geom_line() + 
    ggplot2::facet_wrap(~name, 
                        ncol = 1, 
                        scales = "free_y")
  
  
}