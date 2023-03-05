set.seed(91219)

my_unif <- function(n, a, b) {
    counter <- 0
    variates <- vector(mode = "numeric", length = n)

    repeat {
        counter <- counter + 1
        y <- runif(1)
        m <- 1 / (b - a)
        x <- (y / m) + a
        variates[counter] <- x
        if (counter == n) {
            break
        }
    }

    return(variates)
}



test_unif <- function() {

    a <- 10
    b <- 20
    n <- 100000
    variates <- my_unif(n = n, a = a, b = b)
    hist(variates, freq = FALSE)
    #s';'seq <- seq((a - 1), (b + 1), length = (a - b))
    dif <- dunif(x = (a:b), min = a, max  = b)
    points(a:b ,dif, col = "red", type = "l")
    print(c("The theoretical mean is:", ((a + b) / 2)))
    print(c("The actual mean is:", mean(variates)))
    print(c("The theoretical standard deviation is:", ((b - a) / sqrt(12))))
    print(c("The actual standard deviation is:", sd(variates)))

    test <- dunif(x = (a:b), min = a, max  = b)
    print(length(test))

}

my_triang <- function(n, a, b, c) {
    counter <- 0
    variates <- vector(mode = "numeric", length = n)

    repeat {
        counter <- counter + 1
        y <- runif(1)
        x <- sqrt((2 * y * b * (c - a)) / 2) + a
        if (x > c && x < b) {
            z <- (- c + ((c - a - y * b) / 2)) * (2 * (b - c))
            print(z)
            x <- b + sqrt(z + (b * b) - (c * c))
        }
        variates[counter] <- x
        if (counter >= n){
            break
        }
    }
}

n <- 5
a <- 10
b <- 25
c <- 15

variates <- my_triang(n = n, a = a, b = b, c = c)