##
## Author: Chen Ye
## 

## download files to local and load into R
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url, destfile = "./exdata-data-NEI_data.zip", method = "curl")
#unzip(exdata-data-NEI_data.zip)
NEI <- readRDS("./summarySCC_PM25.rds")


##
## Get each Year Emisson Sum; Create Data frame to store values
##
ems <- with(NEI, tapply(Emissions, year, sum, na.rm=T))
EoY <- data.frame(Year=names(ems), SumEmissons=ems)

##
## Reset 
##
## This change made the plot3 legend showing full strings
##
png("./plot1.png")
par(mfrow=c(1,1))


##
## Draw plot nad dump to PNG file
##
with(EoY, plot(as.Date(as.character(Year), "%Y"), SumEmissons, xlab="Year", pch=20))
dev.off()


##
## Cleanup
##
#rm(url, NEI, ems, EoY)
rm(NEI, ems, EoY)