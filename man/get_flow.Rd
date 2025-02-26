% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_flow.R
\name{get_flow}
\alias{get_flow}
\title{Get current power flow information for a plant}
\usage{
get_flow(token, plant_id)
}
\arguments{
\item{token}{Authorisation token.}

\item{plant_id}{Plant id.}
}
\value{
List of most recent power flows (and state of charge).
}
\description{
Get current power flow information for a plant
}
\examples{
\dontrun{
get_flow(token, 1)
}
}
