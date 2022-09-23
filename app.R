library(shiny)
library(readxl)
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
                                   "shares 2018"),
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
    paste("You have selected this",input$party,"party.",input$party,"received","votes this year.")
  })
  output$distplot<-renderPlot({
   ggplot(data=get_combined_data(),aes(x=party,y=input$type))+geom_histogram(fill="red",color="black")
  })
}
shinyApp(ui=ui,server=server)