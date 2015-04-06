#!/usr/bin/env python
# -*- coding: utf-8
"""Provides Fibonacci sequence generation utilities."""


def sequence(count):
    """Returns a list of Fibonacci numbers.

    Args:
        count (int): The number of Fibonacci numbers to return.

    Returns:
        list: A list of Fibonacci numbers.

    Examples:
        >>> sequence(5)
        [0, 1, 1, 2, 3]
        >>> sequence(9)
        [0, 1, 1, 2, 3, 5, 8, 13, 21]
        >>> sequence(-1)
        []
    """
    return [i for i in xsequence(count)]


def xsequence(count, iteration=0, current=1, future=0):
    """Returns a generator that produces Fibonacci numbers.

    This function allows setting a custom starting position via the
    ``iteration``, ``current``, and ``future`` parameters.

    .. warning::

        No validation is performed on the custom ``iteration``, ``current``,
        and ``future`` parameters. You should be certain that these values
        are valid Fibonacci sequence numbers prior to utilization.

    Args:
        count (int): The total number of Fibonacci numbers to return.
        iteration (int, optional): Which iteration to start processing.
        current (int, optional): The initial seed value. Default 1.
        future (int, optional): The next value in the sequence. Default 0.

    Yields:
        int: The next Fibonacci number in the sequence.

    Examples:
        >>> [i for i in xsequence(5)]
        [0, 1, 1, 2, 3]
        >>> [i for i in xsequence(9)]
        [0, 1, 1, 2, 3, 5, 8, 13, 21]
        >>> [i for i in xsequence(-1)]
        []
    """
    while iteration < count:
        current, future = future, current + future
        iteration += 1
        yield current


if __name__ == '__main__':
    import doctest
    doctest.testmod()
