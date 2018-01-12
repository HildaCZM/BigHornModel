parameters<-c(Environmental.Policy = 0.0 , # [1] 0: current policy, 1: response type 1, 2: response type 2 and 3: response type 3
              Birth.Rate.base = 0.03646399, # [%/año] population estimation based on stable behavior over the last years with permits
              Death.Rate.base = 0.01, # [%/año]  population estimation based on stable behavior over the last years with permits
              Male.Proportion = 0.32 , # [%]  aerial survey 2016 (citation)
              Percentage.Use.BCS = 0.10, # [%], Mexican General Direction of Wildlife
              Base.Observation.Rate.Bighorn.BCS = 0.30, # [%], (observation rate =0.30,Lee,2003--,)
              Proportion.Permits.Ejido = 0.173, # [%], estimated considering that already 7 permits are assinged already
              Emigration.Rate.Base =0.01, # [%] exploratory paramater, feasible to estimate with nihce modeling to be developed in phase 2
              Immigration.Rate.Base =  0.007686171, # [%] estimando poblacional estable durante los ultimos años con permisos
              Area.Ejido = 5.5, # [km2x1000]
              Presence.Bighorn.Ejido.Initial = ((38/126)*(126/0.30))/5.529101 ,#[bighorn sheep/km2x1000]38=the number of observed sheep at the ejido Bonfil,176=the total observed sheep in BC ø
              Sighting.Bighorn.Ejido.Base = 7.9, # [borregos/hora de vuelo], aerial survey 2016 (citation)
              Beta0 = -0.9715 , # [borregos/año] los parámetros Beta se ajustaron para que la demenda sea igual a 7 (número de permisos disponibles)
              Beta1 = 0.9641499 , # [borregos/año]
              Beta2 = 0.4132071,  # [borregos/año]
              Beta3= 0.011 ,# [(borregos/año)/(borregos/hr.vuelo)]
              Beta4= 0.2 ,# [(borregos/año)/(usdx1000)]
              Sustainable.Management = 1, # [1]
              Status.Protection = 1, # [1]
              Mean.Price.Other.Permits = 90, #this is to be parameter
              Demand.Elasticity.Permit.Price = 1.5, # [%]
              Supply.Elasticity.Permit.Price = -1.5, # [%]
              Gasto.Asistencia.Convencion = 7.0, # [usdx1000/año] , ajustado a 70,000 usd para inversion, y 70,000 usd de ingreso de uma
              Tasa.Subsido = 100 , # [usdx1000/año] , ajustado a 70,000 usd para inversion, y 70,000 usd de ingreso de uma
              Gasto.UMA.Guia = 50.0 , # [usdx1000/año] , ajustado a 70,000 usd para inversion, y 70,000 usd de ingreso de uma
              Gasto.UMA.Vigilancia = 300 , # [usdx1000/año] , ajustado a 70,000 usd para inversion, y 70,000 usd de ingreso de uma
              Gasto.UMA.Manteminto.Habitat = 250 ) # [usdx1000/año] , ajustado a 70,000 usd para inversion, y 70,000 usd de ingreso de uma


InitialConditions <- c(Pop.Bighorn.BCS = 586.0 , # [bighorn sheep] Estimated as:176/0.30 Total.Pop=Observed.Pop/Observation.Rate; data (observation rate=0.30,Lee,2003--,), (Pop.Observed=176, aerial survey 2016 (citation needed))
                       Pop.Bighorn.Ejido = 126.00, # [bighorn sheep] ;(38/176)*(176/0.30) Pop.Observada.Ejido/Pop.Observada (Pop.Observada.Ejido = poblacion de ejido+Población La Purisima [aerial survey 2016])
                       Demand.Permit.Ejido = 10,
                       Price.Permit.Ejido = 70) # [usdx1000/bighorn sheep] revisar info de entrevista

times <- seq(0, #initial time # [yrs]
             30, # end time [yrs]
             0.5)#time step [yrs]

intg.method<-c("rk4") #Integration method: Classical Runge-Kutta 4th Order Integration.
