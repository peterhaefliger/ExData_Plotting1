# load_data.R
# Coursera course 'Exploratory Data Analysis', course project 1
# Script for loading the required tidyverse libraries, defining constants, 
# downloading, unzipping and filtering the input data and printing the plot.
# This functionality is common to all four plot-generating scripts

# load necessary tidyverse libraries
library(readr)
library(dplyr)
library(ggplot2)
library(lubridate)

# load, prepare and return data
load_data <- function() {
  
  # define constants, urls, filenames
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zip_filename <- "exdata_data_household_power_consumption.zip"
  input_filename <- "household_power_consumption.txt"
  foldername <- "exdata_data_household_power_consumption"
  separator <- "/"
  
  # download and unzip input data (if not already done before)
  if (!file.exists(zip_filename)){
    download.file(url, zip_filename, method="curl")
  }  
  if (!file.exists(input_filename)) { 
    unzip(zip_filename) 
  }
  
  # read data from input file, filter for requested dates and combine date and time values to a datetime 
  # (for the x-axis of all plots except the first)
  data <- read_delim(input_filename, 
                     delim = ";",
                     na = "?", 
                     col_types = cols(Date = col_date("%d/%m/%Y")),
                     locale = locale(decimal_mark = ".", )
  ) %>% filter(
    Date %in% parse_date(c("2007-02-01", "2007-02-02"))
  ) %>% mutate(DateTime = make_datetime(
    year(Date), month(Date), day(Date), hour(Time), minute(Time), second(Time)))
  
  return(data)
}

# print plot
print_plot <- function(p, f) {
  png(filename = f, width = 480, height = 480, units = "px")
  print(p)
  dev.off()
}

#construct and return plots

# The assignment reads: "Your task is to reconstruct the following plots below, 
# all of which were constructed using the base plotting system." As the assignment 
# does NOT state that we also have to use the base plotting system for reconstructing 
# the plots which were constructed using the base plottting system, I prefer using 
# ggplot2 because I have worked my way through parts of Hadley Wickham's great book 
# "R for Data Science" and that's the methods I would like to grow proficient at.

construct_plot1 <- function() {
  plot <- ggplot(input_data, mapping = aes(x = Global_active_power)) + 
    geom_histogram(breaks =  seq(0, 6, 0.5), color="black", fill="red") + 
    ggtitle("Global Active Power") + xlab("Global Active Power (kilowatts)") + ylab("Frequency")
  
  return(plot)
}

construct_plot2 <- function() {
  plot <- ggplot(input_data, mapping = aes(x = DateTime, y = Global_active_power)) + 
    geom_line() + xlab("") + ylab("Global Active Power (kilowatts)") + 
    scale_x_datetime(
      breaks = ymd_hms(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00")), 
      labels = c("Thu", "Fri", "Sat"))
  
  return(plot)
}

construct_plot3 <- function() {
  plot <- ggplot(input_data, mapping = aes(x = DateTime)) +
    geom_line(mapping = aes(y = Sub_metering_1, color="Sub_metering_1")) +
    geom_line(mapping = aes(y = Sub_metering_2, color="Sub_metering_2")) +
    geom_line(mapping = aes(y = Sub_metering_3, color="Sub_metering_3")) +
    scale_colour_manual("", 
                        breaks = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                        values = c("black", "red", "blue")) +
    theme(legend.position = c(0.8, 0.8)) + xlab("") + ylab("Energy sub metering") + 
    scale_x_datetime(
      breaks = ymd_hms(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00")), 
      labels = c("Thu", "Fri", "Sat"))

  return(plot)  
}
