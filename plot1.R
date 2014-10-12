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

## Make histogram
png('plot1.png',
    width=480,
    height=480)

hist(data$Global_active_power,
     col='red',
     main='Global Active Power',
     xlab='Global Active Power (kilowatts)')

dev.off()
