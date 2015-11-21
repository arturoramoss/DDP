library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Credit Risk Score"),
  sidebarPanel(
    p("This app calculate the credit risk of a person with his personal data."),
    p("Every category of the aspects has a hierarchy (bad to good) and every data aspect has a weight."),
    h4("Hierarchy (bad to good) and weights:"),
    p("Gender(10%) = 0:Male, 1:Female",br(),
        "Age(25%) = 0:[1-24], 1:[25-34], 2:[35-44], 3:[45-54], 4:[55-64], 5:[65-]",br(),
        "Status(15%) = 0:Single, 1:Divorced, 2:Widowed, 3:Married",br(),
        "Income(30%) = 0:[-299], 1:[300-599], 2:[600-799], 3:[800-999], 4:[1000-1399], 5:[1400-]",br(),
        "Profession(20%) = 0:{Student,Other}, 1:Entrepreneur, 2:Professional"),
    
    h3('Input data:'),
    radioButtons('gender','Gender',
                       c("Male"=0,
                         "Female"=1)),
    numericInput("age","Age",18,1,90),
    radioButtons('status','Status',
                 c("Single"=0,
                   "Married"=3,
                   "Divorced"=1,
                   "Widowed"=2)),
    numericInput("income","Income ($)",400,1),
    radioButtons('profession','Profession',
                 c("Student"=0,
                   "Professional"=2,
                   "Entrepreneur"=1,
                   "Other"=0)),
    
    submitButton('Analyse')
  ),
  mainPanel(
    h3('Result'),
    h4('Risk category'),
    htmlOutput("gauge"),
    textOutput("expl"),br(),
    h4("Description:"),
    p("The score has two cuts to make a desition:",br(),"Less than ", strong("30%")," to reject ",br(),"Between ",strong("30%")," and ",strong("60%"), " to analise deeply",br(),"MOre than ",strong("60%")," to approve.")
  )
))