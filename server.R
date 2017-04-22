
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(jsonlite)
library(dplyr)
library(curl)

shinyServer(function(input, output) {
  output$frequencyTable <- renderDataTable(
      {
          acronym <- input$acronym
          
          # Construct the URL and get the results from the API
          url <- paste0(
              "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf="
              ,acronym
              ,"&#8217;"
              ,   sep = FALSE
          )
          results <- fromJSON(url)
          
          # Get the top-level definitions, their frequencies and the year since they were
          # in use
          words <- results$lfs[[1]][,1]
          freqs <- results$lfs[[1]][,2]
          since <- results$lfs[[1]][,3]
          wordfreqs <- data.frame(Long.Form=words, Frequency=freqs, Added=since) %>%
              filter(since > input$earliestYear) %>%
              filter(since < input$latestYear)
          
          wordfreqs
      }
  )

})
