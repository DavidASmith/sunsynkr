#' Print details of Sunsynkr token
#'
#' @param x An object of class `sunsynkr_token`.
#' @param ... Required for S3 generics.
#'
#' @return Prints details of the token to the console.
#' @export
#'
#' @examples
#' \dontrun{
#' print(token)
#' }
print.sunsynkr_token <- function(x, ...) {
  
  cat("Sunsynk API token - ", x$msg, " \n", 
      "Type:  ", x$data$token_type, "\n", 
      "Scope: ", x$data$scope, "\n", 
      sep = "")
  
}