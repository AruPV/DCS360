library(simEd)
library(glue)


for (i in seq(5)){
    single_server <- ssq(maxArrivals = 10000,
                        saveAllStats = FALSE,
                        saveWaitTimes = TRUE,
                        saveSojournTimes = TRUE,
                        showOutput = FALSE,
                        showProgress = FALSE)
    print(glue("Iteration {i}"))
    print(glue("avgSojour: {single_server$avgSojourn}"))
    print(glue("avgWait: {single_server$avgWait}"))
    print(glue("Utilization: {single_server$utilization}"))
}
