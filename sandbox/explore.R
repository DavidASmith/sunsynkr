library(sunsynkr)
library(ggplot2)


# Authentication ----------------------------------------------------------

token <- get_token()
token


# Get plants info ----------------------------------------------------

plants <- get_plants(token)


# Redact personal info
redact_character <- function(x) {
  gsub("\\w", "X", x)
}

redact_plants <- function(x) {
  
  plant_infos <- x$data$infos
  
  redact_plant <- function(x) {
    x$id <- redact_character(x$id)
    x$name <- redact_character(x$name)
    x$thumbUrl <- redact_character(x$thumbUrl)
    x$address <- redact_character(x$address)
    x$email <- redact_character(x$email)
    x$phone <- redact_character(x$phone)
    x$masterId <- redact_character(x$masterId)
    
    x
  }
  
  x$data$infos <- lapply(plant_infos, redact_plant)
  
  x
  
}

plants |> 
  redact_plants() |> 
  unclass()

# Print plants

print_plants(plants)

plants |> 
  redact_plants() |> 
  print_plants()

# Get flow ----------------------------------------------------------------

plant_id <- plants$data$infos[[1]]$id


flow <- get_flow(token, 
                 plant_id)


flow


# Get day summary ---------------------------------------------------------

date <- "2024-06-21"

# get_day_summary <- function(token, plant_id, date) {
#   
#   url <- paste0("https://api.sunsynk.net/api/v1/plant/energy/", 
#                 plant_id, 
#                 "/day?lan=en&date=", 
#                 date, 
#                 "&id=", 
#                 plant_id)
#   
#   req <- httr2::request(url) |> 
#     httr2::req_headers(authorization = paste0("Bearer ", token$data$access_token))
#   
#   res <- req |> 
#     httr2::req_perform()
#   
#   res <- res |> 
#     httr2::resp_body_json()
#   
#   res
#   
# }

day_summary <- get_day_summary(token, 
                               plant_id, 
                               date)


infos <- day_summary$data$infos


# day_summary_info_to_col <- function(x) {
#   
#   label <- x$label
#   unit <- x$unit
#   
#   col_name <- paste0(label,"_", unit) |> tolower()
#   
#   out <- x$records |> 
#     lapply(function(x) tibble::tibble(dt = x$time, value = x$value)) |>
#     dplyr::bind_rows() |>
#     dplyr::mutate(dt = paste0(date, " ", dt)) |>
#     dplyr::mutate(dt = lubridate::ymd_hm(dt)) |>
#     dplyr::mutate(value = as.numeric(value)) |> 
#     dplyr::rename(!!quo_name(col_name) := value)
#   
#   out
#   
# }

day_summary_info_to_col(infos[[5]], date)


# Get and format daily summary
# get_day_summary_table <- function(token, plant_id, date) {
#   
#   day_summary <- get_day_summary(token, 
#                                  plant_id, 
#                                  date)
#   
#   
#   infos <- day_summary$data$infos
#   
#   out <- infos |> 
#     lapply(day_summary_info_to_col) |> 
#     purrr::reduce(dplyr::left_join, by = 'dt') |> 
#     dplyr::arrange(dt)
#   
#   out
# }

day_summary_table <- get_day_summary_table(token, plant_id, date)


# Plot daily summary


plot_day_summary_table(day_summary_table)

