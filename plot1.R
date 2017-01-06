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

##plot1
colors = c("red") 
with(df,hist(Global_active_power, col=colors, main="Global Active Power"
             , xlab="Global Active Power (kilowatts)"
             , ylab="Frequency"))
dev.copy(png, file="plot1.png")
dev.off()
