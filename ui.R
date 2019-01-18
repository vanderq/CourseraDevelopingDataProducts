#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

nchsData2 <- read.csv("NCHS_-_Leading_Causes_of_Death__United_States.csv")

causes <- unique(nchsData2$Cause.Name)
causes <- sort(causes)

states <- unique(nchsData2$State)
states <- sort(states)
states <- as.vector(states)
states <- c("All States", states)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Death Causes in the US between 1999 and 2016"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
            sliderInput("sliderYear", "For which years do you want to see the Data?", min = 1999, max = 2016, value = c(1999, 2016)),
            checkboxInput("suppressLargestState", "Suppress Data for whole Country", value=FALSE),
            selectInput(
                    "selectCause",
                    label = h5("Select Cause of Death"),
                    choices = causes
            ),
            selectInput(
                    "selectState",
                    label = h5("State"),
                    choices = states
            )
            #submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        textOutput("SelectedYearMin"),
        textOutput("SelectedYearMax"),
        textOutput("SelectedCause"),
        textOutput("SelectedState"),
        plotOutput("deathPlot"),
        textOutput("LinearModelIntercept"),
        textOutput("LinearModelSlope")
    )
  )
))
