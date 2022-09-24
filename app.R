library(shiny)
library(ggplot2)
library(devtools)
library(Valmyndigheten)
result_combined<-get_combined_data()


ui<-fluidPage(

  titlePanel("Election results 2022"),
  sidebarLayout(
        sidebarPanel(
             selectInput("type",
                         label="Choose a stastistic type to display data for each political party",
                         choices=c("voices 2022",
                                   "shares 2022(%)",
                                   "Diff voices",
                                   "Diff shares(%)",
                                   "voices 2018",
                                   "shares 2018(%)",
                                   "mandate 2022",
                                   "Diff mandate",
                                   "mandate 2018",
                                   "voices 2022 including assembly districts",
                                   "shares 2022 including assembly districts(%)",
                                   "Diff voices including assembly districts",
                                   "Diff shares including assembly districts(%)",
                                   "voices 2018 including assembly districts",
                                   "shares 2018 including assembly districts(%)",
                                   "mandate 2022 including assembly districts",
                                   "Diff mandate including assembly districts",
                                   "mandate 2018 including assembly districts"
                                   ),
                         selected="voices 2022")
                    ),
                                  
        mainPanel(
           plotOutput("distplot")
                  )
  )
)

server<-function(input,output){
  output$distplot<-renderPlot({
   ggplot(data=result_combined,aes(x=parties,y=get(input$type)))+
      geom_bar(stat='identity',fill="blue",color="black")+
      labs(title=input$type,y="count") +
      theme(axis.text.x = element_text(angle=45, vjust=1., hjust=1)
            ,plot.title = element_text(hjust = 0.5))
  })
}
shinyApp(ui=ui,server=server)
