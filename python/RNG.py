from enum import Enum
from numpy.random import MT19937, Generator
import numpy.typing

#######################################################################################
class Stream(Enum):
    ''' RNG Streams

    Enumeration to identify different streams (one per stochastic component
    in the model) for the random number generator
    '''
    ARRIVAL    = 0
    COMPLETION = 1

#######################################################################################
class RNG:

    ''' Random Number Generator

    Wrapper around the numpy Mersenne Twister 19937 (MT19937)
    generator. It implements "Streams" which allow for multiple stochastic components
    to pull from different sets of pseudo-randomized numbers.
    '''
    #Class level variables
    _streams: list[numpy.random.Generator]
    _initialized: bool = False
    _seed: numpy.int64 = None

    #######################################################################################
    @classmethod
    def setSeed(cls, seed: numpy.int64) -> None:
        ''' Seed setter method.
            
        Sets seed to be used throughout the generator. It is intended to be called 
        before streams are initialized (It will have no effect on the streams if 
        called after).

            Args:
                seed: 
                    a numpy.int64 (numpy's version of a 65bit int) to be set as the seed.
            
            Returns: 
                Null
        '''
        cls._seed = seed
        cls.initializeStreams()

    #######################################################################################
    @classmethod
    def initializeStreams(cls) -> None:
        ''' Initializes streams for generator.
        
        Initializes different streams depending on the Streams class.
        In its original implementation it will create two streams (one for arrivals
        and one for completion of service)

            Returns: 
                Null
        '''
        cls._streams = []
        rng = MT19937(cls._seed) # constructs a Mersenne Twister with appropriate seed
        for i in range(len(Stream)):
            cls._streams.append(Generator(rng.jumped(i)))
        cls._initialized = True    

    #######################################################################################
    @classmethod
    def geometric(cls, p: float, which_stream: Stream) -> numpy.int64:
        ''' Get variate from geometric distribution

        Calculates and returns a variate from a geometric distribution.
        It's just a wrapper of numpy's Generator.geometric with streams added to it.
            
            Args:
                p:
                    Float of probability for the distribution
                which_stream:
                    Stream from which pseudo-random number will be generated

            Returns:
                A single variate as a numpy.int64
        '''
        if not (cls._initialized):
            cls.initializeStreams()
        generator = cls._streams[which_stream]
        return generator.geometric(p)

    #######################################################################################
    @classmethod
    def random(cls, which_stream: Stream) -> numpy.float64:
        ''' Get variate from linear distribution 0:1 (inclusive)

        Calculates and returns a variate from a linear distribution 0:1 (inclusive). 
        It's just a wrapper of numpy's Generator.random with streams added to it.
            
            Args:
                which_stream:
                    Stream from which pseudo-random number will be generated

            Returns:
                A single variate as a numpy.int64
        '''
        if not (cls._initialized):
            cls.initializeStreams()
        generator = cls._streams[which_stream]
        return generator.random()
    
    #######################################################################################
    @classmethod
    def randint(cls, a: int, b: int, which_stream: Stream) -> numpy.int64:
        ''' Get random integer from a:b (inclusive)

        Calculates and returns an integer from a:b (inclusive). 
        It's just a wrapper of numpy's Generator.integer with streams added to it.
            
            Args:
                a:
                    Int for bottom of range (inclusive)
                b:
                    Int for top of range (inclusive)
                which_stream:
                    Stream from which pseudo-random number will be generated

            Returns:
                A single variate as a numpy.int64
        '''
        if not (cls._initialized):
            cls.initializeStreams()
        generator = cls._streams[which_stream]
        return generator.integers(a, b, endpoint = True)
    
    #######################################################################################
    @classmethod
    def uniform(cls, a: float, b: float, which_stream: Stream) -> numpy.float64:
        ''' Get variate from linear distribution a:b (inclusive)

        Calculates and returns a variate from a linear distribution a:b (inclusive). 
        Calls the random method and then transforms it to get the range desired.
            
            Args:
                a:
                    bottom of range (inclusive)
                b:
                    top of range (incluside)
                which_stream:
                    Stream from which pseudo-random number will be generated

            Returns:
                A single variate as a numpy.int64
        '''
        zero_one = cls.random(which_stream)
        range_size = b-a
        variate = (zero_one * range_size) + a
        return variate

    #######################################################################################
    @classmethod
    def exponential(cls, mu: float, which_stream: Stream) -> numpy.float64:
        ''' Get variate an exponential distribution.

        Calculates and returns a variate from an exponential distribution. 
        A wrapper of numpy's Generator.exponential with streams added to it.

            Args:
                mu:
                    scale parameter
                which_stream:
                    Stream from which pseudo-random number will be generated

            Returns:
                A single variate as a numpy.int64
        '''
        if not (cls._initialized):
            cls.initializeStreams()
        generator = cls._streams[which_stream]
        return generator.exponential(mu)


    #######################################################################################
    @classmethod
    def gamma(cls, shape: float, scale: float, which_stream: Stream) -> numpy.float64:
        ''' Get variate a gamma distribution.

        Calculates and returns a variate from an gamma distribution. 
        A wrapper of numpy's Generator.gamma with streams added to it.

            Args:
                shape:
                    shape of gamme distribution
                scale:
                    scale of gamma distribution (defaults to 1 in numpy)
                which_stream:
                    Stream from which pseudo-random number will be generated

            Returns:
                A single variate as a numpy.int64
        '''
        if not (cls._initialized):
            cls.initializeStreams()
        generator = cls._streams[which_stream]
        return generator.gamma(shape, scale)

###################
def main() -> None:
    stream = 0
    for i in range(100):
        print(RNG.gamma(2, 2, stream))

if __name__ == "__main__":
    main()