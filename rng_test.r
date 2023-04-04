random_var <- read.table("G:/My Drive/DCS/Modeling and Simulation/DCS360/variates/geometric_var.txt", sep = ",")
random_var_dob <- (as.double(random_var))
hist(random_var_dob,
    freq = FALSE,
    main = "Histogram of geometric(p = 0.5) variates",
    xlab = "x",
    ylab = "f(x)",
    bty = "l")
points(
    dgeom(x = 0:5, prob = 0.5),
    col = "red",
    pch = 20)
print(dgeom(x = 0:5, prob = 0.5))
