# Copyright statement:
# This shiny apllication is developed by Duco Veen to be used for educational purposes.
# Is is part of a program sponsered by the Education Incentive Funds of Utrecht University. 
# The lay-out for the shiny applications for this program is developed by Kimberley Lek. 
# The application is licensed under the ?? GNU General Public License V3.0 - decision on this? ?? 

# Author Comment:
# I have tried to code this according to the Google R Style Guide to improve readibility:
# https://google.github.io/styleguide/Rguide.xml
# For any quenstions or comments you can contact me at d.veen@uu.nl.

# File description:
# This file contains the server for the application related to correlation.


# Loading library's 
library(shiny)
library(knitr) # for custom tables

# server design
server <- function(input, output) {
  
  # plot for correlation tab. 
  output$plot1 <- renderPlot({
    plot(NA,NA,xlim=c(1,10),ylim=c(1,10),xlab="MTS1 grade",ylab="MTS2 grade") 
    # create an empty plot
    x <- v$range
    # x coordinates obtained from points "clicked" in the plot
    y <- vv$range
    # y coordinates obtained from points "clicked" in the plot
    points(x,y)
    # draw points at x, y coordinates.
    if(length(x)>2){
      legend("topleft", c(paste("Correlation:", signif( cor.test(x = x, y = y)$estimate, 2)),
                          paste("p-value:", round( cor.test(x = x, y = y)$p.value, 2))),
             bty= "n",cex=1.5)} else {
        legend("topleft",c("Correlation: --", "p-value: --"),bty="n",cex=1.5)
      }
    # add legend to top left giving correlation between the points and the p-value of the correlation
  })
  
  # Table 1, correlation calculation tab bottom table
  output$table1 <- renderTable({
    x <- v$range # get "clicked" x values
    y <- vv$range # get "clicked" y values
    x.bar <- mean(x) # mean x
    y.bar <- mean(y) # mean y
    A <- x - x.bar # x minus mean x
    B <- y - y.bar # y minus mean y
    AB <- A * B # Sum of product x and y
    AA <- A * A # Sum Squared x
    BB <- B * B # Sum Squared y
    
    table.cor <- cbind(x, y, A, B, AB, AA, BB) # bind these in a table
    colnames(table.cor) <- c("X (MTS1 grade)","Y (MTS2 grade)","X - M_x","Y - M_y", "SP", "SS_x", "SS_p")
    # table column names
    table.cor
  })
  
  ### correlation table
  output$table2 <- renderTable({
    x <- v$range
    y <- vv$range
    x.bar <- mean(x)
    y.bar <- mean(y)
    A <- x - x.bar
    B <- y - y.bar
    AB <- A*B
    AA <- A*A
    BB <- B*B
    
    table.cor <- cbind(x.bar,y.bar,sum(AB),sum(AA),sum(BB))
    colnames(table.cor) <- c("M_x", "M_y", "SP", "SS_x", "SS_y")
    table.cor
  })
  ### correlation table 2
  
  
  output$plot2 <- renderPlot({
    plot(NA,NA,xlim=c(1,10),ylim=c(1,10),xlab="MTS1 grade",ylab="MTS2 grade") 
    x <- v$range
    y <- vv$range
    points(x,y)
    if(length(x)>2){
      legend("topleft",c(paste("Regression intercept:",signif(lm(y~x)$coefficients[1],2)),
                         paste("Regression slope:",signif(lm(y~x)$coefficients[2],2))),bty= "n",cex=1.5)
      abline(lm(y~x),type="l")
    } else {
      legend("topleft",c("Regression intercept: --","Regression slope: --"),bty="n",cex=1.5)
    }
  })
  ### regression plot
  
  ####################################################################################
  # defining x location for drawing correlation
  ####################################################################################
  v <- reactiveValues(
    click1 = NULL,  # Represents the mouse click, if any
    range = NULL    # this stores the range of x for each click
  )
  
  observeEvent(input$plot_click, {
    v$range[[length(v$range)+1]] <- as.numeric(input$plot_click[1])
  })
  
  output$x <- reactive({
    out <- v$range
    out
  })
  
  ####################################################################################
  # defining y location for drawing correlation
  ####################################################################################
  vv <- reactiveValues(
    click1 = NULL,  # Represents the mouse click, if any
    range = NULL    # this stores the range of x for each click
  )
  
  observeEvent(input$plot_click, {
    vv$range[[length(vv$range)+1]] <- as.numeric(input$plot_click[2])
  })
  
  output$y <- reactive({
    out <- vv$range
    out
  })
  
  observeEvent(input$Undo, {
    lengte <- length(vv$range) 
    #which x and y number in the vector need to be undone
    vv$range <- vv$range[0:(lengte-1)]
    #undo function for y axis
    v$range <- v$range[0:(lengte-1)]
    #undo function for x axis
  })
  
  observeEvent(input$reset, {
    # Reset for y axis
    vv$range <- NULL
    vv$click1 <- NULL
    # Reset for x axis
    v$range <- NULL
    v$click1 <- NULL
  })
  
  observeEvent(input$Undo2, {
    lengte <- length(vv$range) 
    #which x and y number in the vector need to be undone
    vv$range <- vv$range[0:(lengte-1)]
    #undo function for y axis
    v$range <- v$range[0:(lengte-1)]
    #undo function for x axis
  })
  
  observeEvent(input$reset2, {
    # Reset for y axis
    vv$range <- NULL
    vv$click1 <- NULL
    # Reset for x axis
    v$range <- NULL
    v$click1 <- NULL
  })
  

  
}