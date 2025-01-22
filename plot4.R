#download data if not already downloaded
source("./download_data.R")

#change to new dir
setwd("/home/alex/ExData_Plotting1/data")

#read dataset
df <- read.table("/home/alex/ExData_Plotting1/data/household_power_consumption.txt",sep = ";", header = TRUE)

#Add DateTime col generated with with strptime and paste
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
print(class(df$DateTime))

#subset df for specified dates
df <- df[as.Date(df$Date, format = "%d/%m/%Y")>=as.Date("2007-02-01", format = "%Y-%m-%d") & as.Date(df$Date, , format = "%d/%m/%Y") <= as.Date("2007-02-02", format = "%Y-%m-%d"),]

#convert the POSIXlt objects to POSIXct, which is numeric internally
df$DateTime <- as.POSIXct(df$DateTime)
print(class(df$DateTime))
# Calculate indices for first, middle, and last elements
first <- df$DateTime[1] # First DateTime value
middle <- df$DateTime[nrow(df)/2] # Middle DateTime value
last <- df$DateTime[nrow(df)] # Last DateTime value

#make plot 2 in a png Graphics Device
png(filename = "/home/alex/ExData_Plotting1/plot3.png", height = 480 , width = 480, units = "px")
with(df, plot(DateTime, Sub_metering_1, type = "l", col= "black", xlab = "", ylab = "Energy sub metering", xaxt = "n"))
lines(df$DateTime, df$Sub_metering_2, col= "red")
lines(df$DateTime, df$Sub_metering_3, col= "blue")
#add modified ticks axis
axis(1, at = c(first, middle, last), labels = c("Thu", "Fri", "Sat"))
#add legend
legend(legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), x = "topright", lwd = 1)
dev.off()