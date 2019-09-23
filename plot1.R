# plot1.R
# Coursera course 'Exploratory Data Analysis', course project 1
# Script for re-creating plot 1

# load necessary tidyverse libraries
library(readr)
library(dplyr)
library(ggplot2)

# define constants, urls, filenames
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_filename <- "exdata_data_household_power_consumption.zip"
input_filename <- "household_power_consumption.txt"
foldername <- "exdata_data_household_power_consumption"
output_filename <- "plot1.png"
separator <- "/"

# download and unzip input data (if not already done before)
if (!file.exists(zip_filename)){
    download.file(url, zip_filename, method="curl")
}  
if (!file.exists(input_filename)) { 
    unzip(zip_filename) 
}

# read data from input file and filter for requested dates
options(digits = 15)
data <- read_delim(input_filename, 
                   delim = ";",
                   na = "?", 
                   col_types = cols(Date = col_date("%d/%m/%Y")),
                   locale = locale(decimal_mark = ".", )
                   ) %>% filter(Date %in% parse_date(c("2007-02-01", "2007-02-02")))

# construct plot
# The assignment reads: "Your task is to reconstruct the following plots below, 
# all of which were constructed using the base plotting system." As the assignment 
# does NOT state that we also have to use the base plotting system for reconstructing 
# the plots which were constructed using the base plottting system, I prefer using 
# ggplot2 because I have worked my way through parts of Hadley Wickham's great book 
# "R for Data Science" and that's the methods I would like to grow proficient at.
plot1 <- ggplot(data, mapping = aes(x = Global_active_power)) 
plot1 <- plot1 + geom_histogram(breaks =  seq(0, 6, 0.5), color="black", fill="red")
plot1 <- plot1 + ggtitle("Global Active Power")
plot1 <- plot1 + xlab("Global Active Power (kilowatts)") + ylab("Frequency")

# print plot
png(filename = output_filename,     width = 480, height = 480, units = "px")
print(plot1)
dev.off()