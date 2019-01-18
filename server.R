#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

nchsData <- read.csv("NCHS_-_Leading_Causes_of_Death__United_States.csv")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
       
        dataSet <- reactive({
                minYear <- input$sliderYear[1]
                maxYear <- input$sliderYear[2]    
                
                cause <- input$selectCause
                state <- input$selectState
                
                nchsDataTmp <- nchsData[nchsData$Cause.Name == cause,]
                nchsDataTmp <- nchsDataTmp[nchsDataTmp$Year >= minYear,]
                nchsDataTmp <- nchsDataTmp[nchsDataTmp$Year <= maxYear,]
                
                if (state != "All States") {
                        nchsDataTmp <- nchsDataTmp[nchsDataTmp$State == state,]        
                }
                else {
                        if (input$suppressLargestState) {
                                nchsDataTmpFirstYear <- nchsDataTmp[nchsDataTmp$Year == minYear,]
                                nchsDataTmpFirstYear <- nchsDataTmpFirstYear[which.max(nchsDataTmpFirstYear$Deaths),]
                                nchsDataTmp <- nchsDataTmp[nchsDataTmp$State != nchsDataTmpFirstYear$State, ]
                        }
                }
                nchsDataTmp
        })
        
        linearModel <- reactive({
                nchsDataTmp <- dataSet()
                minYear <- input$sliderYear[1]
                nchsDataTmp$Year <- nchsDataTmp$Year - minYear
                fit <- lm(Deaths ~ Year, data=nchsDataTmp)
        })
        
        output$deathPlot <- renderPlot({
                
                nchsDataTmp <- dataSet()
                cause <- input$selectCause
                state <- input$selectState
                g <- ggplot(nchsDataTmp, aes(x=Year, y=Deaths)) + geom_point(aes(color=State)) + geom_smooth(method="lm")
                g <- g + labs(title=paste("Deaths caused by", cause, "for state", state), y="Number of Deaths", x="Year")
                print(g)
        })
        
        
        output$SelectedYearMin <- renderText({ 
                paste("Starting Year: ", input$sliderYear[1])
        })
        output$SelectedYearMax <- renderText({ 
                paste("Ending Year: ", input$sliderYear[2])
        })
        output$SelectedCause <- renderText({ 
                paste("Selected cause: ", input$selectCause)
        })
        output$SelectedState <- renderText({ 
                paste("Selected State: ", input$selectState)
        })
        output$LinearModelIntercept <- renderText({ 
                fit <- linearModel()
                paste("Intercept of Linear Model: ", fit$coefficients[1])
        })
        
        output$LinearModelSlope <- renderText({ 
                fit <- linearModel()
                paste("Slope of Linear Model: ", fit$coefficients[2])
        })
        
  })
  

