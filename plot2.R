##
## Author: Chen Ye
## 

## download files to local and load into R
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url, destfile = "./exdata-data-NEI_data.zip", method = "curl")
#unzip(exdata-data-NEI_data.zip)


##
## Load "summarySCC_PM25.rds" and "Source_Classification_Code.rds" to R workspace
##
NEI <- readRDS("./summarySCC_PM25.rds")


##
## Filter "Baltimore City", Get each Year Emisson Sum; Create Data frame to store values
##
bc <- NEI[NEI$fips == "24510", ]
ems <- with(bc, tapply(Emissions, year, sum, na.rm=T))
BCEoY <- data.frame(Year=names(ems), SumEmissons=ems)

##
## Reset 
##
## This change made the plot3 legend showing full strings
##
png("./plot2.png")
par(mfrow=c(1,1))


##
## Draw plot nad dump to PNG file
##

with(BCEoY, plot(as.Date(as.character(Year), "%Y"), SumEmissons, xlab="Year", pch=20))
title(main="PM2.5 of the Baltimore City")
dev.off()


##
## Cleanup
##
#rm(url, NEI, ems, BCEoY)
rm(NEI, bc, ems, BCEoY)