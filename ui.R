library(shinyFiles)

ui <- fluidPage(
  titlePanel("Identify Polymers"),
  sidebarLayout(
    sidebarPanel(
           shinyFilesButton('elu', '*.elu file select', 'Please select an AMDIS ELU file', FALSE),
           
           textOutput("path"),
           
           actionButton("elu2mspec", "Convert ELU to MSPEC", class = "btn-success"),
           
           textOutput("status1"),
          
           actionButton("pep", "Polymer Search", class = "btn-success"),
           
           
            ), 
    mainPanel(
          DT::dataTableOutput("mytable"),
          DT::dataTableOutput("mytable1")
          )
    )
)