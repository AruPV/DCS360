import simulus
import random

###

class QueueStats:
    num_in_system = 0
    
###
## utilization
## time average in queue
## time average in system

def getInterarrival() -> float:
    return random.expovariate(1.0)

def getService() -> float:
    return random.expovariate(10/9)

def completionOfService(queue_stats: QueueStats, show_output: bool = True) -> None:
    if show_output: print(f"COS @{sim.now}")
    queue_stats.num_in_system -= 1
    if (queue_stats.num_in_system != 0):
        sim.sched(completionOfService, queue_stats, offset = getService())



def arrival(queue_stats: QueueStats, show_output: bool = True) -> None:
    if show_output: print(f"Arrival @{sim.now}")
    queue_stats.num_in_system += 1
    if queue_stats.num_in_system == 1:
        sim.sched(completionOfService, queue_stats, offset = getService())
    sim.sched(arrival, queue_stats, offset = getInterarrival())

sim = simulus.simulator()
queue_stats = QueueStats()

sim.sched(arrival, queue_stats, offset = getInterarrival())

max_time = 100
sim.run(max_time)

