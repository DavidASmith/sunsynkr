library(ggplot2)


# Authentication ----------------------------------------------------------

token <- get_token()




# Get plants info ----------------------------------------------------

get_plants <- function(token) {
  
  url <- "https://api.sunsynk.net/api/v1/plants?page=1&limit=100&name=&status="
  
  req <- httr2::request(url) |> 
    httr2::req_headers(authorization = paste0("Bearer ", token$data$access_token))
  
  res <- req |> 
    httr2::req_perform()
  
  res <- res |> 
    httr2::resp_body_json()
  
  res
  
  
}

plants <- get_plants(token)
plants



# Get flow ----------------------------------------------------------------

plant_id <- plants$data$infos[[1]]$id

get_flow <- function(token, 
                     plant_id) {
  
  url <- paste0("https://api.sunsynk.net/api/v1/plant/energy/", 
                plant_id, 
                "/flow?date=", 
                date)
  
  url <- paste0("https://api.sunsynk.net/api/v1/plant/energy/", 
                plant_id, 
                "/flow")
  
  req <- httr2::request(url) |> 
    httr2::req_headers(authorization = paste0("Bearer ", token$data$access_token))
  
  res <- req |> 
    httr2::req_perform()
  
  res <- res |> 
    httr2::resp_body_json()
  
  res
}

flow <- get_flow(token, 
                 plant_id)



# Get day summary ---------------------------------------------------------

date <- "2024-05-21"

get_day_summary <- function(token, plant_id, date) {
  
  url <- paste0("https://api.sunsynk.net/api/v1/plant/energy/", 
                plant_id, 
                "/day?lan=en&date=", 
                date, 
                "&id=", 
                plant_id)
  
  req <- httr2::request(url) |> 
    httr2::req_headers(authorization = paste0("Bearer ", token$data$access_token))
  
  res <- req |> 
    httr2::req_perform()
  
  res <- res |> 
    httr2::resp_body_json()
  
  res
  
}

day_summary <- get_day_summary(token, 
                               plant_id, 
                               date)


infos <- day_summary$data$infos


day_summary_info_to_col <- function(x) {
  
  label <- x$label
  unit <- x$unit
  
  col_name <- paste0(label,"_", unit) |> tolower()
  
  out <- x$records |> 
    lapply(function(x) tibble::tibble(dt = x$time, value = x$value)) |>
    dplyr::bind_rows() |>
    dplyr::mutate(dt = paste0(date, " ", dt)) |>
    dplyr::mutate(dt = lubridate::ymd_hm(dt)) |>
    dplyr::mutate(value = as.numeric(value)) |> 
    dplyr::rename(!!quo_name(col_name) := value)
  
  out
  
}

day_summary_info_to_col(infos[[5]])


# Get and format daily summary
get_day_summary_table <- function(token, plant_id, date) {
  
  day_summary <- get_day_summary(token, 
                                 plant_id, 
                                 date)
  
  
  infos <- day_summary$data$infos
  
  out <- infos |> 
    lapply(day_summary_info_to_col) |> 
    purrr::reduce(dplyr::left_join, by = 'dt') |> 
    dplyr::arrange(dt)
  
  out
}

day_summary_table <- get_day_summary_table(token, plant_id, date)

# Plot daily summary

day_summary_table |> 
  tidyr::pivot_longer(-dt) |> 
  ggplot(aes(dt, value)) + 
  geom_line() + 
  facet_wrap(~name, 
             ncol = 1, 
             scales = "free_y")

