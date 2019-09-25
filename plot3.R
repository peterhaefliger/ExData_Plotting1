# plot3.R
# Coursera course 'Exploratory Data Analysis', course project 1
# Script for re-creating plot 3

# source base functions
source('base_functions.R')

# load data (if not already loaded from a former execution of this or another script)
if (!exists("input_data")) {
    input_data <- load_data()
}

# construct plot
plot <- construct_plot3()

# print plot
print_plot(plot, "plot3.png")