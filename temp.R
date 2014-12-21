strings <- matrix(nrow=length(labels),ncol=6)
strings[grep("^t",labels),1] <- "Time Domain :"
strings[grep("^f",labels),1] <- "Frequency Domain :"

strings[grep("mean\\(\\)",labels),2] <- "mean of the"
strings[grep("std\\(\\)",labels),2] <- "standard deviation of the"
#strings[grep("meanFreq\\(\\)",labels),2] <- "mean frequency of the"

strings[,3] <- ""
strings[grep("Mag",labels),3] <- "magnitude of the"

strings[grep("Acc",labels),4] <- "linear acceleration"
strings[grep("AccJerk",labels),4] <- "linear jerk"
strings[grep("Gyro",labels),4] <- "angular velocity"
strings[grep("GyroJerk",labels),4] <- "angular jerk"

strings[grep("Body{1}",labels),5] <- "by the body"
strings[grep("Gravity",labels),5] <- "by gravity"
strings[,6] = ""
strings[grep("\\-(X)$",labels),6] <- "along the X axis"
strings[grep("\\-(Y)$",labels),6] <- "along the Y axis"
strings[grep("\\-(Z)$",labels),6] <- "along the Z axis"

complete <- strings[complete.cases(strings),]

for(i in 1:nrow(complete))
  print(paste(complete[i,],collapse=" "))


#temp <- gsub("^f","Frequency Domain : ",temp)
#temp <- gsub(" -"," \\- ",temp)
#temp <- gsub("([XYZ]$)","\\1 Axis",temp)
#temp <- gsub('BodyAcc.*mean\\(\\)',"Mean Acceleration ", temp)
#temp <- gsub('BodyAcc.*std\\(\\)',"Standard Deviation Acceleration ", temp)
