#Specify output folder
  dir.output<-"C:\\Users\\L03054557\\Downloads\\"

#Define characteristics of climate scenarios

 Climate.Scenario <- c("CEH_1.1","CEH_2.1","CEH_3.1","CEH_4.1","CEH_5.1")
 Climate.signal.tendency <- c(-0.035,-0.02,0.008,-0.0055,-0.01)
 Amplitude.Rainfall.Change <- c(0.4,0.5,0.3,0.6,0.5)
 Period.Rainfall.Change <- c(0.11,0.2,0.15,0.1,0.4)
 Min.intertemporal.variation<-c(0.0,0.0,0.0,0.0,0.0)
 Max.intertemporal.variation<-c(0.2,0.2,0.2,0.2,0.2)

# Initial case
 set.seed(99999)
 Climate.Scenarios.Table<-data.frame(
                                    Times=Times,
                                    Climate.Scenario = Climate.Scenario[1],
                                    Rainfall.Change = Climate.signal.tendency[1]*Times+(1.0-Amplitude.Rainfall.Change[1]*sin(Period.Rainfall.Change[1]*Times))+runif(length(Times),Min.intertemporal.variation[1],Max.intertemporal.variation[1]) # Precip/Precip.historical.average
                                     )


#Remaining cases
for (i in 2:length(Climate.Scenario))
{
  iteration<-data.frame(
                        Times=Times,
                        Climate.Scenario = Climate.Scenario[i],
                        Rainfall.Change = Climate.signal.tendency[i]*Times+(1.0-Amplitude.Rainfall.Change[i]*sin(Period.Rainfall.Change[i]*Times))+runif(length(Times),Min.intertemporal.variation[i],Max.intertemporal.variation[i]) # Precip/Precip.historical.average
                      )
 Climate.Scenarios.Table<-rbind(Climate.Scenarios.Table,iteration)
}

#save climate scenarios to *.csv file
 write.csv(Climate.Scenarios.Table,paste(dir.output,"ClimateScenariosTable.csv",sep=""),row.names=FALSE)
