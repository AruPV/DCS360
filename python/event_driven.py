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
    return random.expovariate(1.0)

def getService() -> float:
    return random.expovariate(10/9)


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
max_arrivals = 10000


def main() -> None:
    show_output = False
    sim.sched(arrival, queue_stats, show_output, offset = getInterarrival())
    sim.run()
    queue_stats.show_stats()

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
