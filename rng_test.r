random_var <- read.table("G:/My Drive/DCS/Modeling and Simulation/DCS360/variates/randint_var.txt", sep = ",")
random_var_dob <- (as.double(random_var))
hist(random_var_dob,
    freq = FALSE,
    main = "Histogram of randint(1:100) variates",
    xlab = "x",
    ylab = "f(x)",
    breaks = 100)
points(0:100,
    dunif(0:100),
    col = "red")