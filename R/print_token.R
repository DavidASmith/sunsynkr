#' Print details of Sunsynkr token
#'
#' @param sunsynkr token
#'
#' @return
#' @export
#'
#' @examples
print.sunsynkr_token <- function(x) {
  
  cat("Sunsynk API token - ", x$msg, " \n", 
      "Type:  ", x$data$token_type, "\n", 
      "Scope: ", x$data$scope, "\n", 
      sep = "")
  
}