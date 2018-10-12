install.packages("rsconnect")
install.packages("shiny")

# Load rsconnect library
library(rsconnect)
library(shiny)

# Authorize account
rsconnect::setAccountInfo(name='joeyjojoe',
                          token='3F7BC73A0F1D5AE9BCB3B8ADE446A1BA',
                          secret='ZRpLpvHJVNijnMay54fi23tlvkiQkkjHzkODGocf')

# Deploy the app
rsconnect::deployApp('C:/Data Science/FF_R/FantasyFootball.Rmd')

# Create a UI with I/O controls
ui <- fluidPage(
  titlePanel("Input and Output"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "num",
        label = "Choose a Number",
        min = 0,
        max = 100,
        value = 25)),
    mainPanel(
      textOutput(
        outputId = "text"))))

# Create a server that maps intput to output
server <- function(input, output) {
  output$text <- renderText({
    paste("You selected ", input$num)})
}

# Create a shiny app
shinyApp(
  ui = ui, 
  server = server)