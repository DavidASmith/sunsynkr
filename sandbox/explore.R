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

plants |> 
  redact_plants() 

# Get flow ----------------------------------------------------------------

plant_id <- plants$data$infos[[1]]$id


flow <- get_flow(token, 
                 plant_id)


flow


# Get day summary ---------------------------------------------------------

date <- "2024-07-28"


day_summary <- get_day_summary(token, 
                               plant_id, 
                               date)


day_summary_table <- get_day_summary_table(token, plant_id, date)


# Plot daily summary
day_summary_table |> 
  plot()
