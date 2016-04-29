


plot1 <- function(filename = "household_power_consumption.txt")
{
    ############FOLLOWING CODE IS THE SAME FOR ALL SCRIPTS##################
    #Create the column classes to speed up reading in the file.
    colclasses <- c("character", "character", rep("numeric", 7))
    #Read the file.
    file <-
        read.csv(
            filename,
            sep = ";",
            colClasses = colclasses,
            stringsAsFactors = FALSE,
            na.strings = "?"
        )
    
    #filter on the necessary records before we do more intensive conversions to date.
    file  <- subset(file, Date %in% c("1/2/2007", "2/2/2007"))
    
    #Create a datetime column with Date and Time combined with the paste function.
    file$DateTime  <-
        strptime(paste(file$Date, file$Time), "%d/%m/%Y %H:%M:%S")
    
    ##################PLOT SPECIFIC CODE STARTS HERE##########################
    #Create the png device
    png(filename = "plot1.png", width = 480, height = 480)
    
    #Create the plot
    hist(
        file$Global_active_power,
        col = "Red",
        main = "Global active power",
        xlab = "Global Active Power (kilowatts)"
    )
    
    #close the device to finish writing
    dev.off()
    # and a small message to the user that the operation is succesful 
    print("plot1.png has been created")
    
}