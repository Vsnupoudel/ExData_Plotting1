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

#Plot 4 and export to png
par(mfrow=c(2,2),mar=c(4,4,4,1))
with(data, plot(datetime, Global_active_power ,type="l", xlab="", ylab="Global Active Power")  )
with(data, plot(datetime, Voltage ,type="l")  )
 # this plot is longer - copy from 3
with(data, plot(datetime, Sub_metering_1 ,type="l" , ylab="Energy sub metering", xlab="")  )
with(data, points(datetime, Sub_metering_2 ,type="l",col="red")  )
with(data, points(datetime, Sub_metering_3 ,type="l",col="blue")  )
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3") 
       ,lty=1,col=c("black","red","blue"), bty="n", text.font= text(0,cex=0.1))
  #last on the grid
with(data, plot(datetime, Global_reactive_power ,type="l")  )


dev.copy(png, file="plot4.png", width=480, height=480, units="px")
dev.off()







