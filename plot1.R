#download data
if(! file.exists("/home/alex/ExData_Plotting1/data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "/home/alex/ExData_Plotting1/data.zip")
  zipped.file <- "/home/alex/ExData_Plotting1/data.zip"
  unzip(zipfile = "/home/alex/ExData_Plotting1/data.zip", exdir = "/home/alex/ExData_Plotting1/data")
}

#change to new dir
setwd("/home/alex/ExData_Plotting1/data")

#read dataset
df <- read.table("/home/alex/ExData_Plotting1/data/household_power_consumption.txt",sep = ";", header = TRUE)

#convert dates class
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
print(class(df$Date))

#subset global active power for specified dates
Global_active_power <- as.numeric(df$Global_active_power[df$Date>=as.Date("2007-02-01") & df$Date <= as.Date("2007-02-02")])
Global_active_power <- Global_active_power[!is.na(Global_active_power)]

#make plot 1 in a png Graphics Device
png(filename = "/home/alex/ExData_Plotting1/plot1.png", height = 480 , width = 480)
hist(Global_active_power, col = "red", main = "")
title("Global active power")
dev.off()