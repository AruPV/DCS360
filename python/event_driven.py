import simulus
import random
from RNG import RNG
from RNG import Stream

class QueueStats:
    num_in_system = 0
    total_arrivals = 0
    total_departures = 0
    last_event_time = 0
    total_area_queue = 0
    total_area_system = 0
    total_area_utilization = 0
    total_time_simulation = 0
    capacity = 2
    rejection_count = 0

    def show_stats(self) -> None:
        print(f"""
# Arrivals: {self.total_arrivals}
# Departures: {self.total_arrivals}
# Arrivals: {self.total_arrivals}
# in System  @ end: {self.num_in_system}
TA # System: {self.total_area_system/self.last_event_time}
TA # Queue: {self.total_area_queue/self.last_event_time}
Utilization: {self.total_area_utilization/self.last_event_time}""")
    

def getInterarrival() -> float:
    stream = Stream.ARRIVAL
    return RNG.exponential(1.0, stream)

def getService() -> float:
    """Determine the service time

    Generates a service time by calling getTaskAmount and then getting that many
    uniform variates

        Args:
            None
        Returns:
            A float of the service time
    """
    task_amount = getTaskAmount()
    total_time = 0.0
    stream = Stream.SERVICE_TIME
    for i in range(task_amount):
        total_time += RNG.uniform(which_stream = stream, a = 0.1, b = 0.2)
    return total_time

def getTaskAmount() -> int:
    """ Calculate number of tasks for a service

    Called prior to determining the service time. It returns the amount of 
    tasks to be performed (and thus the amount of variates to be generated for service time)

        Args:
            None
        Returns:
            Returns an int equal to 1+exponential(.1)
    """
    stream = Stream.SERVICE_PROCESS
    RNG.setSeed(seed = 1295472)
    extra_tasks = RNG.geometric(which_stream = stream, p = .1)
    return (1 + extra_tasks)


def addArea(queue_stats: QueueStats) -> None:       # !!! TO BE CALLED BEFORE EVENT !!!
    num_in_system = queue_stats.num_in_system
    base = sim.now - queue_stats.last_event_time

    if queue_stats.num_in_system > 0:               #For time in queue
        queue_area = base * (num_in_system-1)
        queue_stats.total_area_queue += queue_area
    
    system_area = base * num_in_system 
    queue_stats.total_area_system += system_area     #For time in system

    utilization_area = base * (num_in_system != 0)  #For utilization
    queue_stats.total_area_utilization += utilization_area

    queue_stats.last_event_time  = sim.now


def completionOfService(queue_stats: QueueStats, show_output: bool = True) -> None:
    queue_stats.total_departures += 1
    addArea(queue_stats)
    if show_output: print(f"COS @{sim.now}")        #print output
    queue_stats.num_in_system -= 1
    if (queue_stats.num_in_system != 0):
        sim.sched(completionOfService, queue_stats, show_output, offset = getService())

def arrival(queue_stats: QueueStats, show_output: bool = True) -> None:
    if show_output: print(f"Arrival @{sim.now}")    #print output

    #Deal with it as either reject or regular arrival
    if queue_stats.num_in_system == queue_stats.capacity:   #If reject
        if show_output: print(f"Arrival rejected @{sim.now}, There are {queue_stats.num_in_system} people in system and the capacity is {queue_stats.capacity}") 
        queue_stats.rejection_count += 1
    else:
        if show_output: print(f"Arrival accepted @{sim.now}")                                                    #If accepted
        addArea(queue_stats)
        queue_stats.total_arrivals += 1
        queue_stats.num_in_system += 1
        #Is this the only person in the system?
        if queue_stats.num_in_system == 1:
            sim.sched(completionOfService, queue_stats, show_output, offset = getService())
    
    #Does the loop continue?
    if queue_stats.total_arrivals < max_arrivals:
        sim.sched(arrival, queue_stats, show_output, offset = getInterarrival())
    else:
        queue_stats.total_time_simulation = sim.now


sim = simulus.simulator()
queue_stats = QueueStats()
max_arrivals = 10000


def main() -> None:
    show_output = True
    sim.sched(arrival, queue_stats, show_output, offset = getInterarrival())
    sim.run()
    queue_stats.show_stats()
    print(getTaskAmount())

if __name__ == "__main__":
    main()

#                simED                                              Python
#                                       Iteration 1
#       avgSojour: 7.3422253058348                      TA # System: 7.750992636812023
#       avgWait: 6.44997561733926                       TA # Queue: 6.867112249563992
#       Utilization: 0.894182966239025                  Utilization: 0.8838803872480965
#                                       Iteration 2
#       avgSojour: 9.15254991973473                     TA # System: 8.097060158814683
#       avgWait: 8.24024186912559                       TA # Queue: 7.202747600904905
#       Utilization: 0.900809635884688                  Utilization: 0.8943125579097858    
#                                       Iteration 3
#       avgSojour: 10.1229399708578                     TA # System: 9.14883081780474
#       avgWait: 9.22282552902887                       TA # Queue: 8.240112736808083
#       Utilization: 0.914456742021901                  Utilization: 0.9087180809966511
#                                       Iteration 4
#       avgSojour: 7.88416738484038                     TA # System: 7.737865121796885
#       avgWait: 6.99661352706361                       TA # Queue: 6.839616856284027
#       Utilization: 0.888739219623596                  Utilization: 0.8982482655128973
#                                       Iteration 5
#       avgSojour: 7.40476175161468                     TA # System: 6.801531700281764
#       avgWait: 6.51887427884657                       TA # Queue: 5.915983959847786
#       Utilization: 0.885179036966654                  Utilization: 0.8855477404339989
