"""
[*args] Write a Python function that takes an arbitrary number of positional
arguments and returns the sum of all the numbers. Test your function with various
input cases.
"""

#########################################################

from typing import Union, List

def sum_of_numbers(*args: Union[int, float]) -> Union[int, float]:
    """
    Calculate the sum of all the input numbers.

    Args:
        *args (int or float): Any number of positional arguments.

    Returns:
        int or float: The sum of all the input numbers.
    """
    return sum(args)

def main():
    """
    Test the sum_of_numbers function with various input cases.
    """
    print(sum_of_numbers(1, 2, 3))  # Output: 6
    print(sum_of_numbers(10, 20, 30, 40, 50))  # Output: 150
    print(sum_of_numbers(2.5, 3.5, 4.5))  # Output: 10.5
    print(sum_of_numbers())  # Output: 0 (empty input)
    print(sum_of_numbers(100))  # Output: 100 (single number as input)
    print(sum_of_numbers(-1, -2, -3, -4))  # Output: -10 (negative numbers)

if __name__ == "__main__":
    """
    Call main function
    """
    main()