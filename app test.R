library(shiny)
ui<-navbarPage("Model Developement by Sampath and Hruday",
               tabPanel("Train data Import",
                        sidebarLayout(sidebarPanel( fileInput("file1","Upload your CSV",multiple = FALSE),
                                                    tags$hr(),
                                                    h5(helpText("Select the read.table parameters below")),
                                                    checkboxInput(inputId = 'header', label = 'Header', value = FALSE),
                                                    checkboxInput(inputId = "stringAsFactors", "stringAsFactors", FALSE),
                                                    radioButtons(inputId = 'sep', label = 'Separator', 
                                                                 choices = c(Comma=',',Semicolon=';',Tab='\t', Space=''), selected = ',')
                        ),
                        mainPanel(uiOutput("tb1"))
                        ) ),
               tabPanel("Test data Import",
                        sidebarLayout(sidebarPanel( fileInput("file2","Upload your CSV",multiple = FALSE),
                                                    tags$hr(),
                                                    h5(helpText("Select the read.table parameters below")),
                                                    checkboxInput(inputId = 'header', label = 'Header', value = FALSE),
                                                    checkboxInput(inputId = "stringAsFactors", "stringAsFactors", FALSE),
                                                    radioButtons(inputId = 'sep', label = 'Separator', 
                                                                 choices = c(Comma=',',Semicolon=';',Tab='\t', Space=''), selected = ',')
                        ),
                        mainPanel(uiOutput("tb2"))
                        ) ),
               tabPanel("Model Train",
                        sidebarLayout(sidebarPanel(
                          uiOutput("model_select"),
                          uiOutput("var1_select"),
                          uiOutput("rest_var_select")),
                          mainPanel( helpText("Your Selected variables"),
                                     verbatimTextOutput("other_val_show"))))
                                      
)
server<-function(input,output) { data1 <- reactive({
  Train <- input$file1
  if(is.null(Train)){return()} 
  read.table(file=Train$datapath, sep=input$sep, header = input$header, stringsAsFactors = input$stringAsFactors)
  
})
data2 <- reactive({
  Test <- input$file2
  if(is.null(Test)){return()} 
  read.table(file=Test$datapath, sep=input$sep, header = input$header, stringsAsFactors = input$stringAsFactors)
  
})
output$table1 <- renderTable({
  if(is.null(data())){return ()}
  data1()
})
output$table2 <- renderTable({
  if(is.null(data())){return ()}
  data2()
})
output$tb1 <- renderUI({
  tableOutput("table1")
})
output$tb2 <- renderUI({
  tableOutput("table2")
})
output$model_select<-renderUI({
  selectInput("modelselect","Select Algo",choices =   c("Logistic_reg"="logreg"))
})
output$var1_select<-renderUI({
  selectInput("ind_var_select"," Select Dependent Var", choices =as.list(names(data1())),multiple = FALSE)
})
output$rest_var_select<-renderUI({
  checkboxGroupInput("other_var_select","Select other Var",choices =as.list(names(data1())))
})
output$other_val_show<-renderPrint({
  input$other_var_select
  input$ind_var_select
  f<-data1()
  
  library(caret)
  form <- sprintf("%s~%s",input$ind_var_select,paste0(input$other_var_select,collapse="+"))
  print(form)
  
  logreg <-glm(as.formula(form),family=binomial(),data=f)
  print(summary(logreg))
  f1<-data2()
  pred=predict(logreg,newdata = f1)
  pred
  y_pred=ifelse(pred > 0.75,1,0)
  
  print("Final predictions 1month=1 and 0 =3months")
  y_pred

})
}
shinyApp(ui=ui,server=server)