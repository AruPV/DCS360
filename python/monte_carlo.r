#Count the amount of trues in vector
true_count <- function(list) {
    count <- 0
    for (i in list) {
        count <- count + i
    }
    return(count)
}

#Recursive function that gets the probabilities of each amount of type I questions being picked # nolint: line_length_linter.
probability <- function(one_left,
                        two_left,
                        index = 1,
                        list, current_prob = 1,
                        debug_on = FALSE) {
    probabilities <- vector(mode = "numeric", length = 13)
    if (index == 13) {                   #End condition for recursion
        probabilities[true_count(list) + 1] <- probabilities[true_count(list) + 1] + current_prob # nolint: line_length_linter.
        return(probabilities)
    }

    qs_left <- (120 - (index - 1))       #Calculate number of qs left and probs
    prob_one <- (one_left / qs_left) * current_prob
    prob_two <- (two_left / qs_left) * current_prob

    list_one <- list
    list_one[index] <- TRUE
    list_two <- list
    list_two[index] <- FALSE

    #Picked 1
    probabilities <- probabilities + probability(one_left = (one_left - 1),
                                                two_left = two_left,
                                                index = index + 1,
                                                current_prob = prob_one,
                                                list = list_one)

    #Picked 2
    probabilities <- probabilities + probability(one_left = one_left,
                                                two_left = (two_left - 1),
                                                index = index + 1,
                                                current_prob = prob_two,
                                                list = list_two)

    return(probabilities)
}

#Gets a list of scores in letters and turns that into a number
letters_to_score <- function(score_list) {
    total_score <- 0
    for (score in score_list){
        individual_score <- switch(score,
                                "A" = 4,
                                "B" = 3,
                                "C" = 2,
                                "D" = 1,
                                "E" = 0)
        total_score <- total_score + individual_score
    }
    return(total_score)
}

get_one_score <- function(true_amount,
                    actual_probability,
                    count = 1,
                    current_letters = vector(mode = "character", length = 12)) {

    #Instantiate the vector of scores
    score_dist <- vector(mode = "numeric", length = 49)
    for (i in seq_along(current_letters)){
        current_letters[i] <- "E"
    }

    #End recursion case?
    if ((count == 13) || (actual_probability == 0)) {
        score <- letters_to_score(current_letters)
        score_dist[score + 1] <- actual_probability
        return(score_dist)
    }

    #Is this type I or type II. Set probabilities accordingly
    if (count <= true_amount) {               #Type I values
        a_prob <- .6
        b_prob <- .3
        c_prob <- .1
        d_prob <- 0
        e_prob <- 0
    } else {                                #Type II values
        a_prob <- 0
        b_prob <- .1
        c_prob <- .4
        d_prob <- .4
        e_prob <- .1
    }

    #Get each of the potential next combinations
    a_list <- replace(current_letters, count, "A")
    b_list <- replace(current_letters, count, "B")
    c_list <- replace(current_letters, count, "C")
    d_list <- replace(current_letters, count, "D")
    e_list <- replace(current_letters, count, "E")

    ### Continue recursion with each of the following possible letters
    #Got A
    a_dist <- get_one_score(true_amount = true_amount,
                actual_probability = actual_probability * a_prob,
                count = count + 1,
                current_letters = a_list)
    #Got B
    b_dist <- get_one_score(true_amount = true_amount,
                actual_probability = actual_probability * b_prob,
                count = count + 1,
                current_letters = b_list)
    #Got C
    c_dist <- get_one_score(true_amount = true_amount,
                actual_probability = actual_probability * c_prob,
                count = count + 1,
                current_letters = c_list)
    #Got D
    d_dist <- get_one_score(true_amount = true_amount,
                actual_probability = actual_probability * d_prob,
                count = count + 1,
                current_letters = d_list)
    #Got E
    e_dist <- get_one_score(true_amount = true_amount,
                actual_probability = actual_probability * e_prob,
                count = count + 1,
                current_letters = e_list)

    score_dist <- score_dist + a_dist + b_dist + c_dist + d_dist + e_dist
    print(score_dist)
    return(score_dist)
}

get_all_scores <- function(prob_dist) {

    score_dist <- vector(mode = "numeric", length = 49)
    for (i in seq_along(prob_dist)){
        score_dist <- score_dist + get_one_score(true_amount = i,
                                            actual_probability = prob_dist[i])
    }
    return(score_dist)
}

one_amount <- 90
two_amount <- 30

actual_combination <- vector(mode = "logical", length = 12)
probabilities <- probability(one_left = one_amount,
                            two_left = two_amount,
                            list = actual_combination)

print(get_all_scores(probabilities))