#Download and Unzip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
              , destfile="Assign.zip", method="libcurl")
unzip("Assign.zip")

#Read only the required row numbers
data<- read.table("household_power_consumption.txt", skip=66637,sep=";", header=T, nrows=3000)
header<- read.table("household_power_consumption.txt", sep=";", header=T, nrows=1)
colnames(data)<- colnames(header)
data<- data[ data$Date %in%  c("1/2/2007","2/2/2007"),]

#Create a new datetime Column; specify timezone just for fun
data$datetime<- parse_date_time(data$datetime, orders="dmy_HMS", tz="Asia/Kathmandu")

#Plot 1 and export to png
with(data, hist(  Global_active_power, col="red" ,xlab="Global Active Power (kilowatts)" 
                  ,main="Global Active Power"  ) )
dev.copy(png, "Plot1.png", width=480, height=480, units="px")
dev.off()



