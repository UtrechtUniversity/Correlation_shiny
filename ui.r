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
# This file contains the user interface (UI) for the application related to correlation.

# Loading library's 
library(shiny)
library(shinydashboard)

# user interface design
ui <- dashboardPage(skin = "black",
dashboardHeader(title = "Correlational statistics",titleWidth = 350), 
dashboardSidebar(width = 350,
                 sidebarMenu(#menuItem("", tabName = "home", icon = icon("home")),
                             menuItem("Draw Correlation", tabName = "tab1"),
                             menuItem("Calculate Correlation", tabName = "tab2"),
                             menuItem("Regression", tabName = "tab3"),
                             menuItem("Disclaimer", tabName = "Disclaimer"), 
                             HTML("<br><br><br><br><br><br><br><br><br><br><br><br><br><br>"), 
                             img(src= "logo.png", align = "left"),
                             br(), 
                             div("Shiny app by",
                                 a(href="https://www.uu.nl/staff/dveen",
                                   target = "_blank",
                                   "Duco Veen"),align="right", style = "font-size: 10pt"),
                             
                             div("Base R code by",
                                 a(href="https://www.uu.nl/staff/dveen",target="_blank",
                                   "Duco Veen"),align="right", style = "font-size: 10pt"),
                             
                             div("Base Layout by",
                                 a(href="https://www.uu.nl/medewerkers/KMLek/0",target="_blank",
                                   "Kimberley Lek"),align="right", style = "font-size: 10pt"),
                             
                             div("Shiny source files:",
                                 a(href="https://github.com/EducationalShinyUU/Correlation_shiny",
                                   target="_blank","GitHub"),align="right", style = "font-size: 10pt")
                             ) #end sidebarMenu
                 ), #end dashboardsidebar
dashboardBody(
# CSS styles lay-out settings from Kimberley
  tags$style(HTML(".irs-bar {background: #EAC626}")),
  tags$style(HTML(".irs-bar {border-top: 1px solid black}")),
  tags$style(HTML(".irs-bar-edge {background: #EAC626}")),
  tags$style(HTML(".irs-bar-edge {border: 1px solid black}")),
  tags$style(HTML(".irs-single {background: #EAC626}")),
  tags$style(HTML(".selectize-input {border-color: #EAC626}")),
  tags$style(HTML(".selectize-dropdown {border-color: #EAC626}")),
  tags$head(tags$style(HTML('.skin-black .main-header .logo {
                             background-color: #EAC626;
                             } .skin-black .main-header .logo:hover {
                             background-color: #EAC626;
                             }
                             /* active selected tab in the sidebarmenu */
                             .skin-black .main-sidebar .sidebar .sidebar-menu .active a{
                             background-color: #EAC626;
                             }
                             /* navbar (rest of the header) */
                             .skin-black .main-header .navbar {
                             background-color: #EAC626;
                             }
                             /* toggle button when hovered  */                    
                             .skin-black .main-header .navbar .sidebar-toggle:hover{
                             background-color: #EAC626;
                             }
                             /* other links in the sidebarmenu when hovered */
                             .skin-black .main-sidebar .sidebar .sidebar-menu a:hover{
                             background-color: #EAC626;
                             }
                             /* other links in the sidebarmenu */
                             .skin-black .main-sidebar .sidebar .sidebar-menu a{
                             background-color: #EAC626;
                             color: #000000;
                             }
                             /* active selected tab in the sidebarmenu */
                             .skin-black .main-sidebar .sidebar .sidebar-menu .active a{
                             background-color: #000000;
                             color: #FFFFFF;
                             }
                             .skin-black .main-sidebar {color: #000000; background-color: #EAC626;}
                             ') # end html
                       ) # end tags$style
            ), # end tags$head
  tabItems(
    # now for the content of the different tabs.
    # Disclaimer tab, university disclaimer.
    tabItem(tabName = "Disclaimer", 
            box(width = 12, 
                h5("Terms of Usage Utrecht Unversity Shiny Server", 
                   br(), 
                   br(),
                  tags$ul(
                          tags$li("Purpose of the service “utrecht-university.shinyapps.io” 
                                  is to provide a digital place for trying out, evaluating 
                                  and/or comparing methods developed by researchers of Utrecht University 
                                  for the scientific community worldwide. 
                                  The app and its contents may not be preserved in such a way that it can 
                                  be cited or can be referenced to. "), 
                          tags$li("The web application is provided ‘as is’ and ‘as available’ and is without any warranty. 
                                  Your use of this web application is solely at your own risk."), 
                          tags$li("	You must ensure that you are lawfully entitled and have full authority to upload 
                                  data in the web application. The file data must not contain any data which can raise 
                                  issues relating to abuse, confidentiality, privacy,  data protection, licensing, and/or 
                                  intellectual property. You shall not upload data with any confidential or proprietary information 
                                  that you desire or are required to keep secret. "),
                          tags$li("By using this app you agree to be bound by the above terms.")
                          ) # end tags$ul
                  )
                ) # end box
            ), # end tab Item (disclaimer tab.)
    
    # Correlation tab, university disclaimer.
    tabItem(tabName = "tab1", 
            fluidRow( 
              box( width = 12, align = "center",
                   #h5("By clicking in the plot you add new data points. See what happens to your correlation when you add data points."),
                   #h5("To see how the correlation between the points is calculated click on the tab 'Calculate Correlation'"),
                   # explanation what students should do
                   plotOutput("plot1",width = 800, height = 600, click = "plot_click") ), 
              # plot in which correlation can be drawn and end of this box
              box ( width = 12, align = "center", # box for undo and reset buttons
                   actionButton("Undo", "Undo"), # action button that allows the previous point to be deleted 
                   actionButton("reset", "Reset") # action button to restart with clean plot
                   ) # end box
              ) # end fluidrow
    ), # end tabItem (correlation tab)
    
    # Calculate correlation tab
    tabItem(tabName = "tab2",
            fluidRow(
              box(width = 12, align = "center",
            tableOutput("table2") # table with summaries to calculate correlation.
              ), # end box
              box(width = 12, align = "center",
            tableOutput("table1") # table with observations and deviations from mean
              )  # end box
            ) # end fluidRow
    ), # end tabItem (calculate correlation)
    
    # Regression tab
    tabItem(tabName = "tab3", 
            fluidRow( 
              box( width = 12, align = "center",
                   #h5("The same data for the regression can be used to describe a regerssion too."),
                   #h5("We have the same plot as the 'Correlation' and can still add new points. 
                  #    Only now you get the results of a regression analyses."),
                   # explanation what students should do
                   plotOutput("plot2",width = 800, height = 600, click = "plot_click") ), 
              # plot in which correlation can be drawn and end of this box
              box ( width = 12, align = "center", # box for undo and reset buttons
                    actionButton("Undo2", "Undo"), # action button that allows the previous point to be deleted 
                    actionButton("reset2", "Reset") # action button to restart with clean plot
              ) # end box
            ) # end fluidrow
    ) # end tabItem (regression tab)
    
    ) # end tabItems
  ) # end dashboardbody
) # end dashboardpage

