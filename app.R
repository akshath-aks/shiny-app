library(shiny)
library(ggplot2)
library(devtools)
devtools::install_github('akshath-aks/Valmyndigheten')
library(Valmyndigheten)
result_combined<-get_combined_data()


ui<-fluidPage(

  titlePanel("Election results 2022"),
  sidebarLayout(
        sidebarPanel(
             selectInput("type",
                         label="Choose a stastistic type to display for political parties.",
                         choices=c(colnames(result_combined[-1])),
                         
                                   
                         selected="voices 2022")
                    ),
                                  
        mainPanel(
           plotOutput("distplot",height='500px')
                  )
  )
)

server<-function(input,output){
  type<-reactive({input$type})
  output$distplot<-renderPlot({
   ggplot(data=result_combined,aes(x=parties,y=get(type())))+
      geom_bar(stat='identity',fill="blue",color="black")+
      labs(title=type(),x='Parties',y="Count") +
      theme(axis.text.x = element_text(angle=45, vjust=1., hjust=1, face = 'bold',size=10)
            ,plot.title = element_text(hjust = 0.5, face = 'bold',size=25),
            axis.title = element_text(face='bold', size = 20))
  })
}
shinyApp(ui=ui,server=server)

