# Load the RSelenium library
library(RSelenium)
library(qdap)

# Start local selenium server
# You will need to start a local selenium server on port 444
# Download the selenium server from https://www.seleniumhq.org/download/. Just get the latest version
# Start the server with the commands "java -jar selenium-server-standalone-3.10.0.jar". Replace "3.10.0" with the version you downloaded.
# Now you are ready to run this R script

# Instantiate the remote driver
remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4444,
                      browser = "firefox")

# Opern the server and connect to it
remDr$open()

# Url to get the fantasy info
FANTASY_URL <-
  "https://www.pro-football-reference.com/years/2018/fantasy.htm"

# Navigate to the web page
remDr$navigate(FANTASY_URL)

# Sleep for 5 seconds
Sys.sleep(5)

# Get share element
shareElem <-
  remDr$findElement(using = "xpath", value = "//span[contains(text(), 'Share & more')]")
shareElem$clickElement()

# Sleep for 5 seconds
Sys.sleep(5)

# Get the element to click to change to csv
csvButton <-
  remDr$findElement(using = "xpath", value = "//button[contains(text(), 'Get table as CSV')]")
csvButton$clickElement()

# Get the csv text
csvContainer <-
  remDr$findElement(using = "id", value = "csv_fantasy")
csvData <- csvContainer$getElementText()

# Trim the white space
csvData <- trimws(csvData)

# Remove the first row and new line
csvData <- gsub(".*(Fantasy,Fantasy,Fantasy,Fantasy)", "", csvData)
csvData <- sub("\n", "", csvData)

# Save as a csv file
write.table(csvData, file = "C:/Data Science/FF_R/Data_Files/fantData2018.csv", sep = ",",
            col.names = FALSE,
            row.names = FALSE,
            quote = FALSE)

# Close the remote webdriver
remDr$close()
