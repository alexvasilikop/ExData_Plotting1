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

#Add DateTime col generated with with strptime and as.Date()
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
print(class(df$DateTime))

#subset df for specified dates
df <- df[as.Date(df$Date, format = "%d/%m/%Y")>=as.Date("2007-02-01", format = "%Y-%m-%d") & as.Date(df$Date, , format = "%d/%m/%Y") <= as.Date("2007-02-02", format = "%Y-%m-%d"),]
df <- df[!is.na(df$Global_active_power),]

#convert the POSIXlt objects to POSIXct, which is numeric internally and works with axis()
df$DateTime <- as.POSIXct(df$DateTime)
# Calculate indices for first, middle, and last elements
first <- df$DateTime[1] # First DateTime value
middle <- df$DateTime[nrow(df)/2] # Middle DateTime value
last <- df$DateTime[nrow(df)] # Last DateTime value

#make plot 2 in a png Graphics Device
png(filename = "/home/alex/ExData_Plotting1/plot2.png", height = 480 , width = 480)
with(df, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n"))
axis(1, at = c(first, middle, last), labels = c("Thu", "Fri", "Sat"))
dev.off()