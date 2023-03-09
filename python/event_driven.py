import simulus
import random
###Homework 
# Get the following:
# 1) Utilization
# 2) Time average in queue
# 3) Time average in system

###

class QueueStats:
    num_in_system = 0
    total_arrivals = 0
    total_departures = 0
    last_event_time = 0
    total_area_queue = 0
    total_area_system = 0
    total_area_utilization = 0
    total_time_simulation = 0

    def show_stats(self):

        print(f"""# Arrivals: {self.total_arrivals}
                # Departures: {self.total_arrivals}
                # Arrivals: {self.total_arrivals}
                # in System  @ end : {self.num_in_system}
                TA #""")
    

def getInterarrival() -> float:
    return random.expovariate(1.0)

def getService() -> float:
    return random.expovariate(10/9)


def addArea(queue_stats: QueueStats) -> None:       # !!! TO BE CALLED BEFORE EVENT !!!
    num_in_system = queue_stats.num_in_system
    base = sim.now - queue_stats.last_event_time

    if queue_stats.num_in_system > 0:               #For time in system
        queue_area = base * (num_in_system-1)
        queue_stats.total_time_queue = queue_area
    
    system_area = base * num_in_system              #For time in queue
    queue_stats.total_time_system = system_area
    queue_stats.last_event_time = sim.now


def completionOfService(queue_stats: QueueStats, show_output: bool = True) -> None:
    queue_stats.total_departures += 1
    addArea(queue_stats)
    if show_output: print(f"COS @{sim.now}")        #print output
    queue_stats.num_in_system -= 1
    if (queue_stats.num_in_system != 0):
        sim.sched(completionOfService, queue_stats, show_output, offset = getService())

def arrival(queue_stats: QueueStats, show_output: bool = True) -> None:
    addArea(queue_stats)
    queue_stats.total_arrivals += 1
    if show_output: print(f"Arrival @{sim.now}")    #print output
    queue_stats.num_in_system += 1
    if queue_stats.num_in_system == 1:
        sim.sched(completionOfService, queue_stats, show_output, offset = getService())
    if queue_stats.total_arrivals < max_arrivals:
        sim.sched(arrival, queue_stats, show_output, offset = getInterarrival())
    else:
        queue_stats.total_time_simulation = sim.now


sim = simulus.simulator()
queue_stats = QueueStats()
max_arrivals = 100


def main() -> None:
    show_output = False
    sim.sched(arrival, queue_stats, show_output, offset = getInterarrival())
    sim.run()
    



if __name__ == "__main__":
    main()


