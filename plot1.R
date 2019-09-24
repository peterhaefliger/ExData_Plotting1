# plot1.R
# Coursera course 'Exploratory Data Analysis', course project 1
# Script for re-creating plot 1

source('load_data.R')
if (!exists("input_data")) {
    input_data <- load_data()
}

# construct plot
# The assignment reads: "Your task is to reconstruct the following plots below, 
# all of which were constructed using the base plotting system." As the assignment 
# does NOT state that we also have to use the base plotting system for reconstructing 
# the plots which were constructed using the base plottting system, I prefer using 
# ggplot2 because I have worked my way through parts of Hadley Wickham's great book 
# "R for Data Science" and that's the methods I would like to grow proficient at.
plot <- ggplot(input_data, mapping = aes(x = Global_active_power)) 
plot <- plot + geom_histogram(breaks =  seq(0, 6, 0.5), color="black", fill="red")
plot <- plot + ggtitle("Global Active Power")
plot <- plot + xlab("Global Active Power (kilowatts)") + ylab("Frequency")

print_plot(plot, "plot1.png")