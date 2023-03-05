Homework 1 for "DCS 307: Simulation"
====================================

Aru Poleo Vargas


OVERVIEW
--------

This is an assignment written for the class DCS 307. We were tasked with coding a simple
Monte Carlo simulation involving dice that would give out the probability of a sum of three 
dice being equal to 10. The program runs 6 different simulations, each with differing amounts 
of estimates and amounts of dice per estimate. It outputs a "Rplots.pdf" file with a histogram
for each of these different simulations, as well as the 50%, 70%, 95%, and 99% quantiles
to console. The histograms also show the mean of each simulation as a blue vertical line, and the
values two standard deviations away from the mean as red dotted lines.

FILES
-----

"monte_carlo.r" : The file containing the code in R
"Rplots.pdf" : The file output by the "monte_carlo.r" file that contains the histograms
"poleo_hw1_plot.jpg" : The same as "Rplots.pdf" but as a .jpg

ANALYSIS
--------

First row: For every simulation whose histogram is shown in the first row, the value for 
the estimates remains constant at a thousand and only the amount of rolls per estimate changes.

The first simulation only has ten rolls per each estimate, which led to a very statistically
insignificant result. The limits on the X axis cut off at least some values on the left, but 
given that we wanted all of the histograms to have the same limit, increasing the limit would
have made the ones at the bottom (which did show significant results) more difficult to read. 
The shape for this first histogram does not show any decipherable curve or pattern, it is
erratic and imprecise because of how small of a sample size was chosen for it. Interesting
enough, the line for the mean lands somewhat close to where the other simulation's mean landed,
but there were actually no estimates in this particular execution that actually landed close
to the mean value. The standard deviation lines are not evidenced in the histogram, potentially
being also cut off by the limits on the x axis.

The quantile output was also incoherent. It puts 50% at .1, 75% at .2, 95% at .3 and 99% at .5

The second histogram on the first row starts to more clearly show a bell curve (though
not as much as the other simulations). Interstingly, similar to the first histogram, some values 
are cut off by the limits on the x axis. We can see some evidence of this wide spread in the 
standard deviation lines, which land quite close to .05 and .20.

The quantile output for this simulation was closer to the expected values, but still very imprecise.
The 50% landed at .12, %75 at .14, 95% at .18, and 99% at 0.2. That being said, while the 50% is
quite close to the expected value, the higher values are still quite a lot higher than I would 
like.

The last histogram on this first line shows the most defined standard distribution	curve, with 
the mean almost directly on top of the peak. The standard deviation lines are also quite close 
to the mean, showing very little spread as the number of rolls got higher.

This is also evidence in the output to the console, with 50% landing at 0.125, the %75 at 0.132, 
95% at 0.14205, and 99% at 0.15. All really close to the mean and the expected value.

While the first histogram was close to indecipherable, a trend can clearly be evidence between
these three histograms. The data gets less spread out and closer to the mean the more rolls 
per estimate we added. In other words, we get a more precise measure of the probability that 
the sum of three dice equalsten.However, we also get a more defined curve. This is likely the 
result of outlier rolls having less of an effect on each of the estimates the more rolls there are.

Second Row: Now, this was really interesting. Unlike the first row where the increase of the 
variable meant a decrease in the spread of the data, here we start off already with quite a 
low spread. My theory is that each estimate having a large amount of rolls means that no estimate
is allowed to be much of an outlier. The changes we do see in the second row mostly relate to the
shapre of the curve. 

This pattern is also carried over to the quantiles, with the %50 quantile at 0.119m the 75% one at 
0.131, the 95% one at .13875, and the 99% at .15. This is quite similar to the quantile values in 
the last histogram of the first line. These values are also quite similar to the rest of the values
in this line, showing that there is not a lot of spread in the data after the rolls have been set to
1000. 

The first histogram does not resemble much of a bell curve at all, having most a somewhat linear, 
horizontal distribution of values on the right of the mean, and some variation on the left with
more values closer to the mean and less closer to the first standard distribution line. 

The second histogram shows something more akin to a bell curve, with most values again landing within
two standard distributions of the mean. Some of the values are still lower or higher than one could
expect, probably as a result of the low estimate amount.

The final histogram is almost identical to the last one in the first row, which is unsurprising given
that they both share the same starting conditions.

