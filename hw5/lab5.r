library(svMisc)

set.seed(5748239)

get_sbm_variate <- function(time) {
    return(rnorm(1, 0, sqrt(time)))
}

get_price_at_t <- function(time, stock) {
    deviation <- stock$deviation
    variance <- deviation^2
    price_at_t <- stock$price_0 * exp(
                                  (((stock$mean - variance) / 2) * time) +
                                  (deviation * get_sbm_variate(time))
    )
    return(price_at_t)
}

get_wealth_at_t <- function(time, ...) {
    stocks <- list(...)
    wealth_total <- 0

    for (stock in stocks) {
        stock_value <- stock$shares * get_price_at_t(time, stock)
        wealth_total <- wealth_total + stock_value
    }

    return(wealth_total)
}

plot_sbm <- function(total_time) {
    length <- 10000
    vect <- vector("numeric", length)
    time <- total_time * (1 / length)
    vect[1] <- get_sbm_variate(time)

    i <- 2
    while (i <= length) {
        time <- total_time * (i / length)
        vect[i] <- vect[i - 1] + get_sbm_variate(time)
        i <- i + 1
    }

    plot(vect, type = "l")
}

is_not_loss <- function(time, ...) {
    percentage <- (get_wealth_at_t(time, ...)) / (get_wealth_at_t(0, ...))
    ninety_percent <- percentage <= .9
    return(!ninety_percent)
}

one_win_probability <- function(time, iterations, ...) {
    wins <- 0
    for (i in seq(1:iterations)) {
        wins <- wins + is_not_loss(time, ...)
    }
    return(wins / iterations)
}

get_win_probabilities <- function(
    time,
    iterations_per_probability,
    probabilities,
    ...
) {
    probability_vector <- vector("numeric", length = probabilities)
    for (i in seq(1:probabilities)) {
        progress(value = 100 * (i / probabilities))
        temp <- one_win_probability(time, iterations_per_probability, ...)
        probability_vector[i] <- temp
    }
    return(probability_vector)
}

one_plot <- function(probabilities, time, iterations) {

    hist(probabilities, freq = TRUE,
                        main = toString(c("N =", iterations, "T=", time)),
                        xlab = "Probability of Loss",
                        ylab = "Frequency"
        )
    abline(v = mean(probabilities), col = "red", lwd = 2)
    quantiles <- quantile(probabilities, probs = c(.05, .95))
    abline(v = quantiles[1], col = "blue", lwd = 2, lty = 2)
    abline(v = quantiles[2], col = "blue", lwd = 2, lty = 2)

}

get_histogram <- function(time,
                          iterations_per_probability,
                          probabilities,
                          ...
) {
    probability_distribution <- get_win_probabilities(
        time = time,
        iterations_per_probability = iterations_per_probability,
        probabilities = probabilities,
        ...
    )

    one_plot(probabilities = probability_distribution, time, probabilities)
}

get_histograms <- function(...) {
    par(mfrow = c(2, 3))
    iterations <- 10000
    #I'm way too tired to make this a loop
    get_histogram(time = .5,
                  iterations_per_probability = iterations,
                  probabilities = 100,
                  ...
    )
    get_histogram(time = 1,
                  iterations_per_probability = iterations,
                  probabilities = 100,
                  ...
    )
    get_histogram(time = 2,
                  iterations_per_probability = iterations,
                  probabilities = 100,
                  ...
    )
    get_histogram(time = 1,
                  iterations_per_probability = iterations,
                  probabilities = 10,
                  ...
    )
    get_histogram(time = 1,
                  iterations_per_probability = iterations,
                  probabilities = 100,
                  ...
    )
    get_histogram(time = 1,
                  iterations_per_probability = iterations,
                  probabilities = 1000,
                  ...
    )
}

#Variable Instantiation

a_shares <- 100
a_deviation <- .20
a_mean <- .15
a_price_0 <- 100

b_shares <- 100
b_deviation <- .18
b_mean <- .12
b_price_0 <- 75

time <- .5

stock_a <- list("shares" = a_shares,
                "deviation" = a_deviation,
                "mean" = a_mean,
                "price_0" = a_price_0
)

stock_b <- list("shares" = b_shares,
                "deviation" = b_deviation,
                "mean" = b_mean,
                "price_0" = b_price_0
)

get_histograms(stock_a, stock_b)