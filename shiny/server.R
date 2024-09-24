source("functions/elu2mspec.R", local = TRUE)
source("functions/pepout2results.R", local = TRUE)
a <- "./pepsearch/MSPepSearch64.exe  dI /RI st10rST /LIB ./pepsearch/SearchLibraries/pyrolysis /HITS 5 /MinMF 700 /INP "
b <-" /OutCAS /OutNISTrn /OutChemForm /OutCE /OutInstrType /OutMW /PROGRESS /OUTTAB ./results/result.txt"


server <- function(input, output) {
  volumes = getVolumes()
  shinyFileChoose(input, 'elu', roots=volumes, filetypes=c('', 'elu'))
  observe({path <- parseFilePaths(volumes, input$elu)$datapath
  output$path <- renderText(print(gsub(".*/", "", path)))
  })

  observeEvent(input$elu2mspec, {
    elu2mspec(parseFilePaths(volumes, input$elu)$datapath)
    output$status1 <- renderText("converted")})

 
  observeEvent(input$pep, {
    cat(NULL, file = "./results/result.txt")
    write.csv(NULL, file = "./results/peaks.csv")
    write.csv(NULL, file = "./results/polymers.csv")
    path <- paste0("./data/", (gsub(".*/", "", parseFilePaths(volumes, input$elu)$datapath)))
    system(paste0(a,gsub("ELU","MSPEC",path),b))
    results <- pepout2result("./results/result.txt")
    pyro <- read.csv("./results/peaks.csv", header = TRUE)
    results <- read.csv("./results/polymers.csv", header = TRUE)
    output$mytable1 <- DT::renderDataTable(pyro)
    output$mytable <- DT::renderDataTable(results)
    
  })
}