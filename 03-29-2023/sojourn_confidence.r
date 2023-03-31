library(simEd)

ylo <- 0
yhi <- 100

# Plot empty graph
plot(NA, NA, xlim= c(1, 100), ylim = c(ylo,yhi),
    bty = "n", xaxt = "n",
    xlab = "", ylab = "", las = 1)
exact <- 244 / 495
abline(h = exact)

#Plot each line

for (i in seq(1:100)){
    print(icuGetCollate())
    num_costumers <- 10000

    queue <- ssq(maxDepartures = num_costumers,
                saveSojournTimes = TRUE,
                showOutput = FALSE)

    queue_sojourns <- queue$sojournTimes[1000:10000]

    batch_sojourns <- NA
    for(n in seq(1:100)){
        actual_num_costumers <- 10000 - 1000
        batch_start <- (actual_num_costumers / 100) * (n - 1)
        batch_end <- (actual_num_costumers / 100) * (n)
        append(batch_sojourns, mean(queue_sojourns[batch_start:batch_end]))
    }
    ci <- t.test(batch_sojourns, conf.level = 0.95)
    col <- "black"
    if (ci$conf.int[1] > exact || ci$conf.int[2] < exact){col <- "red"}
    segments(i, ci$conf.int[1], i, ci$conf.int[2], col = col)

}

values <- sapply(1:9, function(i) {craps(100, showProgress = FALSE)})

ci <- t.test(values, conf.level = 0.95)
segments(1, ci$conf.int[1], 1, ci$conf.int[2])