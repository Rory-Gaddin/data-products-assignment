
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("NaCTeM Acromine Acronym Finder", windowTitle = "NaCTeM Acromine Acronym Finder"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
        div(
            p("This simple app allows you to search for acronyms using the",
              a("Acromine REST service",
                href="http://www.nactem.ac.uk/software/acromine/rest.html"),
              "and displays a table showing all of the long-form definitions in the Acromine
              corpus, the frequency with which they occur in the corpus, and the year in which they were added."),
            p("The source code for this project can be located at",
              a("https://github.com/Rory-Gaddin/data-products-assignment",
                href="https://github.com/Rory-Gaddin/data-products-assignment")
            )
        ),
        
        textInput(
            "acronym", 
            "Please enter an acronym to search for here:", 
            placeholder = "e.g., BMI, USA, DNA"
        ),
        numericInput("earliestYear", "Added after", min = 1900, max = 2018,
                    value = 1900),
        numericInput("latestYear", "Added before", min = 1950, max = 2018,
                    value = 2017, step = 1),
        submitButton("Search for Acronyms")
    ),

    # Show a plot of the generated wordcloud
    mainPanel(
        dataTableOutput("frequencyTable") 
    )
  )
))
