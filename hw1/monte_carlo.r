#Function that rolls X number of dice. Returns sum
roll_dice <- function(dice_amount = 3) {
  dice_sum <- 0
  for (x in 1:dice_amount) {
    die <- sample(1:6, 1)
    dice_sum <- dice_sum + die
  }
  return(dice_sum)
}

#Function that rolls three X dice Y amount of times and
#returns probability that the sum equals z

one_prob <- function(dice_amount = 3, roll_amount = 1000, desired_num = 10) {
  desired_tally <- 0
  for (x in 1:roll_amount){
      die_sum <- roll_dice(dice_amount)
      if (desired_num == die_sum) {
        desired_tally <- desired_tally + 1
      }
  }
  return(desired_tally / roll_amount)
}

#Function that returns the probability estimate for
# a certain number of rolls

total_prob <- function(
  dice_amount = 3, roll_amount = 1000, desired_num = 10, estimates_num = 1000) {
  estimates <- vector("integer", estimates_num)
  for (y in 1:estimates_num){
    estimates[y] <- one_prob(dice_amount, roll_amount, desired_num)
  }
  return(estimates)
}

#Function that returns a histogram from a probability dist
# and prints the quantiles at .5 .75 .95 .99

one_histogram <- function(prob_dist, title = "A Histogram") {
  hist(prob_dist, xlim = c(0.05, 0.2), main = title)
  m <- mean(prob_dist)
  abline(v = m, col = "blue", lwd = 2)
  s <- sd(prob_dist)
  abline(v = c(m - 2 * s, m + 2 * s), col = "#ff0000", lwd = 2, lty = "dashed")
  print(quantile(prob_dist, probs = c(.5, .75, .95, .99)))
}

par(mfrow = c(2, 3))
one_histogram(total_prob(roll_amount = 10), "10 Rolls & 1000 Estimates")
one_histogram(total_prob(roll_amount = 100), "100 Rolls & 1000 Estimate")
one_histogram(total_prob(roll_amount = 1000), "1000 Rolls & 1000 Estimate")

one_histogram(total_prob(estimates_num = 10), "1000 Rolls & 10 Estimates")
one_histogram(total_prob(estimates_num = 100), "1000 Rolls & 100 Estimates")
one_histogram(total_prob(estimates_num = 1000), "1000 Rolls & 1000 Estimates")
