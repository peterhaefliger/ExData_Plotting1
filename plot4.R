# plot4.R
# Coursera course 'Exploratory Data Analysis', course project 1
# Script for re-creating plot 1

library(gridExtra)

# source base functions
source('base_functions.R')

# load data (if not already loaded from a former execution of this or another script)
if (!exists("input_data")) {
  input_data <- load_data()
}

# construct individual plots
plot_top_left <- construct_plot2()

plot_top_right <- ggplot(input_data, mapping = aes(x = DateTime, y = Voltage)) + 
  geom_line() + xlab("datetime") + ylab("Global Active Power (kilowatts)") + 
  scale_x_datetime(
    breaks = ymd_hms(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00")), 
    labels = c("Thu", "Fri", "Sat"))

plot_bottom_left <- construct_plot3()

plot_bottom_right <-  ggplot(input_data, mapping = aes(x = DateTime, y = Global_reactive_power)) + 
  geom_line() + xlab("datetime") + ylab("Global_reactive_power") + 
  scale_x_datetime(
    breaks = ymd_hms(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00")), 
    labels = c("Thu", "Fri", "Sat"))

# print assembled plots
png("plot4.png", width = 480, height = 480, units = "px")
grid.arrange(plot_top_left, plot_top_right, plot_bottom_left, plot_bottom_right, nrow = 2)
dev.off()

print_plot(plot, "plot4.png")
