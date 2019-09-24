# plot2.R
# Coursera course 'Exploratory Data Analysis', course project 1
# Script for re-creating plot 2

source('load_data.R')
if (!exists("input_data")) {
    input_data <- load_data()
}

# combine date and time values to a datetime for the x-axis
library(lubridate)
input_data <- mutate(
    input_data, DateTime = make_datetime(
        year(Date), month(Date), day(Date), hour(Time), minute(Time), second(Time)))

# construct plot
# The assignment reads: "Your task is to reconstruct the following plots below, 
# all of which were constructed using the base plotting system." As the assignment 
# does NOT state that we also have to use the base plotting system for reconstructing 
# the plots which were constructed using the base plottting system, I prefer using 
# ggplot2 because I have worked my way through parts of Hadley Wickham's great book 
# "R for Data Science" and that's the methods I would like to grow proficient at.
plot <- ggplot(input_data, mapping = aes(x = DateTime, y = Global_active_power)) 
plot <- plot + geom_line()
plot <- plot + xlab("") + ylab("Global Active Power (kilowatts)")
plot <- plot + scale_x_datetime(
    breaks = ymd_hms(
        c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00")), 
    labels = c("Thu", "Fri", "Sat"))

print_plot(plot, "plot2.png")