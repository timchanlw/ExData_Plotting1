df<-read.table("household_power_consumption.txt",header = TRUE,sep = ";")
df$DateTime <- as.POSIXct(strptime(paste(df$Date,df$Time),format="%d/%m/%Y %H:%M:%S"))
summary(df)

##install.packages("dplyr")
library(dplyr)
df <- mutate(df, Global_active_power=as.numeric(as.character(Global_active_power)))
df <- mutate(df, Global_reactive_power=as.numeric(as.character(Global_reactive_power)))
df <- mutate(df, Voltage=as.numeric(as.character(Voltage)))
df <- mutate(df, Global_intensity=as.numeric(as.character(Global_intensity)))
df <- mutate(df, Sub_metering_1=as.numeric(as.character(Sub_metering_1)))
df <- mutate(df, Sub_metering_2=as.numeric(as.character(Sub_metering_2)))
df<-df[df$DateTime > as.POSIXct("2007-02-01") & df$DateTime < as.POSIXct("2007-02-03"),]
summary(df)
library(datasets)

##plot4
colors = c("black","red","blue") 
par(mfrow=c(2,2))
with(df,{
  plot(DateTime,Global_active_power, type="n"
       , xlab=""
       , ylab="Global Active Power (kilowatts)") 
  lines(DateTime,Global_active_power, type="l")
  
  plot(DateTime,Voltage, type="n"
       , xlab="datetime"
       , ylab="Voltage") 
  lines(DateTime,Voltage, type="l")
  
  plot(DateTime,Sub_metering_1, type="n"
       , xlab=""
       , ylab="Energy sub metering")
  lines(df$DateTime,df$Sub_metering_1, type="l", col=colors[1])
  lines(df$DateTime,df$Sub_metering_2, type="l", col=colors[2])
  lines(df$DateTime,df$Sub_metering_3, type="l", col=colors[3])
  legend("topright", pch = "-", col=colors, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  plot(DateTime,Global_reactive_power, type="n"
       , xlab="datetime"
       , ylab="Global_reactive_power") 
  lines(DateTime,Global_reactive_power, type="l")
}
)
dev.copy(png, file="plot4.png")
dev.off()
