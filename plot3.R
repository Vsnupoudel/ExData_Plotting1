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

#Plot 3 and export to png
with(data, plot(datetime, Sub_metering_1 ,type="l")  )
with(data, points(datetime, Sub_metering_2 ,type="l",col="red")  )
with(data, points(datetime, Sub_metering_3 ,type="l",col="blue")  )
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3") 
       ,lty=1,col=c("black","red","blue"))

dev.copy(png, file="plot3.png", width=480, height=480, units="px")
dev.off()







