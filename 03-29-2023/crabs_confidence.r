library(simEd)

ylo = 0
yhi = 1
plot(NA, NA, xlim= c(1, 100), ylim = c(ylo,yhi),
    bty = "n", xaxt = "n",
    xlab = "", ylab = "", las = 1)
exact <- 244/495
abline(h = exact)

for (i in seq(1:100)){

    values <- sapply(1:9, function(i) {craps(100, showProgress = FALSE)})
    ci <- t.test(values, conf.level = 0.95)
    col <- "black"
    if (ci$conf.int[1] > exact || ci$conf.int[2] < exact){col <- "red"}
    segments(i, ci$conf.int[1], i, ci$conf.int[2], col = col)

}

values <- sapply(1:9, function(i) {craps(100, showProgress = FALSE)})

ci <- t.test(values, conf.level = 0.95)
segments(1, ci$conf.int[1], 1, ci$conf.int[2])