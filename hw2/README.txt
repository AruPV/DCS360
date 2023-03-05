Lab 2 for "DCS 307: Simulation"
====================================

Aru Poleo Vargas


OVERVIEW
--------
My first time using the simEd library. This assignment asked us to run SSQ simulations with 3 different seeds and changing
the way we get service times to measure the impact on the performance of the system. The first graph (exponential.png) shows
the results for using an exponential function to get service times. All the other ones use gamma functions for the service times,
though the values are different between them. The K value for the first gamma function is 1, for the second is 1.05, and for
the third it is 1.1. For all simulations except the last one I used a sample size of 100,000 costumers serviced, while the last one
used 1,000,000.



FILES
-----

lab2.r : r source file
exponential.pdf : pdf of a graph of the simulation that used an exponential function for the service times
gamma_1.pdf : pdf of a graph of the simulation that used the gamma function with K = 1 for the service times
gamma_2.pdf : pdf of a graph of the simulation that used the gamma function with K = 1.05 for the service times
gamma_3.pdf : pdf of a graph of the simulation that used the gamma function with K = 1.1 for the service times


ANALYSIS
--------

The SSQ with the Exponential Function for the service times (M/M/1) was by far the one that performed the best. It very quickly
reached a state of convergence near the mean (with green being quite literally at the mean) and overall had a relatively low mean
(both actual and theoretical) of around 9 units of time. There was some "bursty" behaviour near the beginning of the simulation,
particularly in blue and red, but even these were still not too far above the theoretical mean

The second graph-- the first gamma graph-- behaved quite differently and much more erratically (expecially at the beginning). About
a quarter of the simulation through, blue experienced some bursty behaviour that led it to about the same height as the exponential,
but this lasted for much longer, only getting close to the theoretical mean at the 100,000 mark. The theoretical mean itself, however,
was equal to the exponential one (9)

In the second gamma graph we see some drastic changes. Though the shape of the curves themselves does look decevingly similar to 
those of the graph before, the actual service times are much higher. Bursty behaviour at the beginning of the simulation took the green
seed to a max of around 25 units of time. Overall, it maintained much more erratic for a longer period of time, and even when it did start to
level off at aroun the 100,000 job mark, it was still considerably higher than any of the graphs that came before at 12.

Unsurprisingly, the third gamma SSQ took the longes to reach a convergence. I ended up running it for 1,000,000 serviced costumers
and it still was not quite at convergence (though it had gotten closer). There was also a massive increase in the service time for
all seeds as well as the theoretical mean. While the second highest theoretical mean had gotten close to 14, for this one it was closer
to 100. That being said, both the green seed and the blue seed both ended up below the theoretical mean, while the red just barely
made it over almost at the end of the simulation. It is quite shocking to me that such a small difference in the shape variable
of the gamma curve (one that is not even too evident in the histogram we saw in class) drastically changes the resulting service.

Overall, I would say we can say three things that apply to all 4 of the simulations. At the very early states of the simulation, the average is 
quite low, almost certainly given by the very low amouont of constumers that have been serviced at this time, and the fact that no bursts have been
evidenced yet. Very quickly however the simulated mean for all three seeds rises way above the theoretical mean as a few bursts make a dramatic shift
in the small pool of costumers serviced. At this early stage, the behaviour is erratic, stochastic, and unpredictable. Slowly however, as more and more
costumers leave the queue, the mean for all three seeds drops down lower and lower closer to the theorized mean (sometimes undershooting it as was the
case for both the green seed and the blue seed in the last graph).