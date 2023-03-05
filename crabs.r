# 1 -> 1/13
# 2..5 -> 2/13
# 6 -> 4/13

one_die <- function(){
    sample <- ceiling(sample(1:13))
    roll <- 0
    if (sample == 1) {
        roll <- 1
    } else if (sample == 2 || sample == 3) {
        roll <- 2
    } else if (sample == 4 || sample == 5) {
        roll <- 3
    } else if (sample == 6 || sample == 7) {
        roll <- 4
    } else if (sample == 8 || sample == 9) {
        roll <- 5
    } else {
        roll <- 6
    }
    print(roll)
    return(roll)
}

wins <- 0
n_rep <- 1000

for (i in 1:n_rep) {
    roll <- one_die() + one_die()
    if (roll == 7 || roll == 11) {
        wins <- wins + 1
    } else if (roll != 2 && roll != 3 && roll != 12) {
        point <- roll
        while (TRUE) {
            roll <- one_die() + one_die()
            if (roll == point) wins <- wins + 1
            if (roll == point || roll == 7) break
        }
    }
}
print(wins / n_rep)