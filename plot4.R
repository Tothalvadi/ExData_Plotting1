




plot4 <- function(filename = "household_power_consumption.txt")
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
    png(filename = "plot4.png",
        width = 480,
        height = 480)
    
    #First we set up the graphical parameters
    par(mfrow = c(2, 2))
    
    #Create the 1st plot
    plot(
        file$DateTime,
        file$Global_active_power,
        type = "l",
        ylab = "Global Active Power",
        xlab = NA
    )
    #Create the 2nd plot
    plot(
        file$DateTime,
        file$Voltage,
        type = "l",
        ylab = "Voltage",
        xlab = "datetime"
    )
    
    #Create the 3rd plot
    #Yes, this is just a copy paste from plot3.R ;)
    #First we do sub_metering_1 and leave the color black
    plot(
        file$DateTime,
        file$Sub_metering_1,
        type = "l",
        ylab = "Energy sub metering",
        xlab = NA
    )
    #Next comes sub_metering_2 with the color red
    points(file$DateTime,
           file$Sub_metering_2,
           type = "l",
           col = "red")
    
    #finally we have sub_metering_3 with the color blue
    points(file$DateTime,
           file$Sub_metering_3,
           type = "l",
           col = "blue")
    
    #Next we add the legend
    legend(
        "topright",
        legend = colnames(file)[7:9],
        #Get the column names from the file variable
        lty = c(1, 1, 1),
        #1 means draw a line
        col = c("black", "blue", "red") #Write down the colors
    )
    
    #Create the 4th plot
    plot(
        file$DateTime,
        file$Global_reactive_power,
        type = "l",
        ylab = "global_reactive_power",
        xlab = "datetime"
    )
    
    #close the device to finish writing
    dev.off()
    # and a small message to the user that the operation is succesful
    print("plot4.png has been created")
    
}