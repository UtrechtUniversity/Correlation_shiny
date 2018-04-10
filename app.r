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
# This is only the source file for the application. The UI and Server are loaded and started.

source("ui.r") # Source ui
source("server.r") # Source server
shinyApp(ui, server) # Load and start application.