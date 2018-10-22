# Defense and Kicker scraping

# Set the working directory
setwd("C:/Data Science/FF_R")

library(rvest) # Parsing of html/xml files
library(tidyverse) # General-purpose data wrangrling
library(stringr) # String manipulation
library(rebus) # Verbose regular expressions
library(lubridate) # Eases DateTime manipulation

year <- "2018"

# The url we are going to use to retrieve the data
url_kicker <- sprintf("https://www.cbssports.com/fantasy/football/stats/sortable/points/K/ppr/projections/%s/ytd", year)
url_dst <- sprintf("https://www.cbssports.com/fantasy/football/stats/sortable/points/DST/ppr/projections/%s/ytd", year)

# Get the page html
html <- read_html(url_kicker)

# Get the table with our information
kickers <- html %>% html_node(".data") %>% html_children()

str(kickers)

kickerTable <- kickers %>% html_table(header = NA, fill = TRUE, trim = TRUE)

str(kickerTable)

# Get rid of the first row
# kickerTable <- kickerTable[-c(1,2), ]

# str(kickerTable)

# Add a new Team column
kickerTable$Team <- NA

# Rename team names to full name of team
# full$Team[which(full$Team == "ARI")] <- "Arizona"
# full$Team[which(full$Team == "BUF")] <- "Buffalo"
# full$Team[which(full$Team == "TEN")] <- "Tennessee"
# full$Team[which(full$Team == "WAS")] <- "Washington"
# full$Team[which(full$Team == "DAL")] <- "Dallas"
# full$Team[which(full$Team == "CHI")] <- "Chicago"
# full$Team[which(full$Team == "CAR")] <- "Carolina"
# full$Team[which(full$Team == "NYJ")] <- "New York Jets"
# full$Team[which(full$Team == "MIA")] <- "Miami"
# full$Team[which(full$Team == "SEA")] <- "Seattle"
# full$Team[which(full$Team == "CLE")] <- "Cleveland"
# full$Team[which(full$Team == "TAM")] <- "Tampa Bay"
# full$Team[which(full$Team == "DEN")] <- "Denver"
# full$Team[which(full$Team == "NYG")] <- "New York Giants"
# full$Team[which(full$Team == "SFO")] <- "San Francisco"
# full$Team[which(full$Team == "NWE")] <- "New England"
# full$Team[which(full$Team == "PHI")] <- "Philadelphia"
# full$Team[which(full$Team == "JAX")] <- "Jacksonville"
# full$Team[which(full$Team == "DET")] <- "Detroit"
# full$Team[which(full$Team == "HOU")] <- "Houston"
# full$Team[which(full$Team == "OAK")] <- "Oakland"
# full$Team[which(full$Team == "CIN")] <- "Cincinnati"
# full$Team[which(full$Team == "BAL")] <- "Baltimore"
# full$Team[which(full$Team == "GNB")] <- "Green Bay"
# full$Team[which(full$Team == "IND")] <- "Indianapolis"
# full$Team[which(full$Team == "MIN")] <- "Minnesota"
# full$Team[which(full$Team == "LAC")] <- "Los Angeles Chargers"
# full$Team[which(full$Team == "ATL")] <- "Atlanta"
# full$Team[which(full$Team == "PIT")] <- "Pittsburgh"
# full$Team[which(full$Team == "KAN")] <- "Kansas City"
# full$Team[which(full$Team == "LAR")] <- "Los Angeles Rams"
# full$Team[which(full$Team == "NOR")] <- "New Orleans"
# full$Team[which(full$Team == "SDG")] <- "San Diego"
# full$Team[which(full$Team == "STL")] <- "St. Louis"

# Write the data frame to a file as a csv
write.csv(kickerTable, sprintf("Data_Files/kickers%s.csv", year))