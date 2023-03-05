library(simEd)

initTimes <- function() {
    arrivalTimes      <<- c(15, 47, 71, 111, 123, 152, 232, 245, 99999)
    interarrivalTimes <<- c(arrivalTimes[1], diff(arrivalTimes))
    serviceTimes      <<- c(43, 36, 34, 30, 38, 30, 31, 29)
}

getInterarr <- function() {
    nextInterarr <- interarrivalTimes[1]
    interarrivalTimes <<- interarrivalTimes[-1] # remove 1st element globally
    return(nextInterarr)
}

getService <- function() {
    nextService <- serviceTimes[1]
    serviceTimes <<- serviceTimes[-1]  # remove 1st element globally
    return(nextService)
}

initTimes()

output <- ssq(maxArrivals = 8,
            interarrivalFcn = getInterarr,
            serviceFcn = getService,
            saveAllStats = TRUE)