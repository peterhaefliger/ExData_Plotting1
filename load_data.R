# load_data.R
# Coursera course 'Exploratory Data Analysis', course project 1
# Script for loading the required tidyverse libraries, defining constants, 
# downloading, unzipping and filtering the input data and printing the plot.
# This functionality is common to all four plot-generating scripts

# load necessary tidyverse libraries
library(readr)
library(dplyr)
library(ggplot2)

# function to be called from the plot-generating scripts
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
    
    # read data from input file and filter for requested dates
    data <- read_delim(input_filename, 
                       delim = ";",
                       na = "?", 
                       col_types = cols(Date = col_date("%d/%m/%Y")),
                       locale = locale(decimal_mark = ".", )
    ) %>% filter(Date %in% parse_date(c("2007-02-01", "2007-02-02")))
    
    return(data)
}

# function to be called from the plot-generating scripts
print_plot <- function(p, f) {
    png(filename = f, width = 480, height = 480, units = "px")
    print(p)
    dev.off()
}
    