library(shiny)
library(ggplot2)
library(devtools)
devtools::install_github("akshath-aks/Valmyndigheten")
library(Valmyndigheten)


ui<-fluidPage(

  titlePanel("Election results 2022"),
  sidebarLayout(
        sidebarPanel(
             selectInput("party",
                         label="Choose a party to display",
                         choices=c("Moderaterna",
                                   "Centerpartiet",
                                   "Liberalerna (tidigare Folkpartiet)",
                                   "Kristdemokraterna",
                                   "Arbetarepartiet-Socialdemokraterna",
                                   "Vänsterpartiet",
                                   "Miljöpartiet de gröna",
                                   "Sverigedemokraterna",
                                   "Övriga anmälda partier"),
                         selected="Moderaterna"),
             selectInput("type",
                         label="Choose a stastistic type to display data for each political party",
                         choices=c("voices 2022",
                                   "shares 2022",
                                   "Diff voices",
                                   "Diff shares",
                                   "voices 2018",
                                   "shares 2018",
                                   "mandate 2022",
                                   "diff mandate",
                                   "mandate 2018",
                                   "voices 2022(a)",
                                   "shares 2022(a)",
                                   "Diff voices(a)",
                                   "Diff shares(a)",
                                   "voices 2018(a)",
                                   "shares 2018(a)",
                                   "mandate 2022(a)",
                                   "diff mandate(a)",
                                   "mandate 2018(a)"
                                   ),
                         selected="voices 2022")
                    ),
                                  
        mainPanel(
           textOutput("selected_result"),
           plotOutput("distplot")
                  )
  )
)

server<-function(input,output){
  output$selected_result<- renderText({ 
    party_data<-result_combined[which(result_combined$parties==input$party),"voices 2022"]
    paste("You have selected this",input$party,"party.",input$party,"received",party_data,"votes this year.")
  })
  output$distplot<-renderPlot({
   ggplot(data=result_combined,aes(x=parties,y=get(input$type)))+
      geom_bar(stat='identity',fill="blue",color="black")+
      ylab(input$type)+
      theme(axis.text.x = element_text(angle=45, vjust=1., hjust=1))
  })
}
shinyApp(ui=ui,server=server)