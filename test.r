a_shares <- 100
a_deviation <- .20
a_mean <- .15
a_price_0 <- 100

get_SBM_variate <- function(time) {
    return(rnorm(1, 0, sqrt(time)))
}

get_price_at_t <- function(time, stock) {
    variance <- stock$deviation^2
    stock_exponential <- exp(((stock$mean - variance)/2) * time + stock$mean * get_SBM_variate(time))
    price_at_t <- stock$price_0 * stock_exponential
    return(price_at_t)
}

length <- 50
vect <- vector("numeric", length)
i <- 1
while(i<=length){
    t <- .5 * i/50
    variance <- a_mean^2
    
    vect[i] <- a_price_0 * exp((((a_mean - variance)/2) * t) + (a_deviation * get_SBM_variate(t)))
    i <- i+1
}

plot(vect, type = "l")
