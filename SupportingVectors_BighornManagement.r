parameters<-c(Environmental.Policy = 0.0 , # [1] 0: current policy, 1: response type 1, 2: response type 2 and 3: response type 3
              Birth.Rate.base = 0.03646399, # [%/año] population estimation based on stable behavior over the last years with permits [aerial survey data (Lee, 2016) open access data; and Lee, R. 1997. Status of bighorn sheep in Mexico. Desert Bighorn Council Transactions 41:79–80]
              Death.Rate.base = 0.01, # [%/año]  population estimation based on stable behavior over the last years with permits. Similar to bighorn sheep population death rate in a National Recreation Area in Montana, U.S.A (Roelle, 2004)
              Male.Proportion = 0.32 , # [%]  aerial survey 2016 (Lee, R. 2016. Aerial Survey. Bighorn sheep populatipon in Baja California Sur, Mexico (2016). Non published technical report)
              Percentage.Use.BCS = 0.10, # [%], Mexican General Direction of Wildlife
              Base.Observation.Rate.Bighorn.BCS = 0.30, # [%], (observation rate =0.30,[Lee, R., R. A. Medellin, R. E. Rominger, M. J. González, T. A. Espinoza, J. M. Segundo, C. Manterola y Piña, and F. M. Colchero. 2007. Borrego Cimarrón(Ovis canadensis).Pages 222–238 Talleres sobre conservación y uso sustentable  de  aves  y  mamíferos  silves-tres,  en  relación  con  las  Unidades  de  Conservación y Manejo de Vida Silvestre (UMA) en México. INECC-SEMARNAT-UPC, Mexico])
              Proportion.Permits.Ejido = 0.173, # [%], estimated considering that already 7 permits are assinged already
              Emigration.Rate.Base =0.01, # [%] exploratory paramater, feasible to estimate using the habitat suitability index as a proxy estimated with ecological nihce modeling (to be developed in phase 2)
              Immigration.Rate.Base =  0.007686171, # [%] estimating stable population in recent years with permits
              Area.Ejido = 5.5, # [km2x1000]
              Presence.Bighorn.Ejido.Initial = ((38/126)*(126/0.30))/5.529101 ,#[bighorn sheep/km2x1000]38=the number of observed sheep at the ejido Bonfil,176=the total observed sheep in BCS 
              Sighting.Bighorn.Ejido.Base = 7.9, # [bhsheep/hr of flight], aerial survey 2016 (Lee, R. 2016. Aerial Survey. Bighorn sheep populatipon in Baja California Sur, Mexico (2016). Non published technical report)
              Beta0 = -0.9715 , # [bhsheep/year] The Beta parameters were adjusted so that demand equals 7 (number of permits available)
              Beta1 = 0.9641499 , # [bhsheep/year]
              Beta2 = 0.4132071,  # [bhsheep/year]
              Beta3= 0.011 ,# [(bhsheep/year)/(bhsheep/hr.flight)]
              Beta4= 0.2 ,# [(bhsheep/year)/(usdx1000)]
              Sustainable.Management = 1, # [1]
              Status.Protection = 1, # [1]
              Mean.Price.Other.Permits = 90, #this is to be parameter (data from interviews to international experts in bighorn sheep auctions)
              Demand.Elasticity.Permit.Price = 1.5, # [%]
              Supply.Elasticity.Permit.Price = -1.5, # [%]
              Cost.Attendance.Convention = 7.0, # [usdx1000/year] , adjusted to 70,000 usd para inversion, y 70,000 usd de ingreso de uma
              Subsisdy.Rate = 100 , # [usdx1000/year] , adjusted to 70,000 usd for investment, and 70,000 usd of UMA income
              Cost.UMA.Guide = 50.0 , # [usdx1000/year] , adjusted to 70,000 usd para inversion, y 70,000 usd of UMA income
              Cost.UMA.Surveillance = 300 , # [usdx1000/year] , adjusted to 70,000 usd para inversion, y 70,000 usd of UMA income
              Cost.UMA.Habitat.Maintenence = 250 ) # [usdx1000/year] , adjusted to 70,000 usd para inversion, y 70,000 usd of UMA income


InitialConditions <- c(Pop.Bighorn.BCS = 586.0 , # [bighorn sheep] Estimated as:176/0.30 Total.Pop=Observed.Pop/Observation.Rate; data (observation rate=0.30, [Lee, R., R. A. Medellin, R. E. Rominger, M. J. González, T. A. Espinoza, J. M. Segundo, C. Manterola y Piña, and F. M. Colchero. 2007. Borrego Cimarrón(Ovis canadensis).Pages 222–238 Talleres sobre conservación y uso sustentable  de  aves  y  mamíferos  silves-tres,  en  relación  con  las  Unidades  de  Conservación y Manejo de Vida Silvestre (UMA) en México. INECC-SEMARNAT-UPC, Mexico]), (Pop.Observed=176, aerial survey 2016 ())
                       Pop.Bighorn.Ejido = 126.00, # [bighorn sheep] ;(38/176)*(176/0.30) Pop.Observada.Ejido/Pop.Observada (Pop.Observada.Ejido = poblacion de ejido+Población La Purisima [Lee, R. 2016. Aerial Survey. Bighorn sheep populatipon in Baja California Sur, Mexico (2016). Non published technical report])
                       Demand.Permit.Ejido = 10,
                       Price.Permit.Ejido = 70) # [usdx1000/bighorn sheep] data from interviews and surveys 

times <- seq(0, #initial time # [yrs]
             30, # end time [yrs]
             0.5)#time step [yrs]

intg.method<-c("rk4") #Integration method: Classical Runge-Kutta 4th Order Integration.
