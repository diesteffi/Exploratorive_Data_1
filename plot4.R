##Set working directory
if(!file.exists('Project 1')) {
  dir.create('Project 1')
}

setwd('.\\Project 1')

## Download data
datafile<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(datafile, destfile = 'household_power_consumption.txt')

rm(datafile)

## Import data
pre_data<-read.table('household_power_consumption.txt',header=T, sep=';',nrows=2)
cl<-sapply(pre_data,class)
cnames<-colnames(pre_data)
rm('pre_data','cl','cnames')

data<-read.table('household_power_consumption.txt',
                 header=T,
                 sep=';',
                 colClasses=cl,
                 skip=66636,
                 nrows=2880,
                 comment.char="?")

colnames(data)<-cnames
date<-strptime(paste(data$Date,data$Time),'%d/%m/%Y %H:%M:%S')
data<-data.frame(date,data[,3:9])
rm(date)

## Make lineplot

png('plot4.png',
    width=480,
    height=480,)

par(mfcol=c(2,2))

plot(data$date,data$Global_active_power,
     type='l',
     xlab='',
     ylab='Global Active Power (kilowatts)',)

plot(data$date,data$Sub_metering_1,
     type='n',
     xlab='',
     ylab='Energy sub metering',)
lines(data$date,data$Sub_metering_1,col='black')
lines(data$date,data$Sub_metering_2,col='red')
lines(data$date,data$Sub_metering_3,col='blue')
legend('topright',
       c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       lty=1,
       col=c('black','red','blue'),
       bty='n')

plot(data$date,data$Voltage,
     type='l',
     xlab='datetime',
     ylab='Voltage',)

plot(data$date,data$Global_reactive_power,
     type='l',
     xlab='datetime',)

dev.off()
