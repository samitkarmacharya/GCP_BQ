import random


def PrintHello():
    return "Hello world!"


def PrintGoodbye():
    return "Goodbye!"


def ErrorRandomly():
    if random.choice([True, False]):
        raise ValueError("Error randomly")
