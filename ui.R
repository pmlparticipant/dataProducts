library(shiny)

shinyUI(pageWithSidebar(
        headerPanel("TriangleDraw - an application that draws a triangle!"),
        sidebarPanel(
          h2("To draw a triangle please specify the lenghts of edges of the triangle."),
          h2("If you want the area of the triangle to be calculated, make sure to fill the check-box below."),
          h3("Lengths of edges:"),
          numericInput("a","Length of edge 'a':",3,min=0,max=100),
          numericInput("b","Length of edge 'b':",4,min=0,max=100),
          numericInput("c","Length of edge 'c':",5,min=0,max=100),
          checkboxInput("area","Calculate area?",FALSE),
          h2("To draw your triangle just click:"),
          submitButton("Draw!")
        ),
        
  mainPanel(
    h1("The Triangle Plot"),
    plotOutput("trianglePlot")
  )
))