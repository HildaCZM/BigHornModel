#Specify model directories
  dir.model<-"C:\\~..1\\BighornModel\\Scripts\\"
  dir.data<-"C:\\~..1\\BighornModel\\Data\\"

#Source model specification
  specification.file<-"ModelSpecification_BighornManagement_test2.r"
  source(paste(dir.model,specification.file,sep=""))

#Source supporting data vectors, including: model's parameters, initial conditions & integration method
  SupportingVectors.file<-"SupportingVectors_BighornManagement.r"
  source(paste(dir.model,SupportingVectors.file,sep=""))

#Source climate scenarios
  Climate.Scenarios.Table<-read.csv(paste(dir.data,"ClimateScenariosTable.csv",sep=""))
  Climate.Scenarios.Table$Climate.Scenario<-as.character(Climate.Scenarios.Table$Climate.Scenario)
#Set up experimental design for analysis
  Experimental.Design <- data.frame (
                                     RunID = c(1:6),
                                     FutureID = rep(c(1:3),2),
                                     Climate.Scenario = c("CEH_1.1","CEH_2.1","CEH_3.1"),
                                     Environmental.Policy = c(0,0,0,1,2,3),
                                     Resilience = c(rep("NO",3),rep("YES",3))
                                     )

#
# Run model accross experimental design
 library("deSolve")
 Experiment0<-apply(Experimental.Design,1,
      function(x) {
                  #Load corresponding climate scenario

                   Rainfall.Change.Scenario <<- approxfun( x = Climate.Scenarios.Table$Times[Climate.Scenarios.Table$Climate.Scenario==as.character(x['Climate.Scenario'])],
                                          y = Climate.Scenarios.Table$Rainfall.Change[Climate.Scenarios.Table$Climate.Scenario==as.character(x['Climate.Scenario'])],
                                          method = "linear",
                                          rule = 2);
                  #Load corresponding policy
                   parameters['Environmental.Policy']<-as.numeric(x['Environmental.Policy'])
                  #Run the model
                    out <- data.frame(ode(y = InitialConditions,
                                          times = times,
                               func = bighorn.model ,
                               parms = parameters,
                               method =intg.method )
                                       );
                  #Add specifications
                   out$RunID<-x['RunID'];
                   out$FutureID<-x['FutureID'];
                   out$Climate.Scenario<-x['Climate.Scenario'];
                   out$Resilience<-x['Resilience'];
                   return(out)
                    }
        )

#Rbind all results
  Experiment<-do.call('rbind',Experiment0)

#Save results of experiment to file
  write.csv(Experiment,paste(dir.data,"Output_vfinal.csv",sep=""),row.names=FALSE)
