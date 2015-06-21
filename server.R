library(shiny)

areaTextPointXcoordinate <- function(xb,xc) {
  out <- xb
  if(xc<0) {
    out <- xb+xc
  } else if(xc>xb) {
    out <- xc
  }
  out/2
}

shinyServer(
  function(input,output){

    output$trianglePlot <- renderPlot({
      a <-input$a
      b <- input$b
      c <- input$c
    
      if( c>a+b || a>b+c || b>a+c) {
        area <- 0
        plot(c(-10,10),c(-10,10),type="n",xlab="X",ylab="Y",main=sprintf("A triangle with edges\n(a,b,c) = (%.2f, %.2f, %.2f) DOES NOT EXIST",a,b,c),asp=1)
        text(0,0,"Note that the condition\nc<a+b && a<b+c && b<a+c\nneeds to be satisfied")
      } else {
        
        cosAlpha <-(a*a - c*c - b*b)/c/b/2
        if(a>b) {
          cosAlpha = -abs(cosAlpha)
        } else {
          cosAlpha = abs(cosAlpha)
        }
        sinAlpha <- sqrt(1 - cosAlpha*cosAlpha)
        
        xa <- 0
        ya <- 0
        xb <- c
        yb <- 0
        xc <- b*cosAlpha
        yc <- b*sinAlpha
        
        epsilon <- 0.05*min(c(a,b,c))
        plot(c(min(xc,0)-2*epsilon,max(xc,xb)+2*epsilon),c(-1,yc+2*epsilon),type="n",xlab="X",ylab="Y",main=sprintf("A triangle with edges\n(a,b,c) = (%.2f, %.2f, %.2f)",a,b,c),asp=1)
        polygon(x=c(0,xb,xc,0),y=c(0,yb,yc,0),col="orange",lty=3,lwd=5,border="red")
        
        text(-epsilon,0,"A")
        text(xb+epsilon,0,"B")
        text(xc,yc+epsilon,"C")
        text(xb+(xc-xb)/2+epsilon,yc/2,"a")
        text(xc/2-epsilon,yc/2,"b")
        text(xb/2,-epsilon,"c")
        if(input$area) {
          text(areaTextPointXcoordinate(xb,xc),yc/5,sprintf("Area = %.2f",xb*yc/2),font=4)
        }
    }
  })
}
)