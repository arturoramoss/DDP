library(shiny)
library(googleVis)

genderPts <- function(gender){
  maxOptions <- 1
  gender/maxOptions
}

agePts <- function(age){
  ageLimits <- c(25,35,45,55,65)
  val <- 1
  for(i in 1:length(ageLimits)){
    if(age < ageLimits[i]){
      val <- (i-1)/(length(ageLimits)-1)
      break()
    }
  }
  val
}

statusPts <- function(status){
  maxOptions <- 3
  status/maxOptions
}

professionPts <- function(profession){
  maxOptions <- 2
  profession/maxOptions
}

incomePts <- function(income){
  Limits <- c(300,600,800,1000,1400)
  val <- 1
  for(i in 1:length(Limits)){
    if(income < Limits[i]){
      val<-(i-1)/(length(Limits)-1)
      break()
    }
  }
  val
}

explanation <- function(val){
  exp <-""
  if(val<31){
    exp <- "The subject is of high risk, the operation is rejected."
  }else if(val<61){
    exp <- "The subject is of medium risk, a guarantee is require to continue."
  }else{
    exp <- "The subject approves the requirements."
  }
}

shinyServer(
  function(input,output){
    score <-reactive({30*incomePts({input$income}) + 
              25*agePts({input$age}) + 
              10*genderPts({as.numeric(input$gender)}) + 
              20*professionPts({as.numeric(input$profession)}) + 
              15*statusPts({as.numeric(input$status)})})
    
    output$score <- renderPrint({score()})
    output$gauge <- renderGvis({gvisGauge(data.frame(Score=c(score()),des=c("Reject")),numvar = c("score"),labelvar = "des",
                                          options=list(min=0,max=100,redFrom=0,redTo=30,yellowFrom=31,yellowTo=60,greenFrom=61,greenTo=100))})
    output$expl <- renderText({explanation(score())})
    
  }
)