library(simEd)
arr_1 <- function() { vexp(1, rate = 1, stream = 1)}
arr_2 <- function() { vexp(1, rate = 11 / 10, stream = 1)}
svc_1 <- function() { vexp(1, rate = 10 / 9, stream = 2)}


### First Part
output_1 <- ssq(maxArrivals = 20,
                seed = 8675309,
                interarrivalFcn = arr_1,
                serviceFcn = svc_1,
                saveAllStats = TRUE,
                showOutput = FALSE)

output_2 <- ssq(maxArrivals = 20,
                seed = 8675309,
                interarrivalFcn = arr_2,
                serviceFcn = svc_1,
                saveAllStats = TRUE,
                showOutput = FALSE)


### Second Part
par(mfrow = c(2, 1))

indices <- seq_along(output_1$numInSystemT[output_1$numInSystemT <= 5])
plot(output_1$numInSystemT[indices], output_1$numInSystemN[indices],
    type = "s", xlim = c(0, 5), bty = "n", las = 1)

arrival_times <- cumsum(output_1$interarrivalTimes)
completion_times <- arrival_times + output_1$sojournTimes

abline(v = completion_times[4])

indices <- seq_along(output_2$numInSystemT[output_2$numInSystemT <= 5])
plot(output_2$numInSystemT[indices], output_2$numInSystemN[indices],
    type = "s", xlim = c(0, 5), bty = "n", las = 1)

arrival_times <- cumsum(output_2$interarrivalTimes)
completion_times <- arrival_times + output_2$sojournTimes

abline(v = completion_times[4])

# Two
# Three

print(sum(output_1$serviceTimes - output_2$serviceTimes))

