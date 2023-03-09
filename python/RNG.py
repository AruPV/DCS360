from numpy.random import MT19937, Generator
import numpy.typing

class RNG:

    #Class level variables
    _streams: list[numpy.random.Generator]
    _initialized: bool = False
    _seed: numpy.int64 = None

    @classmethod
    def setSeed(cls, seed: numpy.int64) -> None:
        cls._seed = seed
        cls.initializeStreams()

    @classmethod
    def initializeStreams(cls) -> None:
        cls._streams = []
        rng = MT19937(cls._seed) # constructs a Mersenne Twister with appropriate seed
        for i in range(25):
            cls._streams.append(Generator(rng.jumped(i)))
        cls._initialized = True    

    @classmethod
    def geometric(cls, p: float, which_stream: int) -> numpy.int64:
        if not (cls._initialized):
            cls.initializeStreams()
        generator = cls._streams[which_stream]
        return generator.geometric(p)

def main() -> None:
    stream = 0
    for i in range(10000):
        print(RNG.geometric(0.2, stream))

if __name__ == "__main__":
    main()