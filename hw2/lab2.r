library(simEd)

#gamma values
svc_1 <- c(1.0, 0.9)
svc_2 <- c(1.05, 0.9)
svc_3 <- c(1.1, 0.9)

#gamma service functions
get_svc_1 <- function() {rgamma(1, shape = 1.0, scale = 0.9) }
get_svc_2 <- function() {rgamma(1, shape = 1.05, scale = 0.9) }
get_svc_3 <- function() {rgamma(1, shape = 1.1, scale = 0.9) }

#Funtion that returns a vector of length num_costumers
#with the averages up to each customer
one_average_sojourn <- function(seed = 424277,
                                num_costumers = 1000,
                                funct = NA) {

    queue <- ssq(maxDepartures = num_costumers,
                saveSojournTimes = TRUE,
                showOutput = FALSE,
                seed = seed,
                serviceFcn = funct)

    average_sojourns <- vector(length = num_costumers)
    cumulative_sojourn <- 0

    for (job in 1:num_costumers){
        sojourn_time <- queue$sojournTimes[job]
        cumulative_sojourn <- cumulative_sojourn + sojourn_time
        average_sojourns[job] <- cumulative_sojourn / job
    }

    return(average_sojourns) #vector of one seed's sojourns

}

#function that calls the one_average_sojourn as many times as there are seeds
get_average_sojourns <- function(seeds = c(424277, 267231, 416655),
                                funct = NA,
                                num_costumers = 1000) {

    average_sojourns <- matrix(nrow = length(seeds), ncol = num_costumers)

    for (i in seq_along(seeds)){
        print(c("Calculating seed:", seeds[i]))
        temp <- one_average_sojourn(seed = seeds[i],
                                    num_costumers = num_costumers,
                                    funct = funct)
        average_sojourns[i, ] <- temp
        print(c("Done Calculating seed:", seeds[i]))
    }
    return(average_sojourns) #matrix of 3 seed's sojourns

}

#draws one plot each row in matrix having a different line/dots
draw_plot <- function(average_sojourns,
                    funct_val = c(NA, NA),
                    seeds = c(424277, 267231, 416655)) {

    print("Starting Plot")
    if (is.na(funct_val[1])) {
        print("Defining exponential theoretical")
        theoretical_sojourn <- 1 / ((10 / 9) - 1)
    } else {
        print("Defining gamma theoretical")
        theoretical_sojourn <- (1 / ((1 / (funct_val[1] * funct_val[2])) - 1))
    }

    max_y <- max(average_sojourns) + 4
    pdf(file = "G:/My Drive/DCS/Modeling and Simulation/hw2/exponential.pdf")
    plot(NA,
        xlim = c(0, length(average_sojourns[1, ])),
        ylim = c(0, max_y),
        xlab = "Jobs Completed",
        ylab = "Average Service Time",
        main = "Convergence of Exponential Service Function")
    print("Empty plot drawn")
    colors <- c("#0e1da5", "#026802", "#840808")

    for (i in seq_along(average_sojourns[, 1])){

        points(average_sojourns[i, ], type = "l", col = colors[i], lwd = 2)

    }
    print("All points drawn")
    abline(h = theoretical_sojourn, col = "#000000", lwd = 2, lty = 2)

    legend("topleft",
        legend = c("Theoretical mean", seeds),
        col = c("black", colors),
        lty = c(2, 1, 1, 1),
        lwd = 2)

    dev.off()

}

one_plot <- function(funct = NA,
                    funct_val = NA,
                    seeds = c(42427, 26721, 41655),
                    num_costumers = 1000) {

    average_sojourns_matrix <- get_average_sojourns(num_costumers = num_costumers,
                                                    seeds = seeds,
                                                    funct = funct)
    draw_plot(average_sojourns_matrix, funct_val = funct_val, seeds = seeds)

}

get_plots <- function(num_costumers = 50000) {
    par(mfrow = c(2, 2))
    print("Starting plot 1")
    one_plot()
    print("Starting plot 2")
    one_plot(funct = get_svc_1,
            funct_val = svc_1,
            num_costumers = num_costumers)
    print("Starting plot 3")
    one_plot(funct = get_svc_2,
            funct_val = svc_2,
            num_costumers = num_costumers)
    print("Starting plot 4")
    one_plot(funct = get_svc_3,
            funct_val = svc_3,
            num_costumers = num_costumers)
}

one_plot(num_costumers = 1000000)