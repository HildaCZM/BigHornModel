bighorn.model <- function(t, state, parameters) {
  with(as.list(c(state,parameters)), {
# Auxiliary Variables
    Observation.Rate.Bighorn.BCS<-Base.Observation.Rate.Bighorn.BCS # [bighorn sheep/year]
    Pop.Observed.Males.Bighorn.BCS<-Observation.Rate.Bighorn.BCS*Male.Proportion*Pop.Bighorn.BCS #[bighorn sheep]
    General.Use.Rate.BCS<-(Pop.Observed.Males.Bighorn.BCS/Base.Observation.Rate.Bighorn.BCS)*Percentage.Use.BCS #[bighorn sheep/year]
    Presence.Bighorn.Ejido<-Pop.Bighorn.Ejido/Area.Ejido # [bighorn sheep/km2x1000]
    Presence.Change.Bighorn.Ejido<-Presence.Bighorn.Ejido/Presence.Bighorn.Ejido.Initial#[%]
    Effect.Bighorn.Presence.Change.Ejido.at.Sighting<-approx(c(0.0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8,2.0,100),
                                                              c(0.0,0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8,2.0,2.0), xout =Presence.Change.Bighorn.Ejido)$y # [%]
                                                              # x= presence change, where 1 is the original presence or base presence
                                                              # y= probability of sighting. The effect is lineal
    Sighting.Bighorn.Ejido<-Sighting.Bighorn.Ejido.Base*Effect.Bighorn.Presence.Change.Ejido.at.Sighting #[bighorn sheep/hr.flight]
#Model Permits Demand
    Price.Permit.Relative<-Mean.Price.Other.Permits/Price.Permit.Ejido #
    Base.No.Permits.Ejido<-ifelse(Pop.Bighorn.Ejido>General.Use.Rate.BCS*(Proportion.Permits.Ejido),General.Use.Rate.BCS*(Proportion.Permits.Ejido),Pop.Bighorn.Ejido) #[bighorn sheep/year]

#Flow variables UMA
if ( Environmental.Policy== 0)
  {
    No.Permits.Ejido <- Base.No.Permits.Ejido #[bighorn sheep/year]
    Specie.Introduction <-0.0 #[bighorn sheep/year]
  } else if ( Environmental.Policy== 1)  {
    No.Permits.Ejido <-1.15
    Specie.Introduction <-ifelse(t<20,ifelse(t<10,5,10),15) #[bighorn sheep/year]
  } else if ( Environmental.Policy== 2) {
    No.Permits.Ejido <-ifelse(t<20,Base.No.Permits.Ejido*0.5,Base.No.Permits.Ejido*0.75)
    Specie.Introduction <-1.0 #[bighorn sheep/year]
  } else if ( Environmental.Policy== 3) {
    No.Permits.Ejido <-Base.No.Permits.Ejido*1.5 #[bighorn sheep/year]
    Specie.Introduction <-0.0 #[bighorn sheep/year]
  }
    Supply.Permit.Ejido<-No.Permits.Ejido # [bighorn sheep/year]
    Used.Permits.Ejido<-min(Demand.Permit.Ejido,Supply.Permit.Ejido) # [bighorn sheep/year]
    Income.From.Permits<-Used.Permits.Ejido*Price.Permit.Ejido  # [usdx1000/year]
    Cost.Habitat.Management<-Cost.UMA.Guide+Cost.UMA.Surveillance+Cost.UMA.Habitat.Maintenence #[usdx1000/year]
    Operating.Costs.UMA<-Cost.Attendance.Convention+Cost.Habitat.Management-Subsisdy.Rate  #[usdx1000/year]
    Profitability.UMA<-Income.From.Permits-Operating.Costs.UMA # [usdx1000/year]

#Exogenous raainfall changes
    Rainfall.Change<-Rainfall.Change.Scenario(t) # Precip/Precip.historic.average
    Effect.Rainfall.Change.on.Emigration.Ejido<-max(100*exp(-4.6*Rainfall.Change),1.0)
    Effect.Rainfall.Change.on.Immigration.Ejido<-0.5+1/(1+exp(-6*(Rainfall.Change-1)))
    Effect.Rainfall.Change.on.Deaths.BCS<-max(100*exp(-4.6*Rainfall.Change),1.0)
    Effect.Rainfall.Change.on.Births.BCS<-0.5+1/(1+exp(-6*(Rainfall.Change-1)))
#In Ejido
    Immigration.Rate<-Immigration.Rate.Base*Effect.Rainfall.Change.on.Immigration.Ejido # [%/year]
    Emigration.Rate<-Emigration.Rate.Base*Effect.Rainfall.Change.on.Emigration.Ejido # [%/year]
    Immigration.Bighorn.Ejido<-Pop.Bighorn.BCS*Immigration.Rate # [bighorn sheep/year]
    Emigration.Bighorn.Ejido<-Pop.Bighorn.Ejido*Emigration.Rate # [bighorn sheep/year]

#Flow variables BCS
    No.Permits.BCS <-max(General.Use.Rate.BCS*(1-Proportion.Permits.Ejido),0) # [bighorn sheep/year]
    Death.Rate<-Death.Rate.base*Effect.Rainfall.Change.on.Deaths.BCS #
    Birth.Rate<-Birth.Rate.base*Effect.Rainfall.Change.on.Births.BCS #hasta el estresor
    Deaths.BCS<-max(Pop.Bighorn.BCS*Death.Rate,0) # [bighorn sheep/year]
    Births.BCS<-max(Pop.Bighorn.BCS*Birth.Rate,0) # [bighorn sheep/year]
#State variables
    dPop.Bighorn.Ejido <- Immigration.Bighorn.Ejido-No.Permits.Ejido-Emigration.Bighorn.Ejido + Specie.Introduction  # bighorn sheep/year]
    dPop.Bighorn.BCS <- Births.BCS-Deaths.BCS-No.Permits.BCS #[bighorn sheep/year]
    dDemand.Permit.Ejido<-Beta0+Beta1*Sustainable.Management+Beta2*Status.Protection+Beta3*Sighting.Bighorn.Ejido+Beta4*Price.Permit.Relative # [bighorn sheep/year]
    dPrice.Permit.Ejido<-Demand.Permit.Ejido*( (1/Demand.Elasticity.Permit.Price)*(1/Demand.Permit.Ejido)*dDemand.Permit.Ejido+ (1/Supply.Elasticity.Permit.Price)*(1/Supply.Permit.Ejido)*dPop.Bighorn.Ejido*0.5)
    list(c(dPop.Bighorn.BCS,dPop.Bighorn.Ejido,dDemand.Permit.Ejido,dPrice.Permit.Ejido),
           Rainfall.Change = Rainfall.Change,
           Income.From.Permits = Income.From.Permits,
           No.Permits.Ejido = No.Permits.Ejido,
           Price.Permit.Relative = Price.Permit.Relative,
           No.Permits.BCS = No.Permits.BCS,
           Price.Permit.Ejido=Price.Permit.Ejido,
           Sighting.Bighorn.Ejido=Sighting.Bighorn.Ejido
          )
  })
}
